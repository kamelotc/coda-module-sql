# 📚 Découverte des données : premiers SELECT et LIMIT

## 🎯 Objectifs du cours

- Comprendre la commande `SELECT` pour interroger une base de données
- Apprendre à limiter le nombre de résultats avec `LIMIT`
- Pratiquer sur la base de données **codaSchool**

---

## 🔍 Qu'est-ce qu'une requête SELECT ?

La commande `SELECT` est la **requête la plus importante** en SQL. Elle permet de :
- **Consulter** les données d'une ou plusieurs tables
- **Afficher** les informations stockées dans la base
- **Explorer** le contenu de vos tables

> 💡 **Pensez à SELECT comme à "montrer-moi..."**

---

## 📝 Syntaxe de base

```sql
SELECT colonnes
FROM nom_de_la_table;
```

### Les composants :
- **SELECT** : ce que vous voulez voir
- **FROM** : d'où viennent les données
- **;** : termine la requête (obligatoire)

---

## ⭐ SELECT * : Tout afficher

Le symbole `*` signifie "toutes les colonnes"

```sql
SELECT *
FROM student.etudiant;
```

**Résultat** : Affiche TOUS les étudiants avec TOUTES leurs informations
- ⚠️ **Attention** : Sur notre base, cela affiche **2000 étudiants** !
- 📊 Colonnes retournées : `id_etudiant`, `nom`, `prenom`, `email`, `date_naissance`, `id_etablissement`

---

## 🎯 Sélectionner des colonnes spécifiques

Au lieu de tout afficher, choisissons uniquement ce qui nous intéresse :

```sql
SELECT nom, prenom
FROM student.etudiant;
```

**Résultat** : Affiche uniquement les noms et prénoms des 2000 étudiants

### Avec plus de colonnes :

```sql
SELECT nom, prenom, email
FROM student.etudiant;
```

---

## 🚦 Problème : Trop de résultats !

Quand on interroge une table avec des milliers de lignes, on obtient :
- ⏱️ Un temps de réponse long
- 📄 Des pages et des pages de résultats
- 😵 Des données difficiles à analyser

**Solution** : La clause `LIMIT` !

---

## 🔢 LIMIT : Limiter le nombre de résultats

La clause `LIMIT` permet de limiter le nombre de lignes retournées.

### Syntaxe :

```sql
SELECT colonnes
FROM nom_de_la_table
LIMIT nombre;
```

---

## 📋 Exemples avec LIMIT

### Afficher les 5 premiers étudiants

```sql
SELECT *
FROM student.etudiant
LIMIT 5;
```

**Résultat** : Affiche uniquement les 5 premiers étudiants avec toutes leurs informations

---

### Afficher les 10 premiers noms et emails

```sql
SELECT nom, prenom, email
FROM student.etudiant
LIMIT 10;
```

**Résultat** : Affiche les noms, prénoms et emails des 10 premiers étudiants

---

### Découvrir les cours disponibles

```sql
SELECT *
FROM student.cours
LIMIT 20;
```

**Résultat** : Affiche les 20 premiers cours parmi les 100 disponibles
- 📚 Colonnes : `id_cours`, `titre`, `categorie`

---

## 🏫 Explorer les établissements

Notre base contient 6 établissements. Affichons-les tous :

```sql
SELECT *
FROM student.etablissement;
```

**Résultat attendu** :
```
id_etablissement | nom                      | adresse
-----------------|--------------------------|---------------------------------
1                | CODA Dijon               | 15 Rue de la Formation, 21000 Dijon
2                | CODA Orléans             | 42 Avenue du Développement, 45000 Orléans
3                | Université Paris-Saclay  | 3 Rue Joliot Curie, 91190 Gif-sur-Yvette
...
```

> 💡 Ici, `LIMIT` n'est pas nécessaire car il n'y a que 6 lignes !

---

## 🎓 Cas pratique : Explorer les cours

### 1. Voir uniquement les titres de cours

```sql
SELECT titre
FROM student.cours
LIMIT 15;
```

### 2. Voir les cours avec leur catégorie

```sql
SELECT titre, categorie
FROM student.cours
LIMIT 15;
```

**Catégories disponibles** : Informatique, Intelligence Artificielle, Data Science, Management, Finance, Commerce, Mathématiques, etc.

---

## 📊 Explorer les inscriptions

```sql
SELECT *
FROM student.inscription
LIMIT 10;
```

**Résultat** : Les 10 premières inscriptions d'étudiants à des cours
- 📋 Colonnes : `id_inscription`, `id_etudiant`, `id_cours`, `date_inscription`

---

## 📈 Explorer les notes

```sql
SELECT *
FROM student.note
LIMIT 10;
```

**Résultat** : Les 10 premières notes
- 📝 Colonnes : `id_note`, `id_etudiant`, `id_cours`, `valeur`, `date_note`
- 🎯 Les notes sont comprises entre 0 et 20

---

## ✅ Bonnes pratiques

### ✨ DO (À faire)

- ✅ Utilisez `LIMIT` lors de l'exploration d'une nouvelle table
- ✅ Sélectionnez uniquement les colonnes dont vous avez besoin
- ✅ Testez d'abord avec un petit `LIMIT` (5-10 lignes)
- ✅ Utilisez des noms de colonnes explicites plutôt que `*`

### ❌ DON'T (À éviter)

- ❌ Ne faites pas `SELECT * FROM table` sur une grosse table sans `LIMIT`
- ❌ N'utilisez pas un `LIMIT` trop grand au début (ex: LIMIT 10000)
- ❌ Ne laissez pas de `SELECT *` dans votre code de production

---

## 🧪 Exercices pratiques

### Niveau 1 : Débutant

1. Affichez les 3 premiers étudiants (toutes les colonnes)
2. Affichez les noms et prénoms de 8 étudiants
3. Affichez les 5 premiers établissements

### Niveau 2 : Intermédiaire

4. Affichez le titre de 25 cours
5. Affichez les 15 premières notes avec toutes leurs informations
6. Affichez seulement l'email et la date de naissance des 12 premiers étudiants

### Niveau 3 : Confirmé

7. Trouvez combien il y a de catégories de cours différentes (explorez avec LIMIT d'abord)
8. Affichez les adresses de tous les établissements
9. Explorez la table inscription : quelles sont les dates d'inscription ?

---

## 🔧 Configuration avant de commencer

N'oubliez pas de définir le schéma :

```sql
SET search_path TO student;
```

Ou utilisez le nom complet des tables :

```sql
SELECT * FROM student.etudiant LIMIT 5;
```

---

## 📚 Récapitulatif

| Concept | Syntaxe | Usage |
|---------|---------|-------|
| Tout sélectionner | `SELECT *` | Toutes les colonnes |
| Colonnes spécifiques | `SELECT col1, col2` | Colonnes nommées |
| Limiter les résultats | `LIMIT n` | N premières lignes |
| Requête complète | `SELECT * FROM table LIMIT n;` | Commande complète |

---

## 💡 Ce qu'on a appris

✅ `SELECT` permet de consulter les données  
✅ `*` signifie "toutes les colonnes"  
✅ On peut sélectionner des colonnes spécifiques  
✅ `LIMIT` contrôle le nombre de résultats  
✅ C'est la base de l'exploration de données en SQL  


