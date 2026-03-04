# Guide de style - Articles SFEIR

## Informations générales

- **Plateforme** : [sfeir.dev](https://www.sfeir.dev) (Ghost.io)
- **Format** : Markdown → Import Ghost

## Structure type d'un article

```
# Titre accrocheur avec le bénéfice principal

## Introduction
- Contexte / problème
- Ce que l'article va couvrir (liste numérotée)

## Concepts clés
- Explications théoriques nécessaires
- Schémas si pertinent

## [Sections techniques]
- Step-by-step avec code
- Explications entre les blocs de code

## Bonnes pratiques / Points importants
- Warnings et tips

## Conclusion
- Récap des bénéfices
- Call to action ou ouverture

---
**Auteur** : [Nom] | **Publié le** : [date]
```

## Ton et style

### Ce qu'on fait
- Style direct, pas de fluff
- Vulgarisation des concepts complexes
- Phrases courtes et percutantes
- Tutoiement implicite (on s'adresse au lecteur avec "vous")

### Ce qu'on évite
- Jargon non expliqué
- Paragraphes trop longs
- Introductions qui tournent autour du pot

## Emojis et marqueurs visuels

| Emoji | Usage |
|-------|-------|
| ⚠️ | Warning, attention, piège à éviter |
| 💡 | Tip, astuce, bonne pratique |
| 🎉 | Succès, félicitations, résultat |

## Blocs de code

- Toujours spécifier le langage (```bash, ```hcl, ```yaml, etc.)
- Commenter uniquement si nécessaire
- Préférer des blocs courts et ciblés
- Ajouter le contexte avant le bloc, pas dedans

## Liens et références

- Lier vers la documentation officielle
- Inclure un repo GitHub avec le code complet quand pertinent
- Citer les sources si concepts empruntés

## Catégories SFEIR

Les articles sont publiés dans les catégories :
- `/securite/` - Sécurité
- `/cloud/` - Cloud (GCP, AWS, Azure)
- `/devops/` - DevOps, CI/CD
- `/ia/` - Intelligence Artificielle, GenAI

## Checklist avant publication

- [ ] Titre clair avec bénéfice
- [ ] Introduction qui pose le "pourquoi"
- [ ] Code testé et fonctionnel
- [ ] Emojis utilisés avec parcimonie
- [ ] Liens vérifiés
- [ ] Relecture orthographe/grammaire
