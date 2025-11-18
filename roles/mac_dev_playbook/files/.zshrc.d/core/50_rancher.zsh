#!/usr/bin/env zsh

if [[ ! -e /var/run/docker.sock ]]; then
  sudo ln -s $HOME/.rd/docker.sock /var/run/docker.sock
  echo "Linked $HOME/.rd/docker.sock to /var/run/docker.sock for Rancher Desktop Docker integration."
fi

export PATH="$HOME/.rd/bin:$PATH"

export DOCKER_HOST="unix:///var/run/docker.sock"
