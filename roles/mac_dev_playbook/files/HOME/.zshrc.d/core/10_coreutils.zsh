#!/usr/bin/env zsh

# Installed via brew install coreutils
# https://www.gnu.org/s/coreutils/
# Add coreutils to PATH
export PATH="$(brew --prefix coreutils)/libexec/gnubin:${PATH}"
