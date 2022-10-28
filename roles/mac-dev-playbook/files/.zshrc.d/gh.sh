#!/usr/bin/env zsh

# TODO gh extension install :
# https://github.com/davidraviv/gh-clean-branches


function gh_copy_issue(){
  if [ -z "$1" ]; then
    echo "What issue do you want to copy?"
    read issue
  else
    issue=$1
  fi
  local issue_number="${issue}"
  local issue_title=$(gh issue view ${issue_number} --json 'title' --jq '.title')
  echo -e "- Copy of #${issue_number} \n\n $(gh issue view ${issue_number} --json 'body' --jq '.body')" | gh issue create --title "${issue_title}" --web --body-file=-
}

function git_cherry_pick_issue(){
  if [ "$1" = "-h" ]; then
    echo "Usage: git_cherry_pick_issue <issue_number>"
    return
  fi
  if [ -z "$1" ]; then
    echo "What issue do you want to copy ?"
    # list recently closed issues with gh and fzf
    issue=$(gh issue list --state closed --limit 100 | fzf --preview 'gh issue view {1}' | awk '{print $1}')
  else
    issue=$1
  fi
  # search linked PR
    local pr=$(gh pr list --search "is:merged is:closed linked:issue/${issue}" --limit 1 | awk '{print $1}')


  if [ -z "$2" ]; then
    echo "What branch do you want to cherry-pick to? "
    branch=$(git branch -a | fzf)
  else
    branch=$2
  fi
  git pull origin ${branch}

  local issue_number="${issue}"
  local issue_title=$(gh issue view ${issue_number} --json 'title' --jq '.title')
  local issue_branch=$(echo "${issue_title}" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | tr -d '[:punct:]')
  local issue_branch="issue-${issue_number}-${issue_branch}"
  git checkout -b "${issue_branch}"
  gh pr checkout ${issue_number}
  git cherry-pick -x $(git rev-parse HEAD~1)..HEAD
  git push --set-upstream origin "${issue_branch}"
  gh pr create --fill --web
}
