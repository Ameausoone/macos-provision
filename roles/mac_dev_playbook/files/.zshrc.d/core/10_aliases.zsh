#!/usr/bin/env zsh

MACOS_SETUP_DIR=~/Projects/wk_perso/macos-setup

### FileSearch ###
# usage : f <pattern> <grep options> eg. f "foo" -i
function f() { find . -iname "*$1*" ${@:2} }
# usage : r <pattern> <grep options> eg. r "foo" -l
function r() { grep "$1" ${@:2} -R . }

### mkdir and cd ###
function mkcd() { mkdir -p "$@" && cd "$_"; }

### Lazygit ###
function lazygit() {
  git add . && \
  git commit -a -m "$1" && \
  git push
}

function runans() {
  ansible-galaxy install -r requirements.yml && \
  ansible-playbook main.yml --diff --verbose --limit $(hostname)
}

function gitandans() {
  lazygit "$1" && \
  runans
}

# This script will go to the macos-provision directory,
# then it will run git add,
# commit, push,
# and it will run the ansible playbook
function macans() {
  cd "${MACOS_SETUP_DIR}/macos-provision" && \
  gitandans "${1}"
}

alias cd..="cd .."
alias ..="cd .."

alias uwk="cd ~/Projects/wk_perso/"

alias macconfig="idea ${MACOS_SETUP_DIR}"

function cheat(){
  echo "gitcheat"
  echo "syscheat"
  echo "syscheat"
  echo "k8scheat"
  echo "shellcheat"
  echo "terraformcheat"
  echo "gitmess"
  echo "good-readme"
}

alias gitcheat="cat ~/git-cheat-sheet.txt"
alias syscheat="cat ~/sys-cheat-sheet.txt"
alias osxcheat="cat ~/osx-cheat-sheet.txt"
alias k8scheat="cat ~/k8s-cheat-sheet.txt"
alias terraformcheat="cat ~/terraform-cheat-sheet.txt"
alias shellcheat="cat ~/shell-cheat-sheet.md"
alias gitmess="cat ~/.gitmessage"
alias zshshorcut="open http://www.geekmind.net/2011/01/shortcuts-to-improve-your-bash-zsh.html"
alias good-readme="open https://github.com/othneildrew/Best-README-Template"

# Makefile
alias m="make"

# Google
alias goo="google"

# Howdoi
alias hdi="howdoi -c -n 2"

# Improve default diff
alias diff="grc diff"

# highlight
alias yaml="highlight --force --syntax yaml"
