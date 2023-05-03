#!/usr/bin/env zsh

export DOCKER_HOST="unix:///Users/ANTOINE/.colima/default/docker.sock"

function colima_up(){
  colima status || colima start
}

# Start colima if not started
alias docker="colima_up docker"
