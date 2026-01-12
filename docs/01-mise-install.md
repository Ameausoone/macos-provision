# Standardiser les versions de vos outils avec mise

À la fin de cet article, vous saurez installer et configurer `mise` pour gérer les versions d'outils dans vos projets et garantir la cohérence entre développeurs et CI.

**Public** : Développeurs, DevOps, SRE (débutant à intermédiaire)

## Le problème des versions qui dérivent

Dans un projet typique, chaque développeur installe ses outils indépendamment. Un dev utilise Java 17, un autre Java 21. La CI utilise Terraform 1.5, alors que l'équipe a migré en local vers 1.9.

Résultat : des bugs inexplicables, des "ça marche chez moi", et des heures perdues à débugger des incompatibilités de versions. Les scripts d'installation manuels (`install-java.sh`, `setup-terraform.md`) dérivent, l'onboarding des nouveaux développeurs devient long et fastidieux.

## Ce qu'on va construire

À la fin de ce tutoriel, vous aurez `mise` installé et activé sur votre machine, un fichier `mise.toml` versionnant les outils du projet, et une installation automatique des bonnes versions selon le répertoire courant.

**Pré-requis** : Un terminal avec droits d'installation et un gestionnaire de paquets (Homebrew sur macOS, apt/yum sur Linux, ou Scoop sur Windows).

## Les concepts clés

**Déclaratif** : `mise` permet de déclarer dans un fichier `mise.toml` les versions exactes des outils nécessaires. Ce fichier est versionné avec le code.

**Activation automatique** : Lorsque vous entrez dans un répertoire contenant un `mise.toml`, `mise` active automatiquement les bonnes versions. Changez de projet, changez de versions automatiquement.

**Environnement reproductible** : Développeurs et CI utilisent le même `mise.toml`, garantissant un environnement strictement identique pour tous.

## Installation de `mise`

Commencez par installer l'outil sur votre machine :

```bash
# macOS avec Homebrew
brew install mise

# Linux
curl -sSL https://get.mise.dev | bash

# Windows avec Scoop
scoop install mise
```

Vérifiez que tout fonctionne avec `mise --version`.

## Activation dans le shell

Pour que `mise` gère automatiquement les versions selon le répertoire, activez-le dans votre shell :

```bash
# macOS avec zsh
echo 'eval "$(mise activate zsh)"' >> ~/.zshrc
source ~/.zshrc

# Linux avec bash
echo 'eval "$(mise activate bash)"' >> ~/.bashrc
source ~/.bashrc
```

Sur **Windows (PowerShell)** :

```powershell
$shimPath = "$env:USERPROFILE\AppData\Local\mise\shims"
$currentPath = [Environment]::GetEnvironmentVariable('Path', 'User')
$newPath = $currentPath + ";" + $shimPath
[Environment]::SetEnvironmentVariable('Path', $newPath, 'User')
```

Le shell charge maintenant `mise` automatiquement.

## Premier outil : installer Java localement

Placez-vous dans votre projet et déclarez Java :

```bash
cd mon-projet
mise use java@21
```

Cette commande crée un fichier `mise.toml` dans le projet et installe Java 21. Vérifiez avec :

```bash
mise which java
java -version
```

Java 21 est actif uniquement dans ce répertoire. Sortez du projet, et vous retrouvez votre version système (ou aucune si Java n'était pas installé).

## Créer un fichier `mise.toml`

Plutôt que d'utiliser la commande `use` pour chaque outil, éditez directement `mise.toml` à la racine du projet :

```toml
[tools]
java = "21.0.1"
terraform = "1.9.8"
node = "20.11.0"
```

Installez tous les outils d'un coup :

```bash
mise install
```

Tous les outils déclarés sont téléchargés et configurés. Les autres membres de l'équipe peuvent cloner le projet et lancer `mise install` pour obtenir exactement le même environnement.

## Outils globaux

Pour installer des outils disponibles dans tous vos projets (pas seulement le projet courant), utilisez le flag `-g` :

```bash
mise use -g node@20
mise use -g python@3.12
```

Ces versions sont actives partout, sauf si un projet définit une version spécifique dans son `mise.toml`.

Listez vos outils globaux avec :

```bash
$ mise ls -g
NAME     VERSION  LOCATION
node     20.11.0  global
python   3.12.0   global
```

## Commandes utiles

```bash
# Lister tous les outils installés (locaux et globaux)
mise ls

# Vérifier la santé de mise
mise doctor

# Voir quelle version est active pour un outil
mise current java

# Voir quel binaire est utilisé
mise which terraform
```

## Personnalisation avancée

`mise` supporte des options avancées comme spécifier une version "glissante" d'un outil. Par exemple, vous pouvez spécifier `terraform = "1.12"` pour toujours utiliser la dernière version mineure de Terraform 1.12.x.

Pour Java, il existe une multitude de distributions (OpenJDK, Zulu, Liberica, etc.). Vous pouvez choisir une distribution spécifique dans `mise.toml`, par exemple :
- `java = "latest"` pour la dernière version stable (par défaut OpenJDK).
- `java ="temurin-21"` pour installer la dernière version d'Eclipse Temurin 21.
- `java ="zulu-17.0.8"` pour installer précisément Zulu 17.0.8.

## Récap

`mise` simplifie radicalement la gestion des versions d'outils. En quelques minutes, vous passez d'un environnement fragmenté à une configuration standardisée et reproductible.

Installez `mise`, créez un `mise.toml` versionnant les outils du projet, et utilisez `mise install` pour installer automatiquement les dépendances.

**Next steps** : Versionnez `mise.toml` dans votre repository, configurez mise dans votre CI/CD, et explorez les variables d'environnement pour configurer vos projets.

Dans le prochain article, nous verrons comment `mise` retrouve et installe les outils via les backends.

## Ressources

- [Documentation officielle mise](https://mise.jdx.dev/)
- [GitHub mise - Code source](https://github.com/jdx/mise)
- [Comparaison avec asdf](https://mise.jdx.dev/comparison-to-asdf.html)
- [Liste des outils supportés](https://mise.jdx.dev/registry.html)
