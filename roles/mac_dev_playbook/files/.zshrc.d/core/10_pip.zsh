#!/usr/bin/env zsh

# add pip install path to PATH
export PIP_DIR="$(asdf where python)/bin"
export PATH="${PIP_DIR}:${PATH}"
