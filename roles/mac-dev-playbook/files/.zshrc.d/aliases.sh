#!/usr/bin/env zsh

### FileSearch ###
function f() { find . -iname "*$1*" ${@:2} }
function r() { grep "$1" ${@:2} -R . }

### mkdir and cd ###
function mkcd() { mkdir -p "$@" && cd "$_"; }

### Lazygit ###
function lazygit() {
    git add . &&
    git commit -a -m "$1" &&
    git push
}

function runans() {
  ansible-playbook main.yml --diff --verbose --limit $(hostname)
}

function gitandans() {
    lazygit "$1"
    runans
}

function macans() {
  cd ~/Projects/wk_perso/macos-setup/macos-ansible-pb &&
  gitandans $1
}

alias cd..="cd .."
alias ..="cd .."

alias uwk="cd ~/Projects/wk_perso/"

alias macconfig="code ~/Projects/wk_perso/macos-setup"

function cheat(){
  echo "gitcheat"
  echo "syscheat"
  echo "syscheat"
  echo "k8scheat"
  echo "shellcheat"
  echo "gitmess"
  echo "good-readme"
}

alias gitcheat="cat ~/git-cheat-sheet.txt"
alias syscheat="cat ~/sys-cheat-sheet.txt"
alias osxcheat="cat ~/osx-cheat-sheet.txt"
alias k8scheat="cat ~/k8s-cheat-sheet.txt"
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

# Diff
alias diff="grc diff"

# highlight
alias yaml="highlight --force --syntax yaml"

# Notify 
alias notify='osascript -e "display notification \"Script finished\" with title \"Over\""'
alias n=notify