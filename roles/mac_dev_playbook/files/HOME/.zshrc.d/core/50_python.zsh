#!/usr/bin/env zsh

alias python_setup_venv="python3 -m venv .venv --upgrade-deps && source .venv/bin/activate && pip install -r requirements.txt"
alias setup_venv=python_setup_venv

export PATH="$(mise where python)/bin/:${PATH}"
