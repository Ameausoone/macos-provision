#!/usr/bin/env bash

input=$(cat)

branch=$(git -C "$(echo "$input" | jq -r '.workspace.current_dir')" --no-optional-locks rev-parse --abbrev-ref HEAD 2>/dev/null)
model=$(echo "$input" | jq -r '.model.display_name')
total_input=$(echo "$input" | jq -r '.context_window.total_input_tokens // 0')
total_output=$(echo "$input" | jq -r '.context_window.total_output_tokens // 0')
total_tokens=$((total_input + total_output))

parts=()

if [ -n "$branch" ]; then
  parts+=("$(printf '\033[36m%s\033[0m' "$branch")")
fi

parts+=("$(printf '\033[33m%s\033[0m' "$model")")
parts+=("$(printf '\033[35m%dk tokens\033[0m' "$((total_tokens / 1000))")")

printf '%s' "$(IFS=' | '; echo "${parts[*]}")"
