#!/usr/bin/env zsh

export ZSH="${HOME}/.oh-my-zsh"

# Plugins are listed here https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins
plugins=(
    colored-man-pages
    colorize                # Colorize the output of some commands
    common-aliases
    cp
    docker                  # Docker aliases and auto-completion
    docker-compose
    gcloud                  # add gcloud autocomplete
    git                     # Git aliases and auto-completion
    gh                      # GitHub cli tool
    git-auto-fetch          # Automatically fetch git remotes
    helm                    # Helm aliases and auto-completion
    mise                    # Mise en place (asdf alternative)
    terraform               # Terraform aliases and auto-completion
    virtualenv              # Virtualenv aliases and auto-completion
    zsh-interactive-cd
    zsh-navigation-tools
)

if [[ "$(uname)" == "Darwin" ]]; then
    plugins+=(iterm2 macos)
fi

source "${ZSH}/oh-my-zsh.sh"
