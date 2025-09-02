#!/usr/bin/env zsh

export DOCKER_HOST="unix:///Users/${USERNAME}/.colima/default/docker.sock"

function colima_up(){
  colima status || colima start
}

# Asynchronous colima startup function
function colima_start_async() {
  # colima start is idempotent - won't start if already running
  (colima start &>/dev/null) &
  disown
}

# Auto-start colima asynchronously on shell init
colima_start_async

# Start colima if not started
# alias docker="colima_up docker"
