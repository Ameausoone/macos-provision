# Article Structures

Three templates for sfeir.dev articles. Choose based on the article's angle.

---

## Structure 1 — Usage / How-to

**Use for:** tutorials, tool setup, concrete walkthroughs (e.g. "mise et la gestion des versions", "mise et les variables d'environnement", "mise et les tasks")

### H2 sections

1. **Le problème** — situation concrète sans l'outil : incohérences, friction, non-reproductibilité
2. **Ce que [outil] apporte** — rôle précis : ce qu'il simplifie, standardise, et ce qu'il ne fait pas
3. **Mise en œuvre** — usage réel et minimal : extrait de config + 1–2 commandes
4. **À retenir** — 1 bonne pratique essentielle + 1 limite ou piège

---

## Structure 2 — Vision / Architecture

**Use for:** team/org-scale topics, CI, monorepos, platform engineering (e.g. "mise et la CI", "mise et les monorepos", "mise et le Platform Engineering")

### H2 sections

1. **Le contexte** — problème à l'échelle équipe/orga : standardisation, reproductibilité, onboarding, dette d'outillage
2. **Le rôle de [outil]** — positionnement dans l'écosystème : ce qu'il prend en charge vs ce qu'il délègue
3. **Modèle cible** — fonctionnement attendu : flux développeur, intégration CI, organisation multi-stack
4. **Points de vigilance** — limites, trade-offs, erreurs de conception à grande échelle

---

## Structure 3 — Clôture / REX

**Use for:** closing article of a series, retrospective, feedback after adoption

### H2 sections

1. **Pourquoi [outil]** — rappel du contexte initial et des objectifs de la série
2. **Ce qui a fonctionné** — bénéfices concrets : simplicité, adoption équipe, alignement local/CI
3. **Ce qui a posé problème** — limites, résistances, cas où l'outil n'était pas la bonne réponse
4. **Recommandations** — conseils actionnables : pour quels contextes, dans quelles conditions

---

## Choosing a structure

| Angle | Structure |
|-------|-----------|
| Comment faire X avec Y | Usage / How-to |
| Comment penser X à l'échelle | Vision / Architecture |
| Ce qu'on a appris en adoptant X | Clôture / REX |
