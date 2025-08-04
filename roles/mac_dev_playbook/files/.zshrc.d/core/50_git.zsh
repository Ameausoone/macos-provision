#!/usr/bin/env zsh


alias gcml="gcm && gl"

### Editor ###
export EDITOR='idea -e --wait'

export GITHUB_EMAIL="592978+Ameausoone@users.noreply.github.com"

# generate ssh-key
alias gen-ssh-key="ssh-keygen -t ed25519 -C ${GITHUB_EMAIL}"

function gcamp() {
  git commit -am "$1"
  git push
}

# https://dev.to/raisingpixels/bash-aliases-that-save-parent-developers-20-more-coding-time-1cl6?context=digest
# When you return and can't remember what you were doing
alias last='git log --oneline -5'
alias status='git status && echo "---" && git log --oneline -3'
alias changes='git diff HEAD~1'

# Quick branch management
alias main='git checkout main && git pull'
alias newbranch='git checkout -b'
alias deletebranch='git branch -d'
