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

---

## 3. Mise en œuvre (exemple Java + Terraform)

### 3.1 Exemple minimal de `mise.toml`
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

### 3.2 Commandes à connaître
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

---

## Annexes (optionnel)
- Ajouter une section “Migration depuis asdf” en 5 lignes max (si utile).
- Ajouter un snippet CI (GitHub Actions) dans l’article CI (Structure 2), pas ici.
