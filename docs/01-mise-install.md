# `mise` au quotidien : standardiser les versions de vos outils

`mise` est un outil en ligne de commande qui permet de gérer et standardiser l’outillage d’un projet directement depuis le repository. Il permet de définir les versions exactes des outils nécessaires (langages, CLIs, runtimes), de les installer automatiquement et de garantir que tous les développeurs — ainsi que la CI — travaillent avec le même environnement.

**TL;DR — `mise` var permettre de :**
- standardiser les versions des outils au sein d’un projet,
- installer et utiliser ces outils simplement,
- changer automatiquement de version selon le répertoire courant,
- garantir que toute l’équipe travaille avec le même environnement.

## Avant mise : le casse-tête des versions d’outils

Dans un projet, on utilise plusieurs outils avec des versions spécifiques, ans outil de gestion des versions, on finit vite avec :
- des versions différentes de **Java** (JDK) selon les machines,
- des versions différentes de **Terraform** selon les devs / la CI,
- des scripts `bash` ou des notes “comment faire” qui dérivent,

## `mise` en place

`mise` permet de :
- **déclarer** les versions d’outils attendues *dans le repo*,
- **installer/sélectionner** ces versions automatiquement,
- **standardiser** les commandes projet via des **tasks** (ex : `mise run fmt`, `mise run plan`).

Ce que `mise` ne fait pas :
- il ne remplace pas Terraform, ni Gradle/Maven,
- il ne “déploie” pas : il structure l’outillage et l’exécution.

## Première étape : installer `mise` (oui, nous allons installer un package manager avec un package manager 😉)

```bash
# macOS avec Homebrew
brew install mise/mise

# Linux (via script d’installation)
curl -sSL https://get.mise.dev | bash

# Windows (via Scoop)
scoop install mise
```

Une fois installé, il est recommandé de "l'activer" dans le shell (ajouter dans `.bashrc`, `.zshrc`, etc.) :

```bash
# avec brew (macOS)
echo 'eval "$(mise activate bash)"' >> ~/.bashrc

# avec Windows (PowerShell)
$shimPath = "$env:USERPROFILE\AppData\Local\mise\shims"
$currentPath = [Environment]::GetEnvironmentVariable('Path', 'User')
$newPath = $currentPath + ";" + $shimPath
[Environment]::SetEnvironmentVariable('Path', $newPath, 'User')
```

Cette étape permet à `mise` de gérer automatiquement les versions des outils selon le répertoire courant.

## Mise "en œuvre"

On va commencer par une installation simple de java par exemple avec :
```bash
$ mise use java
mise java@25.0.1       download openjdk-25.0.1_macos-aarch64_bin.tar.gz    104.75 MiB/205.43 MiB (33s) [####################################] 100%

mise To enable macOS integration, run the following commands:
sudo mkdir /Library/Java/JavaVirtualMachines/25.0.1.jdk
sudo ln -s /Users/mac-Z16AMEAU/.local/share/mise/installs/java/25.0.1/Contents /Library/Java/JavaVirtualMachines/25.0.1.jdk/Contents

openjdk version "25.0.1" 2025-10-21
OpenJDK Runtime Environment (build 25.0.1+8-27)
OpenJDK 64-Bit Server VM (build 25.0.1+8-27, mixed mode, sharing)
mise ~/Projects/wk_perso/macos-setup/macos-provision/mise.toml tools: java@25.0.1
```

# Où est installé Java 25.0.1
$ mise which java
# Puis on peut vérifier la version active
$ java -version

# Vérifier
mise ls
```

**Installation globale (machine)**
```bash
# Installer un outil globalement (tous les projets)
mise use -g node@20
mise use -g python@3.12

# Vérifier
mise ls -g
```

### 3.2 Exemple minimal de `mise.toml`
> À adapter : versions et outils exacts selon ton contexte.

```toml
[tools]
# Java (JDK) — exemple
java = "temurin-21"

# Terraform — exemple
terraform = "1.9.8"

[tasks.fmt]
description = "Format Java + Terraform"
run = [
  "./gradlew spotlessApply",
  "terraform fmt -recursive"
]

[tasks.plan]
description = "Terraform plan"
run = "terraform plan"
```

### 3.3 Commandes à connaître
```bash
# Installer les outils déclarés
mise install

# Vérifier l’environnement
mise doctor

# Lancer une task projet
mise run fmt
mise run plan
```

---

## 4. À retenir
- **Bonne pratique :** versionner `mise.toml` et garder un exemple **minimal** (versions + 2–3 tasks clés).
- **Limite / piège :** ne pas transformer `mise` en “fourre-tout” ; garder les responsabilités (build Java / infra Terraform) dans les outils dédiés.
