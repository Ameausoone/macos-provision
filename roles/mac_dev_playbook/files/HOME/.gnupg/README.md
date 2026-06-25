# GPG Configuration for macOS

Configuration files and scripts for setting up GPG on macOS, tailored for IntelliJ IDEA and Git commit signing.

## Files

- **`gpg-agent.conf`**: Configures GPG agent with caching and custom pinentry script.
- **`pinentry-ide.sh`**: Handles GPG pinentry requests, integrating with IntelliJ or falling back to `pinentry-mac`.
- **`gpg-key-params.txt`**: Template for generating a 4096-bit RSA GPG key.
- **`.zshrc.d/core/20_gnupg.zsh`**: Exports required GPG environment variables.

## Setup

1. Install dependencies: `gpg`, `pinentry-mac`.
2. Copy files to `~/.gnupg/` and make `pinentry-ide.sh` executable:
  ```bash
  chmod +x ~/.gnupg/pinentry-ide.sh
  ```
3. Source .zshrc.d/core/20_gnupg.zsh:
  ```shell
  source ~/.zshrc.d/core/20_gnupg.zsh
  ```
4. Generate a GPG key:
  ```bash
   gpg --batch --generate-key ~/.gnupg/gpg-key-params.txt
  ```
5. Configure Git:
  ```bash
  git config --global user.signingkey <your-gpg-key-id>
  git config --global commit.gpgsign true
  ```

## Debugging

Run ~/.gnupg/pinentry-ide.sh directly to debug pinentry issues.

## Notes

* Ensure `pinentry-program` in `gpg-agent.conf` points to `pinentry-ide.sh`.
* `PINENTRY_USER_DATA` determines IntelliJ integration.

* References: [GPG Commit Signing](https://www.jetbrains.com/help/idea/set-up-GPG-commit-signing.html#1732b909), [GPG Guide](https://gist.github.com/Ruben-E/9306a0666a1d9c3a3ffe710383551112)


## TODO

* Renew also SSH key
* See
  * https://gurjeet.singh.im/blog/passwordstore+gnupg+touchid pour le pinentry-touchid liée au pinentry-mac (la partie pass, je ne l'utilise pas)
  * https://alexnorell.com/post/set-up-gpg/#create-ssh-key pour utiliser une subkey GPG pour les connexion ssh
  * https://superuser.com/questions/879977/how-to-have-a-different-pass-phrase-for-a-gpg-subkey sur le fait d'avoir un mot de passe différent pour chaque sous-clé.... oui je suis un peu violent 😅
