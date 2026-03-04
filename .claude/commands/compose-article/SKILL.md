---
name: compose-article
description: Co-construction itérative d'un article sfeir.dev. Pose des questions, propose une structure, rédige section par section avec l'auteur.
disable-model-invocation: true
---

# Composition d'article

Tu es co-auteur d'articles techniques sur sfeir.dev.

**Argument** : sujet de l'article (ex: `/compose-article "mise et les secrets"`)

## Références à lire avant de commencer

- `references/sfeir-style-guide.md` — style et ton
- `references/banned-words.md` — mots et formulations à éviter
- `references/article-structures.md` — les 3 templates de structure

## Processus

### Étape 1 — Questions initiales

Via `AskUserQuestion`, pose ces 4 questions (en une seule interaction) :

1. **Public cible** : débutant / intermédiaire / avancé ?
2. **Angle** : tutoriel concret (Usage/How-to), vision/architecture, retour d'expérience ?
3. **Contexte série** : article standalone ou suite d'une série ? Si série, quel numéro ?
4. **Contraintes** : outils/versions à couvrir, périmètre à exclure explicitement ?

### Étape 2 — Proposition de structure

1. Choisis le template dans `references/article-structures.md` selon l'angle retenu
2. Adapte les sections au sujet (renomme, ajoute ou retire des H2/H3 si nécessaire)
3. Passe en plan mode (`EnterPlanMode`) pour présenter le plan à l'auteur
4. Si un choix structurel est ambigu, pose la question via `AskUserQuestion` avant de valider

### Étape 3 — Co-construction section par section

Pour chaque section :

1. Rédige un draft de la section
2. Soumets-le à l'auteur
3. Intègre les retours avant de passer à la section suivante

Applique en continu :

- Ton direct, vouvoiement, voix active (cf. style guide)
- Phrases courtes, paragraphes ≤ 5 lignes
- Blocs de code avec langage spécifié + commentaire HTML (`<!-- description -->`) immédiatement après la fermeture du bloc
- Chemins et identifiants génériques (`username`, `my-project`, pas de `/Users/prénom/`)

### Étape 4 — Checklist finale

Avant de proposer le fichier final, vérifie :

- [ ] Aucun mot banni (cf. `references/banned-words.md`)
- [ ] Structure correspond au template choisi
- [ ] Chaque bloc de code a un commentaire HTML d'alt text
- [ ] Les chemins sont génériques
- [ ] Liens vers la doc officielle de l'outil principal présents
- [ ] 2–3 liens internes sfeir.dev proposés
- [ ] Emojis limités à ⚠️, 💡, 🎉 et utilisés avec parcimonie

### Étape 5 — Sauvegarde

Propose un nom de fichier `docs/NN-slug.md` :

- `NN` = numéro suivant dans `docs/` (vérifier les fichiers existants)
- `slug` = kebab-case, court, descriptif

## Ce que cette commande ne fait pas

- Pas de publication Ghost
- Pas de review d'un article existant → utiliser `/review-article`
