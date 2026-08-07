#!/usr/bin/env zsh

if [[ "$(uname)" == "Darwin" ]]; then
    # Add idea command to path
    export PATH="/Applications/IntelliJ IDEA.app/Contents/MacOS/:${PATH}"
else
    # IntelliJ IDEA is installed via Flatpak on Ubuntu
    idea() {
        flatpak run com.jetbrains.IntelliJ-IDEA-Ultimate "$@"
    }
fi
