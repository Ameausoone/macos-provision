#!/usr/bin/env zsh

alias tf="terraform"

alias tfi="tf init"
alias tfp="tf plan"
alias tfv="tf validate"
alias tfa="tf apply"
alias tfaa="tf apply -auto-approve"
alias tfanr="tf apply -refresh=false"
alias tfaanr="tf apply -auto-approve -refresh=false"
alias tfg="tf get -update=true"

alias tfip="tfi && tfp"
alias tfia="tfi && tfa"
alias tfga="tfg && tfa"
alias tfiar="tfi && tfar"

alias tfim="tf import"

alias tfd="terraform destroy -refresh=false"
alias tfdr="terraform destroy"
alias tfda="terraform destroy -refresh=false -auto-approve"
alias tfv="tf validate"
alias tfvq="tf validate -no-color"

alias tf_state_rm="tf state list | fzf --preview 'terraform state show {}' | xargs terraform state rm"

alias tf_workspace_select="tf workspace list| cut -c3- | fzf | xargs terraform workspace select"
