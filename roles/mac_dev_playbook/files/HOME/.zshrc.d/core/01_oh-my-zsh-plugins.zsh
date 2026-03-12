#!/usr/bin/env zsh

export ZSH="${HOME}/.oh-my-zsh"

# Plugins are listed here https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins
plugins=(
    autojump                # Will jump to the most used directories
    colored-man-pages
    colorize                # Colorize the output of some commands
    common-aliases
    cp
    docker                  # Docker aliases and auto-completion
    docker-compose
    gcloud                  # add gcloud autocomplete
    git                     # Git aliases and auto-completion
    gh                      # Github cli tool
    git-auto-fetch          # Automatically fetch git remotes
    gpg-agent               # enable GPG agent if not already enabled
    helm                    # Helm aliases and auto-completion
    iterm2
    macos
    mise                    # Mise en place (asdf alternative)
    poetry-env              # Poetry env load venv automatically
    poetry                  # Poetry aliases and auto-completion
    terraform               # Terraform aliases and auto-completion
    virtualenv              # Virtualenv aliases and auto-completion
    web-search
    zsh-interactive-cd
    zsh-navigation-tools
)

source "${ZSH}/oh-my-zsh.sh"
