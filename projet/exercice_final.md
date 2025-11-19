# Exercice Final — Modélisation & Création d'une Base SQL

Module : Introduction aux Bases de Données Relationnelles (PostgreSQL)

## 🎯 Objectif

Mobiliser l'ensemble des compétences vues dans le module :

modélisation, MCD, création de tables, contraintes, seed de données et requêtes analytiques.

**Le sujet est imposé** afin d'assurer un niveau homogène et une évaluation juste.

---

# 📌 Sujet imposé : « Carte des bars à Dijon + prix des bières »

Vous devez construire une base permettant de gérer :

* les bars (nom, adresse, quartier)

* les bières (nom, type, degrés, catégorie…)

* la table des prix (relation N..N entre bars et bières)

* les quartiers (relation 1..N)

Domaines travaillés : relations, cardinalités, seed volumineux, agrégations.

---

# 📦 Livrables obligatoires

**Le livrable final doit être envoyé par mail à Laurent**, contenant :

1. le lien vers votre **repository GitHub**

2. votre nom / prénom / groupe

Chaque élève doit avoir **son propre repository** (pas de travail en groupe).

Structure recommandée du repo :

```
/projet-bd-biere-dijon/
   description_fonctionnelle.md
   mcd.md
   schema.sql
   seed.sql
   queries.md
   feedback.md   (option bonus)
```

---

# 📝 1. Description fonctionnelle

Expliquer :

* les entités principales

* les relations

* les règles métier

* les attributs importants

### Barème (sur 3 points)

* 0 : incomplet / incohérent

* 1 : description minimale

* 2 : description claire mais partielle

* 3 : description complète + cohérente

---

# 🧩 2. MCD (Modèle Conceptuel de Données)

Le MCD doit contenir :

* entités

* attributs

* cardinalités

* relations

* verbes

* un diagramme Mermaid propre

### Barème (sur 4 points)

* 0 : faux

* 1 : entités OK mais relations incorrectes

* 2 : MCD correct mais incomplet

* 3 : MCD propre et cohérent

* 4 : excellent MCD, propre, lisible, cardinalités exactes

---

# 🛠️ 3. Script SQL (`schema.sql`)

Votre schéma doit :

* respecter le MCD

* créer les PK/FK

* ajouter les contraintes (NOT NULL, CHECK, UNIQUE…)

* être exécutable sans erreur

### Barème (sur 6 points)

* 0–1 : script incorrect

* 2–3 : partiellement valide

* 4–5 : schéma correct et cohérent

* 6 : schéma propre, complet, réaliste

---

# 📊 4. Seed SQL (`seed.sql`)

Doit contenir au minimum :

* 10 quartiers

* 20 bars

* 40 bières

* 150 prix (relations)

* données cohérentes

* script exécutable sans modification

### Barème (sur 3 points)

* 0 : seed inexploitable

* 1 : seed très limité

* 2 : seed correct

* 3 : seed riche, cohérent, volumineux

---

# 🔍 5. Requêtes obligatoires (`queries.md`)

5 requêtes à produire :

1. prix moyen de la bière par quartier

2. bars vendant l'IPA la moins chère

3. bières vendues dans ≥ 5 bars

4. bars sans bière à moins de 6€

5. top bar avec panier moyen maximum

### Barème (sur 4 points)

* 0–1 : erreurs importantes

* 2–3 : requêtes correctes

* 4 : requêtes impeccables

---

# ⭐ Bonus (1 point)

Dans `feedback.md`, proposer :

* une amélioration du cours

* ou une idée pédagogique

---

# 🧮 Score final

**Total : 20 points + 1 point bonus**

| Partie                    | Points |
| ------------------------- | ------ |
| Description fonctionnelle | 3      |
| MCD                       | 4      |
| SQL (schema)              | 6      |
| Seed                      | 3      |
| Requêtes                  | 4      |
| Bonus                     | +1     |

---

