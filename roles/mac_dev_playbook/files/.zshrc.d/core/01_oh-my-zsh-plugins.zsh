#!/usr/bin/env zsh

export ZSH="${HOME}/.oh-my-zsh"

# Plugins are listed here https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins
plugins=(
    autojump                # Will jump to the most used directories
    asdf                    # Asdf version manager
    colored-man-pages
    colorize                # Colorize the output of some commands
    common-aliases
    cp
    docker                  # Docker aliases and auto-completion
    docker-compose
    gcloud                  # add gcloud autocomplete
    git                     # Git aliases and auto-completion
    gh                      # Github cli tool
    git-remote-branch
    git-auto-fetch
    gpg-agent               # enable GPG agent if not already enabled
    helm
    iterm2
    macos
    poetry-env              # Poetry env load venv automatically
    poetry                  # Poetry aliases and auto-completion
    terraform               # Terraform aliases and auto-completion
    virtualenv              # Virtualenv aliases and auto-completion
    web-search
    zsh-interactive-cd
    zsh-navigation-tools
)

source "${ZSH}/oh-my-zsh.sh"
