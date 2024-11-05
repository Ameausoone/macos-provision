#!/usr/bin/env zsh

alias tf="terraform"

alias tfi="tf init"
alias tfp="tf plan"
alias tfpnr="tf plan -refresh=false"
alias tfv="tf validate"
alias tfa="tf apply"
alias tfaa="tf apply -auto-approve"
alias tfarf="tf apply -refresh=false"
alias tfaarf="tf apply -auto-approve -refresh=false"
alias tfg="tf get -update=true"

alias tfip="tfi && tfp"
alias tfia="tfi && tfa"
alias tfga="tfg && tfa"
alias tfiar="tfi && tfar"

alias tfim="tf import"

alias tfv="tf validate"
alias tfvq="tf validate -no-color"

alias tfd="terraform destroy"
alias tfdrf="terraform destroy -refresh=false"

alias tf_state_rm="tf state list | fzf --preview 'terraform state show {}' | xargs terraform state rm"

alias tf_workspace_select="tf workspace list| cut -c3- | fzf | xargs terraform workspace select"
