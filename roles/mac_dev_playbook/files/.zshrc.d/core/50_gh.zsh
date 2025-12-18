#!/usr/bin/env zsh

eval "$(gh completion --shell zsh)"

function gh_copy_issue(){
  if [[ -z "${1}" ]]; then
    #issue=$(gh issue list --state closed --limit 100 | fzf --header='What is the issue that you want to copy ?' --preview 'gh issue view {1}' | awk '{print $1}')
    echo "What is the issue number that you want to copy ?"
    read issue
  else
    issue="${1}"
  fi
  if [[ -z "${2}" ]]; then
    echo "What is the target branch of the new issue ?"
    read target_branch
  else
    target_branch="${2}"
  fi
  issue_number="${issue}"
  issue_title=$(gh issue view ${issue_number} --json 'title' --jq '.title')
  issue_title="${issue_title} (target ${target_branch})"
  echo -e "- Copy of #${issue_number} \n\n $(gh issue view ${issue_number} --json 'body' --jq '.body')" | gh issue create --title "${issue_title}" --web --body-file=-
  echo "Then run git_cherry_pick_commit "
}

function git_cherry_pick_commit(){
  # First checkout on branch where to cherry-pick commit
  # choose branch main maintenance/v0.7.x of where to cherry-pick
  echo "First checkout the destination branch of the cherry-pick, ok ? (y/n)"
  read answer
  if [ "${answer}" != "y" ]; then
    return
  fi
  current_branch=$(git rev-parse --abbrev-ref HEAD)
  echo "Current branch is [${current_branch}]"
  echo "What is the id of github issue for the cherry-pick ?"
  read issue_number
  issue_title=$(gh issue view "${issue_number}" --json 'title' --jq '.title')

  echo "What is the id of merged github pull-request to cherry-pick ?"
  read pr_number

  initial_issue_branch=$(gh pr view ${pr_number} --json 'headRefName' --jq '.headRefName')

  issue_branch="cherry-pick/${issue_number}/${initial_issue_branch}"
  echo "Checkout on branch [${issue_branch}]"
  git checkout -B "${issue_branch}"

  #echo "Select the source branch : [main, maintenance/v0.7.x, maintenance/v0.8.x, ...] where to cherry-pick commit ?"
  #read branch
  #echo "Fetch git branch : [${branch}]."
  #git fetch origin "${branch}" "${branch}"

  echo "Cherry-pick commit from PR : [${pr_number}]"
  commit_to_cherry_pick=$(gh pr view ${pr_number} --json 'mergeCommit' --jq '.mergeCommit.oid')
  echo "Cherry-pick commit : [${commit_to_cherry_pick}]"
  git cherry-pick "${commit_to_cherry_pick}"

  git push --set-upstream origin "${issue_branch}"
  pr_title="[Cherry-pick] $(gh pr view ${pr_number} --json 'title' --jq '.title') (target ${current_branch})"
  echo -e "- Copy of #${pr_number} \n - fixes #${issue_number} \n\n $(gh pr view ${pr_number} --json 'body' --jq '.body')" | gh pr create --title "${pr_title}" --base "${current_branch}" --web --body-file=-
}

function gh_checks_status(){
  gh pr view --json 'statusCheckRollup' --jq '.statusCheckRollup[] | select(.status == "IN_PROGRESS") | .name' | xargs -I {} echo "gh run watch {}"
  # gh pr view --json 'state'

}

function gh_is_pr_merged_with_icon(){
  gh pr view && gh pr view --json 'state' --template '{{if eq .state "OPEN"}}⛏{{else }}✅{{end}}'
}
