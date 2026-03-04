# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

An Ansible playbook that provisions a macOS developer machine. It installs Homebrew packages, copies dotfiles to `$HOME`, configures zsh with oh-my-zsh/antigen, and sets up GitHub CLI extensions.

## Running the playbook

```bash
ansible-playbook main.yml --diff --verbose --inventory ~/.inventory --limit $(hostname)
```

Run only brew tasks:

```bash
ansible-playbook main.yml --tags brew
```

Run only dotfile tasks:

```bash
ansible-playbook main.yml --tags dotfiles
```

## Mise tasks

```bash
# Install tools defined in mise.toml
mise install

# Compare provisioned dotfiles against actual $HOME
mise run compare-dotfiles
```

## Architecture

- `main.yml` — entry point, delegates to `roles/mac_dev_playbook`
- `roles/mac_dev_playbook/tasks/main.yml` — task orchestration (oh-my-zsh → dotfiles → brew → docker → github)
- `roles/mac_dev_playbook/defaults/main.yml` — all package lists (Homebrew taps, packages to install/remove, npm packages, gh CLI extensions)
- `roles/mac_dev_playbook/files/HOME/` — dotfiles copied recursively to `$HOME` on each playbook run
- `roles/mac_dev_playbook/files/HOME/.zshrc.d/` — zsh config fragments, sourced alphabetically by `~/.zshrc`
- `scripts/compare-dotfiles.sh` — diffs provisioned files against the live `$HOME`
- `docs/` — articles and cheatsheets (mise, GPG, MCP, etc.)

## Key conventions

- Add/remove packages in `roles/mac_dev_playbook/defaults/main.yml` (not in task files)
- Dotfiles go under `roles/mac_dev_playbook/files/HOME/` mirroring the `$HOME` structure
- zsh scripts in `.zshrc.d/` are loaded alphabetically — use numeric prefixes (`00_`, `01_`) to control order
- Ansible collections required: `community.general`, `ansible.posix` (install via `ansible-galaxy collection install -r requirements.yml`)
