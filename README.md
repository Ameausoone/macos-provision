# MacOS Ansible Playbook

This an Ansible Playbook to provision my macOS.

## What this playbook provide ?

It will :

* create useful directories.
* install packages (brew(and taps), asdf, npm).
* copy dotfiles which configure various applications(Git, npm, terraform, asdf) in home.
* copy some zsh script, mainly for configuration and some helper functions and aliases.

## How to install it ?

* checkout project in `~/Projects/wk_perso/macos-setup/macos-provision`.
* copy `roles/mac-dev-playbook/files/ansible/ansible.cfg` in ~/.ansible.cfg
* init file `inventory` file in `~/.ansible/inventory` e.g.

```text
[localhost]
mac-name gpg_key=${my-local-gpg-key}
```

* then go to `~/Projects/wk_perso/macos-setup/macos-provision`.
* run `ansible-playbook main.yml --diff --verbose --inventory ~/.inventory --limit $(hostname)`.

## How to use it ?

Two functions are provided :

* `macconfig` will open project with code

## Manual configuration (I can't automate everything)

* Configure iTerm2 <https://apple.stackexchange.com/questions/136928/using-alt-cmd-right-left-arrow-in-iterm>

## Docs

Terraform tools are documented in [terraform-family.md](docs/terraform-family.md).

## Various

### Conf

- I talked about this project at DevFest Strasbourg 2023: <https://www.youtube.com/watch?v=3EVxJo2A5a8>

### Could I use it ?

At your own risk, this playbook doesn't aim to be used by someone else, it's just to share how I provision my computers.

### asdf : install all plugins in once

```shell
 cut -d ' ' -f1 .tool-versions | xargs -I _ asdf plugin-add _
 ```

### Set up GPG commit signing

- Generate a GPG key
  ```shell
  gpg --full-generate-key
  ```


- Look at the excellent article here by https://github.com/Thomgrus: https://www.sfeir.dev/securite/securite-signer-ses-commits/

- Look at https://www.jetbrains.com/help/idea/set-up-GPG-commit-signing.html#enable-commit-signing for Setup GPG keys.

### Load SSH key in ssh-agent

- Look at https://apple.stackexchange.com/a/250572/222951

### Setup Commit message template

- Look at https://efren45marin.medium.com/how-to-take-your-git-commit-messages-to-the-next-level-with-a-commit-template-cd3a608b1ac9
