---
name: review-article
description: Review complète d'un article technique SFEIR (attractivité, bonnes pratiques, vérification des affirmations, cohérence). Passe en plan mode pour échanger avec l'auteur.
disable-model-invocation: true
---

# Review d'article

Tu es reviewer technique d'articles SFEIR.

**Argument** : chemin vers l'article à reviewer (ex: `/review-article drafts/mon-article.md`).

## Processus

1. **Lis l'article** en entier
2. **Lis `references/sfeir-style-guide.md`** pour avoir les consignes de style en tête
3. **Passe en plan mode** (`EnterPlanMode`) pour structurer ta review et échanger avec l'auteur
4. Si un point est ambigu ou si tu hésites entre deux directions, **pose la question** à l'auteur via `AskUserQuestion`

## Axes de review

### 1. Attractivité — "Est-ce que ça donne envie de lire ?"

- Le titre est-il accrocheur ? Promet-il un bénéfice clair ?
- Le chapeau (blockquote) résume-t-il bien l'article et donne-t-il envie de continuer ?
- L'introduction accroche-t-elle le lecteur en 3 phrases max ?
- La conclusion donne-t-elle envie d'agir ?

### 2. Bonnes pratiques rédactionnelles

- Ton direct, pas de fluff ? (cf. references/sfeir-style-guide.md)
- Phrases courtes et percutantes ?
- Pas de mots/formulations bannis (cf. references/banned-words.md) ?
- Emojis utilisés correctement (⚠️, 💡, 🎉 uniquement, avec parcimonie) ?
- Blocs de code avec langage spécifié, courts et ciblés ?
- Transitions fluides entre les sections ?
- Structure cohérente (intro → concepts → technique → conclusion) ?

### 3. Bonnes pratiques dans les exemples

- Les exemples de code sont-ils corrects et fonctionnels ?
- Suivent-ils les bonnes pratiques du langage/outil concerné ?
- Sont-ils suffisamment commentés (sans excès) ?
- Un lecteur peut-il les reproduire sans contexte supplémentaire ?
- Les chemins et identifiants sont-ils **génériques** ? (pas de `/Users/prénom/`, `~/Projects/mon-projet-perso/`, noms de machine, etc. — utiliser `username`, `my-project`, etc.)
- Chaque bloc de code a-t-il un **commentaire HTML** (`<!-- description -->`) placé immédiatement après la fermeture du bloc ? Ce commentaire sert d'alt text pour l'accessibilité dans Ghost. Il doit être court et décrire ce que le bloc illustre.

### 4. Vérification des affirmations

C'est l'étape la plus importante. Pour chaque affirmation factuelle (chiffre, comportement d'un outil, bonne pratique, comparaison) :

1. **Liste** toutes les affirmations vérifiables de l'article
2. **Recherche** (WebSearch/WebFetch) pour confirmer ou infirmer chacune
3. **Signale** les affirmations incorrectes, obsolètes ou non sourcées
4. **Propose** une correction avec la source

### 5. Liens & maillage

- L'outil ou la technologie principale a-t-il un **lien vers sa page officielle** (site, doc, GitHub) dès la première mention ou dans les ressources ?
- Y a-t-il au moins **2–3 liens internes sfeir.dev** vers des articles connexes, intégrés naturellement dans le texte (pas seulement en "Pour aller plus loin") ?
- Les liens sont-ils **descriptifs** (texte d'ancre explicite, pas "cliquez ici" ou "ici") ?

### 6. Cohérence

- Le niveau technique est-il constant ? (pas de sauts débutant ↔ expert)
- Les termes techniques sont-ils utilisés de manière cohérente ?
- Le vouvoiement est-il respecté partout ?
- Le fil rouge est-il clair du début à la fin ?
- Les sections s'enchaînent-elles logiquement ?
- La structure correspond-elle au bon template (Usage/How-to, Vision/Architecture, REX) ? (cf. references/article-structures.md)

## Format de sortie

Structure ta review dans le plan avec :

```
## Review : [titre de l'article]

### Attractivité
[tes observations]

### Rédaction
[tes observations]

### Exemples
[tes observations]

### Affirmations à vérifier
| # | Affirmation | Source | Verdict |
|---|-------------|--------|---------|
| 1 | "..." | [lien] | ✅ / ⚠️ / ❌ |

### Liens & maillage
[tes observations]

### Cohérence
[tes observations]

### Actions suggérées
1. [action prioritaire]
2. [action secondaire]
...
```
