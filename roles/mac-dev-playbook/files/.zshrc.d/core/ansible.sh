#!/usr/bin/env zsh

alias a="ansible"
alias ap="ansible-playbook"
alias apd="ansible-playbook --diff"
alias apdv="ansible-playbook --diff --verbose"

# Function to print all ansible aliases
function ansible-cheat(){
  echo "a : ansible"
  echo "ap : ansible-playbook"
  echo "apd : ansible-playbook --diff"
  echo "apdv : ansible-playbook --diff --verbose"
}
