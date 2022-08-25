#!/usr/bin/env zsh

export ZSH="$HOME/.oh-my-zsh"

# Plugins are listed here https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins
plugins=(
    autojump
    asdf
    colored-man-pages
    colorize
    common-aliases
    cp
    docker
    docker-compose
    gcloud
    git
    gh
    #git-remote-branch
    git-auto-fetch
    helm
    iterm2
    macos
    terraform
    virtualenv
    web-search
    zsh-interactive-cd
    zsh-navigation-tools
)

source $ZSH/oh-my-zsh.sh
