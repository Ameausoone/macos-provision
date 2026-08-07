#!/usr/bin/env zsh

# GNU coreutils are macOS-only: Ubuntu already ships GNU coreutils natively.
# Installed via brew install coreutils
# https://www.gnu.org/s/coreutils/
if [[ "$(uname)" == "Darwin" ]]; then
    # Add coreutils to PATH
    export PATH="$(brew --prefix coreutils)/libexec/gnubin:${PATH}"
fi
