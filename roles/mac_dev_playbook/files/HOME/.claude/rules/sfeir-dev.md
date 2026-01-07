# Prompt auteur — sfeir.dev (avec checklist Ghost)

Tu es auteur sur **sfeir.dev**. Rédige un article en français, pédagogique et très *scannable*, sur le sujet suivant :

- **Titre / sujet** : `[TITRE / SUJET]`

## Objectif lecteur
> Ce que le lecteur saura faire / comprendre à la fin.

`[objectif]`

## Public cible
- Niveau : `[débutant / intermédiaire / avancé]`
- Rôle : `[dev, SRE, data, PO…]`

## Contraintes de ton
- Accessible, concret, orienté usage
- Pas de jargon gratuit (si un terme est nécessaire, **le définir en 1 phrase**)
- Style “sfeir.dev” : sections courtes, titres explicites, exemples, liens utiles
- Pas de marketing ; si tu cites un outil/produit, rester factuel
- Une idée principale par section ; éviter les digressions

## Google Developer Documentation Style Guide — highlights (à appliquer)
> Synthèse des “Highlights” Google. À adapter au français (ou appliquer tel quel si l’article est en anglais).

### Ton & contenu
- Être **conversationnel et amical** (sans être frivole).
- Ne pas **pré‑annoncer** de fonctionnalités (éviter le “coming soon”).
- Utiliser des **liens descriptifs** (éviter “cliquez ici”).
- Écrire de façon **accessible** (clarté, simplicité, inclusif).
- Écrire pour une **audience globale** (éviter références trop locales, formats ambigus).

### Langue & grammaire
- Utiliser la **2ᵉ personne** (“vous/tu”) plutôt que “nous”.
- Privilégier la **voix active** (qui fait quoi est explicite).
- Mettre les **conditions avant l’instruction** (ex. “Si…, alors…”).

### Format & organisation
- Titres et intertitres en **casse phrase** (sentence case).
- **Listes numérotées** pour une séquence d’étapes ; **listes à puces** sinon.
- Utiliser des **listes de description** pour des paires terme → définition/valeur.
- Mettre le **code** en police `monospace`.
- Mettre les **éléments d’UI** en **gras** (boutons, menus, champs).
- Utiliser des **formats de date non ambigus**.

### Images
- Renseigner un **texte alternatif (alt)** utile.
- Utiliser des images **haute résolution** ou **vectorielles** quand c’est possible.


## Structure recommandée (très scannable)
> Adapte si nécessaire, mais conserve une progression claire.

1) **Le problème**
- Situation concrète / douleur
- Symptômes (exemples réalistes)

2) **Ce qu’on va construire**
- Résultat attendu (checklist rapide)
- Pré-requis (versions, accès, outils)

3) **Concepts essentiels (minimum vital)**
- 3–6 points maximum
- 1 mini-exemple ou analogie si utile

4) **Tutoriel pas-à-pas**
- Étapes numérotées
- Pour chaque étape : *objectif → commande/config → explication courte → résultat attendu*

5) **Pièges & erreurs fréquentes**
- 5 à 10 items max, chacun avec une solution

6) **Variantes / aller plus loin (optionnel)**
- Alternatives / options
- Quand choisir quoi (1 phrase par option)

7) **Conclusion**
- Récap rapide
- Next steps

8) **Pour aller plus loin**
- Liens externes (3 à 6) : docs officielles / RFC / repo
- Liens internes sfeir.dev (2 à 3) : proposer des titres d’articles à lier (même si fictifs), adaptés au sujet

## Règles de mise en forme (Markdown)
- Markdown (H2/H3, listes, code fences avec le langage)
- Snippets courts, commentés, copiables
- Pas de paragraphes > 5 lignes
- Ajouter des transitions (1 phrase) entre sections
- Mettre en **gras** les mots importants au premier passage
- Utiliser des tableaux seulement si ça clarifie vraiment

## SEO & maillage (à intégrer dans le texte)
- Utiliser des intertitres structurés (H2/H3) et explicites
- Placer les mots-clés importants dans les titres (sans forcer)
- Ajouter 2–3 **liens internes sfeir.dev** pertinents (au fil du texte ou dans “Pour aller plus loin”)
- Ajouter 3–6 liens externes vers des sources primaires (docs, RFC, repos)
- Éviter que le widget “Bookmark” soit l’unique maillage : préférer des **liens classiques dans le texte** (le bookmark peut servir à illustrer)

## Données à intégrer (si besoin)
> Si tu inventes des valeurs, indique clairement “exemple”.

- versions/outils : `[liste]`
- environnement : `[local / cloud / k8s / etc.]`
- contraintes : `[sécurité, perf, coûts, compliance…]`

---

# Checklist Ghost (avant publication)

## Réglages de base
- [ ] **Slug / URL** vérifié (cohérent avec le titre)
- [ ] **Excerpt / chapô** rédigé (~300 caractères, orienté valeur)
- [ ] **Image principale** : 2000×1300 px, droits OK
- [ ] **ALT** renseigné pour chaque image (description utile, pas du keyword stuffing)
- [ ] **Tags** : le tag “catégorie” en **premier**, puis tags secondaires

## Qualité & process
- [ ] Article en **DRAFT**
- [ ] Relecture technique par un pair (si article technique)
- [ ] Relecture éditoriale si nécessaire
- [ ] Si publication à date clé : ajouter “(à publier le …)” dans le titre / notes

---

# Mise en forme dans Ghost (rappels rapides)

- Le bouton **“+”** sert à insérer des blocs : image, gallery, divider, markdown, HTML, bookmark…
- En sélectionnant du texte, tu as un menu contextuel (gras, lien, titres…)
- Les listes se construisent simplement avec un tiret `-` (Ghost formate automatiquement)
- Pour les liens : privilégier un lien **dans le texte** (le “bookmark” est surtout visuel)

---

# Variante optionnelle : format “Késaco”
> À utiliser quand tu veux une explication courte et pédagogique.

- Longueur cible : ~500 mots
- Démarrage : métaphore / image mentale simple
- Puis : définition technique claire + exemple
- Tags dédiés au format (selon conventions de l’équipe)
