//  pragma: allowlist secret
# Gestion sécurisée des secrets avec macOS Keychain et autoenv

## Introduction

La gestion des secrets et variables d'environnement sensibles est un enjeu crucial pour tout développeur. Stocker des tokens, clés API ou mots de passe en clair dans des fichiers `.env`, `.zshrc` ou pire, les laisser traîner dans l'historique bash, représente un risque de sécurité majeur.

Cet article présente une approche sécurisée pour macOS qui combine :

- Le **Keychain macOS** pour un stockage chiffré des secrets
- **autoenv** pour le chargement automatique par répertoire
- Des **fonctions shell personnalisées** pour une interface simple

## Problématiques des approches classiques

### ❌ Stockage en clair dans des fichiers

La méthode la plus courante mais aussi la plus dangereuse consiste à stocker les secrets directement dans des fichiers de configuration ou des scripts shell.

```bash
# .env ou .zshrc - DANGEREUX
export API_TOKEN="sk_live_xxxxxxxxxxxx"  # pragma: allowlist secret
export DATABASE_PASSWORD="motdepasse123"  # pragma: allowlist secret
```

**Risques :**

- Secrets visibles en clair dans les fichiers
- Commits accidentels dans Git
- Exposition lors du partage d'écran
- Accessibles à tout processus ayant accès au système de fichiers

### ❌ Historique bash compromis

Une autre pratique dangereuse consiste à taper des commandes contenant des secrets directement dans le terminal, laissant des traces permanentes dans l'historique.

```bash
# Commandes visibles dans l'historique
export SECRET_KEY="ma-cle-secrete"  # pragma: allowlist secret
curl -H "Authorization: Bearer mon-token" api.example.com
```

**Problèmes :**

- Les commandes contenant des secrets restent dans `~/.zsh_history`
- Accessibles via `history | grep token`
- Visibles par tous les utilisateurs du système
- Persistent même après redémarrage
- Peuvent être sauvegardés involontairement

## Solution : Keychain macOS + autoenv

### Architecture de la solution

```mermaid
graph LR
    A[Secrets chiffrés<br/>Keychain macOS] --> B[Fonctions shell<br/>30_creds.zsh]
    B --> C[Variables d'env<br/>31_github.zsh]
    C --> D[Chargement auto<br/>autoenv .env]
```

### 1. Fonctions de gestion des secrets

