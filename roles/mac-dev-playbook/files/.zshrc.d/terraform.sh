#!/usr/bin/env zsh

alias tf="terraform"

alias tfi="tf init -get=true -upgrade=true"
alias tfp="tf plan"
alias tfv="tfi && tf validate"
alias tfa="tf apply -refresh=false"
alias tfaa="tf apply -refresh=false -auto-approve"
alias tfar="tf apply"
alias tfg="tf get -update=true"

alias tfip="tfi && tfp"
alias tfia="tfi && tfa"
alias tfga="tfg && tfa"
alias tfiar="tfi && tfar"

alias tfim="tf import"

alias tfd="terraform destroy -refresh=false"
alias tfdr="terraform destroy"
alias tfda="terraform destroy -refresh=false -auto-approve"

alias tfdocs="terraform-docs markdown table . > README.md"
