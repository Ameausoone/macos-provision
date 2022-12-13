#!/usr/bin/env zsh

# TODO gh extension install :
# https://github.com/davidraviv/gh-clean-branches


function gh_copy_issue(){
  if [ -z "${1}" ]; then
    issue=$(gh issue list --state closed --limit 100 | fzf --header='What issue do you want to copy ?' --preview 'gh issue view {1}' | awk '{print $1}')
  else
    issue="${1}"
  fi
  local issue_number="${issue}"
  local issue_title=$(gh issue view ${issue_number} --json 'title' --jq '.title')
  echo -e "- Copy of #${issue_number} \n\n $(gh issue view ${issue_number} --json 'body' --jq '.body')" | gh issue create --title "${issue_title}" --web --body-file=-
  echo "Then run git_cherry_pick_commit "
}

function git_cherry_pick_commit(){
  # First checkout on branch where to cherry-pick commit
  # choose branch main maintenance/v0.7.x of where to cherry-pick
  echo "First checkout on branch where to cherry-pick commit, ok ? (y/n)"
  read answer
  if [ "${answer}" != "y" ]; then
    return
  fi
  echo "What is the id of github issue for the cherry-pick ?"
  read issue_number
  issue_title=$(gh issue view ${issue_number} --json 'title' --jq '.title')

  echo "What is the id of github pull-request to cherry-pick ? "
  read pr_number

  initial_issue_branch=$(gh pr view ${pr_number} --json 'headRefName' --jq '.headRefName')

  issue_branch="cherry-pick/${issue_number}/${initial_issue_branch}"
  echo "Checkout on branch [${issue_branch}]"
  git checkout -B "${issue_branch}"

  echo "Select the branch: [main,maintenance/v0.x.x] where to cherry-pick commit ?"
  read branch
  echo "Fetch git branch : [${branch}]."
  git fetch origin "${branch}" "${branch}"

  echo "Cherry-pick commit from PR : [${pr_number}]"
  commit_to_cherry_pick=$(gh pr view ${pr_number} --json 'mergeCommit' --jq '.mergeCommit.oid')
  echo "Cherry-pick commit : [${commit_to_cherry_pick}]"
  git cherry-pick "${commit_to_cherry_pick}"

  git push --set-upstream origin "${issue_branch}"
  local pr_title="[Cherry-pick] $(gh pr view ${pr_number} --json 'title' --jq '.title')"
  echo -e "- Copy of #${pr_number} \n - Fix #${issue_number} \n\n $(gh pr view ${pr_number} --json 'body' --jq '.body')" | gh pr create --title "${pr_title}" --web --body-file=-
}
