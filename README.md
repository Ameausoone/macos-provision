# Dev Machine Ansible Playbook

This an Ansible Playbook to provision my macOS and Ubuntu dev machines.

## What this playbook provide ?

It will :

* create useful directories.
* install packages (brew(and taps), npm, and on Ubuntu also apt/flatpak).
* copy dotfiles which configure various applications(Git, npm, terraform) in home.
* copy some zsh script, mainly for configuration and some helper functions and aliases.

## How to install it the first time ?

### macOS

* install brew : [brew.sh/](https://brew.sh/)
* install ansible : `brew install ansible`
* checkout project in `~/projects/perso/provision/macos-provision`.
* copy `roles/mac_dev_playbook/files/HOME/.ansible.cfg` in ~/.ansible.cfg
  ```shell
  curl -fsSL https://github.com/Ameausoone/macos-provision/raw/refs/heads/main/roles/mac_dev_playbook/files/HOME/.ansible.cfg -o ~/.ansible.cfg
  ```
* init the `~/.ansible/inventory` file
  ```shell
  mkdir -p ~/.ansible && printf '[localhost]\n%s\n' "$(hostname)" > ~/.ansible/inventory
  ```

* then go to `~/projects/perso/provision/macos-provision`.
* run `ansible-playbook main.yml --diff --verbose --inventory ~/.ansible/inventory --limit $(hostname)`.
* authenticate to GitHub
  ```shell
  gh auth login
  ```
* change default shell
  ```shell
  chsh -s $(which zsh)
  ```

### Ubuntu

* install Linuxbrew : [docs.brew.sh/Homebrew-on-Linux](https://docs.brew.sh/Homebrew-on-Linux)
  ```shell
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$($(brew --prefix)/bin/brew shellenv)"
  ```
* install ansible and the collections it needs (`community.general`, `ansible.posix`) :
  ```shell
  brew install ansible
  ansible-galaxy collection install -r requirements.yml
  ```
* checkout project, e.g. in `~/projects/wk_perso/macos-setup/macos-provision`.
* copy `roles/mac_dev_playbook/files/HOME/.ansible.cfg` in ~/.ansible.cfg (same as macOS above).
* init the `~/.ansible/inventory` file as above.
* run `ansible-playbook main.yml --diff --verbose --inventory ~/.ansible/inventory --limit $(hostname) --ask-become-pass`
  (`--ask-become-pass` is needed: apt/flatpak tasks and `chsh` require sudo).
* the apt tasks need `python3-apt` and `python3-debian` for the *system* Python
  (already present on Ubuntu Desktop by default; if missing:
  `sudo apt install python3-apt python3-debian`).
* authenticate to GitHub
  ```shell
  gh auth login
  ```

Packages that only make sense on one OS are split in `roles/mac_dev_playbook/defaults/main.yml`
(`*_darwin_only` for macOS-only Homebrew formulae, `mac_dev_playbook_apt_packages` /
`mac_dev_playbook_flatpak_packages` for Ubuntu-only GUI apps).

### First run walkthrough

1. Dry run first, to see what would change: add `--check` to the `ansible-playbook` command above.
2. Run it for real (see command above). Order: oh-my-zsh clone → dotfiles copy → brew →
   apt/flatpak [Ubuntu only] → docker plugin symlinks → gh extensions → shells → macOS defaults [macOS only].
3. On Ubuntu, `--ask-become-pass` prompts once for your sudo password (used by the apt/flatpak/chsh tasks).
4. Open a new terminal (or `exec zsh`) to pick up the newly installed dotfiles/shell.
5. Re-running the playbook is safe (idempotent) — use it whenever you change a package list or dotfile.

## How to use it ?

Two functions are provided :

* `macconfig` will open project with code

## Manual configuration (I can't automate everything)

* Configure iTerm2 <https://apple.stackexchange.com/questions/136928/using-alt-cmd-right-left-arrow-in-iterm>
* Create `~/.gitconfig.local` with your git identity (not repo-managed, machine-local):
  ```gitconfig
  [user]
    name = Your Name
    email = your@email.com
  ```

## Docs

Terraform tools are documented in [terraform-family.md](docs/terraform-family.md).

## Various

### Conf

- I talked about this project at DevFest Strasbourg 2023: <https://www.youtube.com/watch?v=3EVxJo2A5a8>

### Could I use it ?

At your own risk, this playbook doesn't aim to be used by someone else, it's just to share how I provision my computers.

### mise: install tools

  ```shell
  mise install
  ```

### Load SSH key in ssh-agent

- Look at https://apple.stackexchange.com/a/250572/222951

### Setup Commit message template

- Look at https://efren45marin.medium.com/how-to-take-your-git-commit-messages-to-the-next-level-with-a-commit-template-cd3a608b1ac9