Le fichier [`30_creds.zsh`](https://github.com/Ameausoone/macos-provision/blob/main/roles/mac_dev_playbook/files/.zshrc.d/core/30_creds.zsh) fournit une interface sécurisée pour le Keychain macOS. Ces fonctions encapsulent les commandes `security` système pour simplifier l'usage.

#### Stockage d'un secret

Pour ajouter un nouveau secret au Keychain, utilisez la fonction `creds_upsert_local_secret` qui garantit un stockage sécurisé et chiffré.

```bash
creds_upsert_local_secret "myservice" "api_key"
# Vous serez invité à saisir le secret de manière masquée
```

**Fonctionnement interne :**

1. Vérifie si une entrée existe déjà dans le Keychain
2. Supprime l'ancienne entrée si elle existe
3. Crée une nouvelle entrée chiffrée
4. Utilise `$LOGNAME` (votre nom d'utilisateur) comme identifiant

#### Récupération d'un secret

Pour accéder à un secret stocké dans le Keychain, utilisez la fonction `creds_get_local_secret` qui récupère la valeur de manière sécurisée.

```bash
# Récupération directe pour usage immédiat
export API_TOKEN=$(creds_get_local_secret "myservice" "api_key")

# Stockage dans une variable pour usage multiple
my_token=$(creds_get_local_secret "myservice" "api_key")
echo "Token length: ${#my_token}"
```

**Sécurité :** Le secret est stocké de façon chiffrée dans le Keychain macOS, et chargé temporairement en mémoire.

#### Suppression d'un secret

Quand un secret n'est plus nécessaire, supprimez-le définitivement du Keychain pour maintenir une hygiène de sécurité optimale.

```bash
# Suppression définitive du Keychain
creds_delete_local_secret "myservice" "api_key"
```

**Avantages de cette solution :**

- ✅ **Stockage chiffré** dans le Keychain système avec chiffrement matériel
- ✅ **Validation des entrées** (secrets non vides)
- ✅ **Gestion d'erreurs robuste** avec messages explicites
- ✅ **Pas de traces en clair** dans les fichiers
- ✅ **Authentification système** via Touch ID/mot de passe
- ✅ **Récupération à la volée** : Le secret est lu depuis le Keychain chiffré à chaque besoin
- ✅ **Intégration transparente** : Fonctionne avec tous les outils CLI (git, curl, etc.)
- ✅ **Audit automatique** : Le Keychain log les accès aux secrets
- ✅ **Isolation par projet** : Chaque répertoire charge ses propres secrets
- ✅ **Pas de persistance** : Variables temporaires, pas de fichiers en clair
- ✅ **Intégration native** : Compatible avec tous les outils macOS

### 2. Configuration des variables d'environnement

Le fichier de configuration illustre comment intégrer les secrets dans votre environnement shell de manière sécurisée :

```bash
#!/usr/bin/env zsh

# Récupération de la clé API depuis le Keychain
export API_TOKEN=$(creds_get_local_secret "myservice" "api_key")
```

**Détails du processus :**

1. **Exécution à chaque démarrage de shell** : La fonction est appelée automatiquement
2. **Authentification Keychain** : macOS peut demander votre mot de passe utilisateur
3. **Variable temporaire** : `API_TOKEN` existe seulement pendant la session
4. **Pas de persistance** : Aucune trace permanente du secret


### 3. Chargement automatique avec autoenv

[**autoenv**](https://github.com/hyperupcall/autoenv) est un outil qui exécute automatiquement des scripts quand vous naviguez vers un répertoire. **L'avantage principal** : les secrets ne sont chargés que quand vous en avez besoin, dans le contexte du projet spécifique, plutôt que d'être disponibles globalement dans votre shell.

Cela permet de :
- **Charger les secrets uniquement par projet** : évite l'exposition inutile de tokens
- **Isolation des environnements** : chaque projet a ses propres variables
- **Chargement automatique** : pas besoin de se souvenir de commandes manuelles

#### Installation et configuration

```bash
# Installation via Homebrew
brew install autoenv

# Activation dans votre shell (ajout à ~/.zshrc)
echo 'source $(brew --prefix autoenv)/activate.sh' >> ~/.zshrc

# Rechargement de la configuration
source ~/.zshrc
```

#### Fonctionnement détaillé

**1. Détection automatique :**
Quand vous entrez dans un répertoire avec `cd`, autoenv cherche un fichier `.env`.

**2. Exécution sécurisée :**
```bash
# Première fois : autoenv demande confirmation
cd /mon/projet
# autoenv: WARNING: /mon/projet/.env is not trusted.
# Do you want to allow this? (y/N)
```

**3. Exemple de fichier `.env` simple :**

```bash
#!/usr/bin/env zsh

# Chargement simple des secrets depuis le Keychain
export API_TOKEN=$(creds_get_local_secret "myservice" "api_key")
export DATABASE_URL=$(creds_get_local_secret "myproject" "database_url")
export EXTERNAL_API_KEY=$(creds_get_local_secret "external" "api_key")
```

**Workflow complet :**

1. **Navigation** : `cd /path/to/my-project`
2. **Détection** : autoenv trouve le fichier `.env`
3. **Authentification** : macOS peut demander votre mot de passe pour le Keychain
4. **Exécution** : Le script charge les variables d'environnement
5. **Utilisation** : Les variables sont disponibles pour tous les outils

## Mise en pratique

### Étape 1 : Stockage initial des secrets

**Important :** Utilisez toujours la saisie interactive pour éviter que les secrets apparaissent dans l'historique bash.
```bash
# Stocker une clé API de service (saisie interactive recommandée)
creds_upsert_local_secret "myservice" "api_key"
# ~> Specify secret for myservice.api_key
# [Saisie masquée de la clé]
# ~> Create myservice.api_key
# Now call $(creds_get_local_secret "myservice" "api_key") to get the secret.

# Stocker une clé API pour votre application
creds_upsert_local_secret "myapp" "api_key"
# ~> Specify secret for myapp.api_key
# [Saisie masquée de la clé]

# Exemple avec une base de données
creds_upsert_local_secret "myproject" "database_url"
# ~> Specify secret for myproject.database_url
# [Ex: postgresql://user:pass@localhost:5432/mydb]  # pragma: allowlist secret
```

**Bonnes pratiques pour le nommage :**

- **Format recommandé :** `<service>.<type>` ou `<projet>.<service>.<type>`
- **Exemples valides :**
  - `myservice.api_key`
  - `myproject.database.url`
  - `aws.access.key`
  - `stripe.secret.key`

**Vérification du stockage :**

```bash
# Test de récupération (sans affichage du secret)
if creds_get_local_secret "myservice" "api_key" > /dev/null; then
    echo "✅ Clé API stockée avec succès"
else
    echo "❌ Erreur lors du stockage"
fi

# Vérification dans le trousseau de connexion
# Recherchez "myservice.api_key" dans le trousseau de connexion
```

### Étape 2 : Configuration projet

Créez un fichier `.env` à la racine de votre projet :

```bash
#!/usr/bin/env zsh

# Chargement des secrets depuis le Keychain
export API_TOKEN=$(creds_get_local_secret "myservice" "api_key")
export DATABASE_URL=$(creds_get_local_secret "myproject" "database_url")
export EXTERNAL_API_KEY=$(creds_get_local_secret "external" "api_key")

# Configuration spécifique au projet
export PROJECT_NAME="mon-super-projet"
export ENVIRONMENT="development"
export LOG_LEVEL="debug"
```

### Étape 3 : Test et validation complète

Cette section regroupe tous les tests nécessaires pour valider votre configuration :

#### 1. Test du chargement automatique

```bash
# Navigation dans le projet (première fois)
cd /path/to/mon-projet
# autoenv: WARNING: /path/to/mon-projet/.env is not trusted.
# Do you want to allow this? (y/N) y
# 🚀 Initialisation de l'environnement mon-super-projet...
# ✅ Clé API service chargée
# ✅ Clé API externe chargée
# 🔐 Environnement mon-super-projet configuré!

# Navigation suivante (autorisé, pas de demande)
cd .. && cd mon-projet
# 🚀 Initialisation de l'environnement mon-super-projet...
# ✅ Clé API service chargée
```

## Sécurité et bonnes pratiques

### ✅ Points forts de cette approche

1. **Chiffrement système** : Keychain utilise le chiffrement matériel du Mac
2. **Isolation par projet** : Chaque répertoire charge ses propres secrets
3. **Pas de persistance** : Variables temporaires, pas de fichiers en clair
4. **Audit trail** : Le Keychain log les accès aux secrets
5. **Intégration native** : Compatible avec tous les outils macOS

### ⚠️ Considérations de sécurité

1. **Protection du Keychain** : Verrouillez votre Mac systématiquement
2. **Principe du moindre privilège** : Un secret par usage spécifique
3. **Rotation des secrets** : Renouvelez régulièrement vos tokens
4. **Backup sécurisé** : Le Keychain est inclus dans Time Machine

### 🔧 Cas d'usage avancés

#### Gestion multi-environnements

Pour gérer plusieurs environnements (développement, test, production), utilisez un schéma de nommage structuré :

**1. Stockage des secrets par environnement :**

```bash
# Environnement de développement
creds_upsert_local_secret "myapp.dev" "database_url"
# postgresql://dev_user:dev_pass@localhost:5432/myapp_dev  # pragma: allowlist secret

creds_upsert_local_secret "myapp.dev" "api_key"
# dev_key_123abc

# Environnement de test
creds_upsert_local_secret "myapp.test" "database_url"
# postgresql://test_user:test_pass@test-db:5432/myapp_test  # pragma: allowlist secret

creds_upsert_local_secret "myapp.test" "api_key"
# test_key_456def

# Environnement de production (local pour tests)
creds_upsert_local_secret "myapp.prod" "database_url"
# postgresql://prod_user:prod_pass@prod-db:5432/myapp_prod  # pragma: allowlist secret

creds_upsert_local_secret "myapp.prod" "api_key"
# prod_key_789ghi
```

**2. Configuration dynamique dans `.env` :**

```bash
#!/usr/bin/env zsh

# Détermination automatique de l'environnement
if [[ "$(basename "$(pwd)")" == *"-dev" ]]; then
    export ENVIRONMENT="dev"
elif [[ "$(basename "$(pwd)")" == *"-test" ]]; then
    export ENVIRONMENT="test"
elif [[ -f ".production" ]]; then
    export ENVIRONMENT="prod"
else
    export ENVIRONMENT="dev"  # Par défaut
fi

echo "🌍 Environnement détecté: $ENVIRONMENT"

# Chargement des secrets spécifiques à l'environnement
DB_URL=$(creds_get_local_secret "myapp.${ENVIRONMENT}" "database_url" 2>/dev/null)
API_KEY=$(creds_get_local_secret "myapp.${ENVIRONMENT}" "api_key" 2>/dev/null)

if [[ -n "$DB_URL" ]]; then
    export DATABASE_URL="$DB_URL"
    echo "  ✅ Base de données $ENVIRONMENT configurée"
else
    echo "  ❌ Base de données $ENVIRONMENT non trouvée"
    echo "     Configurez avec: creds_upsert_local_secret 'myapp.$ENVIRONMENT' 'database_url'"
fi

if [[ -n "$API_KEY" ]]; then
    export API_KEY
    echo "  ✅ Clé API $ENVIRONMENT configurée"
else
    echo "  ❌ Clé API $ENVIRONMENT non trouvée"
fi

# Configuration spécifique par environnement
case "$ENVIRONMENT" in
    "dev")
        export LOG_LEVEL="debug"
        export DEBUG="*"
        export NODE_ENV="development"
        ;;
    "test")
        export LOG_LEVEL="warn"
        export NODE_ENV="test"
        export CI="true"
        ;;
    "prod")
        export LOG_LEVEL="error"
        export NODE_ENV="production"
        export OPTIMIZE="true"
        ;;
esac

echo "⚙️  Configuration $ENVIRONMENT appliquée"
```

**3. Changement d'environnement :**

```bash
# Méthode 1 : Répertoires séparés
mkdir myapp-dev myapp-test myapp-prod
cp .env myapp-dev/ && cp .env myapp-test/ && cp .env myapp-prod/

# Méthode 2 : Fichier indicateur
touch .production  # Force l'environnement prod
rm .production     # Retour à dev

# Méthode 3 : Variable explicite
echo 'export ENVIRONMENT="test"' > .env.local
# Dans .env : [[ -f .env.local ]] && source .env.local
```

#### Intégration CI/CD

L'intégration avec les systèmes CI/CD nécessite une approche hybride : Keychain en local, variables d'environnement en CI.

**Configuration universelle :**

```bash
#!/usr/bin/env zsh

# Fonction de détection de l'environnement
detect_environment() {
    if [[ -n "$CI" || -n "$GITHUB_ACTIONS" || -n "$GITLAB_CI" || -n "$JENKINS_URL" ]]; then
        echo "ci"
    elif [[ "$USER" == "runner" || "$HOME" == "/github/home" ]]; then
        echo "ci"
    else
        echo "local"
    fi
}

ENV_TYPE=$(detect_environment)
echo "🏷️  Environnement détecté: $ENV_TYPE"

# Chargement conditionnel des secrets
case "$ENV_TYPE" in
    "ci")
        echo "🔄 Mode CI/CD - Utilisation des variables d'environnement"

        # GitHub Actions / GitLab CI
        export GITHUB_TOKEN="${GITHUB_TOKEN:-$CI_GITHUB_TOKEN}"
        export DATABASE_URL="${DATABASE_URL:-$CI_DATABASE_URL}"
        export API_KEY="${API_KEY:-$CI_API_KEY}"

        # Validation des variables critiques
        if [[ -z "$GITHUB_TOKEN" ]]; then
            echo "❌ ERREUR: GITHUB_TOKEN manquant en CI"
            echo "💡 Configurez le secret dans votre plateforme CI/CD"
            exit 1
        fi

        echo "✅ Variables CI/CD chargées"
        ;;

    "local")
        echo "💻 Mode local - Utilisation du Keychain macOS"

        # Chargement depuis le Keychain avec gestion d'erreur
        if GITHUB_TOKEN=$(creds_get_local_secret "github" "token" 2>/dev/null); then
            export GITHUB_TOKEN
            echo "  ✅ Token GitHub chargé depuis le Keychain"
        else
            echo "  ❌ Token GitHub non trouvé dans le Keychain"
            echo "     Exécutez: creds_upsert_local_secret 'github' 'token'"
            return 1
        fi

        if DATABASE_URL=$(creds_get_local_secret "myapp.${ENVIRONMENT:-dev}" "database_url" 2>/dev/null); then
            export DATABASE_URL
            echo "  ✅ URL base de données chargée depuis le Keychain"
        else
            echo "  ⚠️  URL base de données non trouvée - mode dégradé"
        fi
        ;;
esac

# Configuration commune
export NODE_ENV="${NODE_ENV:-development}"
export LOG_LEVEL="${LOG_LEVEL:-info}"

echo "🚀 Configuration $ENV_TYPE terminée"
```

**Configuration spécifique GitHub Actions :**

```yaml
# .github/workflows/ci.yml
name: CI
on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    env:
      # Variables disponibles dans l'environnement
      GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
      DATABASE_URL: ${{ secrets.TEST_DATABASE_URL }}
      API_KEY: ${{ secrets.TEST_API_KEY }}
      CI: true
      ENVIRONMENT: test

    steps:
      - uses: actions/checkout@v3
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '18'

      - name: Load environment
        run: |
          # Votre script .env détectera automatiquement CI=true
          source ./.env
          echo "Environment loaded successfully"

      - name: Run tests
        run: npm test
```

**Avantages de cette approche :**

- ✅ **Sécurité locale** : Secrets chiffrés dans le Keychain
- ✅ **Compatibilité CI** : Variables d'environnement standard
- ✅ **Détection automatique** : Pas de configuration manuelle
- ✅ **Gestion d'erreur** : Messages explicites pour le débogage
- ✅ **Flexibilité** : Supporte multiple plateformes CI/CD

## Comparaison avec d'autres solutions

| Solution | Sécurité | Simplicité | Intégration macOS |
|----------|----------|------------|------------------|
| **Keychain + autoenv** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| Fichiers .env | ⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ |
| HashiCorp Vault | ⭐⭐⭐⭐⭐ | ⭐⭐ | ⭐⭐ |
| AWS Secrets Manager | ⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐ |
| 1Password CLI | ⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐⭐ |

## Conclusion

Cette approche offre un équilibre optimal entre sécurité et productivité pour les développeurs macOS. En combinant le Keychain système, autoenv et des fonctions shell sur mesure, nous obtenons :

- **Sécurité renforcée** : Chiffrement matériel, pas de stockage en clair
- **Expérience développeur fluide** : Chargement automatique, interface simple
- **Maintenabilité** : Configuration centralisée, gestion d'erreurs robuste

L'investissement initial en configuration est rapidement rentabilisé par la tranquillité d'esprit et la réduction des risques de sécurité.

## Ressources

- [Documentation security(1)](https://ss64.com/osx/security.html)
- [autoenv sur GitHub](https://github.com/hyperupcall/autoenv)
- [Guide de sécurité Apple](https://support.apple.com/guide/keychain-access/)
- [OWASP Secrets Management](https://cheatsheetseries.owasp.org/cheatsheets/Secrets_Management_Cheat_Sheet.html)
