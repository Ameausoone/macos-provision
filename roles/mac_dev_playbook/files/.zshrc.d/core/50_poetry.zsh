#!/usr/bin/env zsh

[ -f ~/Library/Preferences/pypoetry/config.toml ] && rm -Rf ~/Library/Preferences/pypoetry/config.toml

alias poetry_dep_update="poetry lock --no-update && poetry export --format=requirements.txt --without-hashes --output=requirements.txt && poetry export --format=requirements.txt --with dev --without-hashes --output=requirements_dev.txt && poetry install --sync"
