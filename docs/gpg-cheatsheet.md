# Résumé des commandes GPG

## Génération de clés
- **`gpg --full-generate-key`**
  Permet de générer une clé GPG en mode interactif.

- **`gpg --batch --generate-key gpg-key-params.txt`**
  Génère une clé automatiquement avec un fichier de configuration batch.

- **`Expire-Date: 45d`**
  À inclure dans le fichier batch pour définir une expiration de 45 jours.

---

## Vérification et gestion des clés
- **`gpg --list-keys`**
  Affiche toutes les clés publiques disponibles.

- **`gpg --list-secret-keys`**
  Affiche toutes les clés privées disponibles.

- **`gpg --edit-key <KEY_ID>`**
  Permet d’éditer une clé spécifique pour vérifier ou modifier ses propriétés.

- **`echo "test" | gpg -u <KEY_ID> --clearsign`**
  Teste la signature avec une clé spécifique.

---

## Suppression de clés
- **`gpg --delete-key <KEY_ID>`**
  Supprime une clé publique spécifique.

- **`gpg --delete-secret-keys <KEY_ID>`**
  Supprime une clé privée spécifique.

- **`gpg --yes --delete-key <KEY_ID>`**
  Force la suppression d’une clé publique.

- **`gpg --yes --delete-secret-keys <KEY_ID>`**
  Force la suppression d’une clé privée.

---

## Configuration et dépannage
- **`gpgconf --kill gpg-agent`**
  Redémarre l’agent GPG pour recharger la configuration.

- **`gpgconf --launch gpg-agent`**
  Relance l’agent GPG.

- **`pinentry-mode loopback`**
  À ajouter dans `~/.gnupg/gpg.conf` pour permettre l’utilisation d’une interface non-interactive pour les passphrases.

- **`gpg --export-ssh-key <KEY_ID>`**
  Exporte une clé GPG au format SSH.

---

## Publication et révocation
- **`gpg --output revoke-cert.asc --gen-revoke <KEY_ID>`**
  Génère un certificat de révocation pour une clé.

- **`gpg --import revoke-cert.asc`**
  Révoque une clé à l’aide d’un certificat de révocation.

- **`gpg --keyserver keyserver.ubuntu.com --send-keys <KEY_ID>`**
  Publie une clé (ou une révocation) sur un serveur de clés.

---

## Vérification après modifications
- **`gpg --list-keys`**
  Vérifie que les clés publiques sont mises à jour.

- **`gpg --list-secret-keys`**
  Vérifie que les clés privées sont mises à jour.
