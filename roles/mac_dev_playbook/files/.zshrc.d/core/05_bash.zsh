#!/usr/bin/env zsh

# Ensure that /usr/local/bin is prioritized over /usr/bin in the PATH
# Notably, this ensure that /usr/bin/env bash uses the latest version of bash
export PATH="/usr/local/bin:${PATH}"
