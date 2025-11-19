# 📊 Agrégation et GROUP BY

## 🎯 Objectifs du cours

- Maîtriser les fonctions d'agrégation (COUNT, SUM, AVG, MIN, MAX)
- Comprendre GROUP BY pour regrouper les données
- Utiliser HAVING pour filtrer les groupes
- Calculer des statistiques par groupe (moyenne par cours, meilleure note, etc.)
- Différencier WHERE et HAVING

---

## 🔢 Fonctions d'agrégation : Rappel

### Les fonctions d'agrégation

Les fonctions d'agrégation **calculent une valeur** à partir d'un ensemble de lignes.

| Fonction | Description | Exemple |
|----------|-------------|---------|
| `COUNT()` | Compter les lignes | `COUNT(*)` |
| `SUM()` | Somme des valeurs | `SUM(valeur)` |
| `AVG()` | Moyenne | `AVG(valeur)` |
| `MIN()` | Minimum | `MIN(valeur)` |
| `MAX()` | Maximum | `MAX(valeur)` |

---

## 📊 Exemples simples

### Compter tous les étudiants

```sql
SELECT COUNT(*)
FROM student.etudiant;
```

**Résultat** : `2002` (nombre total d'étudiants)

---

### Moyenne des notes

```sql
SELECT AVG(valeur) AS moyenne
FROM student.note;
```

**Résultat** : La moyenne de toutes les notes

---

### Note minimale et maximale

```sql
SELECT 
    MIN(valeur) AS note_minimum,
    MAX(valeur) AS note_maximum
FROM student.note;
```

**Résultat** : 
- Note minimum : `0.50` (Yoan Thirion 🥚)
- Note maximum : `20.00` (Laurent Gauthier 🥚)

---

## 🎯 GROUP BY : Regrouper les données

### Qu'est-ce que GROUP BY ?

`GROUP BY` permet de **regrouper** les lignes qui ont la même valeur dans une ou plusieurs colonnes, puis d'appliquer une fonction d'agrégation sur chaque groupe.

### Syntaxe :

```sql
SELECT colonne, fonction_agregation(colonne)
FROM table
GROUP BY colonne;
```

> 💡 **Pensez à GROUP BY comme à "grouper par..."**

---

## 📝 Exemple 1 : Nombre de notes par étudiant

### Objectif : Compter combien de notes a chaque étudiant

```sql
SELECT 
    id_etudiant,
    COUNT(*) AS nombre_notes
FROM student.note
GROUP BY id_etudiant;
```

**Résultat** : Pour chaque étudiant, le nombre de notes qu'il a

**Exemple de résultat** :
```
id_etudiant | nombre_notes
------------|-------------
1           | 3
2           | 2
3           | 5
...
```

---

### Avec le nom de l'étudiant (utilise JOIN - déjà vu)

```sql
SELECT 
    e.nom,
    e.prenom,
    COUNT(n.id_note) AS nombre_notes
FROM student.etudiant e
LEFT JOIN student.note n ON e.id_etudiant = n.id_etudiant
GROUP BY e.id_etudiant, e.nom, e.prenom
ORDER BY nombre_notes DESC;
```

**Résultat** : Nombre de notes par étudiant, trié du plus au moins

---

## 📚 Exemple 2 : Moyenne des notes par cours

### Objectif : Calculer la moyenne des notes pour chaque cours

```sql
SELECT 
    id_cours,
    AVG(valeur) AS moyenne_notes
FROM student.note
GROUP BY id_cours;
```

**Résultat** : Pour chaque cours, la moyenne des notes

---

### Avec le titre du cours

```sql
SELECT 
    c.titre AS cours,
    ROUND(AVG(n.valeur), 2) AS moyenne_notes
FROM student.cours c
LEFT JOIN student.note n ON c.id_cours = n.id_cours
GROUP BY c.id_cours, c.titre
ORDER BY moyenne_notes DESC;
```

**Résultat** : Moyenne des notes par cours, triée de la plus haute à la plus basse

**Exemple de résultat** :
```
cours                          | moyenne_notes
-------------------------------|-------------
Prof de SQL                    | 20.00 🥚
Machine Learning Fondamentaux  | 15.50
Introduction aux Bases de Données | 12.30
...
```

---

## 🎓 Exemple 3 : Statistiques complètes par cours

### Objectif : Moyenne, minimum, maximum et nombre de notes par cours

```sql
SELECT 
    c.titre AS cours,
    COUNT(n.id_note) AS nombre_notes,
    ROUND(AVG(n.valeur), 2) AS moyenne_notes,
    MIN(n.valeur) AS note_minimum,
    MAX(n.valeur) AS note_maximum
FROM student.cours c
LEFT JOIN student.note n ON c.id_cours = n.id_cours
GROUP BY c.id_cours, c.titre
ORDER BY moyenne_notes DESC;
```

**Résultat** : Statistiques complètes pour chaque cours

---

## 🔍 Règle importante : GROUP BY

### Toutes les colonnes non-agrégées doivent être dans GROUP BY

```sql
-- ❌ ERREUR : "nom" n'est pas dans GROUP BY
SELECT nom, COUNT(*)
FROM student.etudiant
GROUP BY id_etudiant;

-- ✅ CORRECT : Toutes les colonnes non-agrégées sont dans GROUP BY
SELECT nom, prenom, COUNT(*)
FROM student.etudiant
GROUP BY id_etudiant, nom, prenom;
```

**Règle** : Si vous sélectionnez une colonne sans fonction d'agrégation, elle **doit** être dans `GROUP BY`.

---

## 🎯 HAVING : Filtrer les groupes

### Qu'est-ce que HAVING ?

`HAVING` permet de **filtrer les groupes** après le GROUP BY, comme `WHERE` filtre les lignes avant le GROUP BY.

### Syntaxe :

```sql
SELECT colonne, fonction_agregation(colonne)
FROM table
GROUP BY colonne
HAVING condition;
```

> 💡 **Pensez à HAVING comme à "avoir..." ou "qui ont..."**

---

## 📝 Exemple HAVING : Cours avec moyenne supérieure à 15

```sql
SELECT 
    c.titre AS cours,
    ROUND(AVG(n.valeur), 2) AS moyenne_notes
FROM student.cours c
LEFT JOIN student.note n ON c.id_cours = n.id_cours
GROUP BY c.id_cours, c.titre
HAVING AVG(n.valeur) > 15
ORDER BY moyenne_notes DESC;
```

**Résultat** : Uniquement les cours dont la moyenne est supérieure à 15

---

## 🔄 WHERE vs HAVING : La différence

### WHERE : Filtre les lignes AVANT le GROUP BY

```sql
SELECT 
    c.titre AS cours,
    AVG(n.valeur) AS moyenne_notes
FROM student.cours c
LEFT JOIN student.note n ON c.id_cours = n.id_cours
WHERE n.valeur > 10  -- ← Filtre les notes individuelles
GROUP BY c.id_cours, c.titre;
```

**Résultat** : Moyenne calculée uniquement sur les notes > 10

---

### HAVING : Filtre les groupes APRÈS le GROUP BY

```sql
SELECT 
    c.titre AS cours,
    AVG(n.valeur) AS moyenne_notes
FROM student.cours c
LEFT JOIN student.note n ON c.id_cours = n.id_cours
GROUP BY c.id_cours, c.titre
HAVING AVG(n.valeur) > 10;  -- ← Filtre les moyennes
```

**Résultat** : Uniquement les cours dont la moyenne est > 10

---

## 📊 Comparaison WHERE vs HAVING

| Aspect | WHERE | HAVING |
|--------|-------|--------|
| **Quand** | Avant GROUP BY | Après GROUP BY |
| **Filtre** | Les lignes individuelles | Les groupes |
| **Utilise** | Colonnes de la table | Fonctions d'agrégation |
| **Exemple** | `WHERE valeur > 10` | `HAVING AVG(valeur) > 10` |

---

## 🎓 Exemple 4 : Cours avec au moins 5 notes

```sql
SELECT 
    c.titre AS cours,
    COUNT(n.id_note) AS nombre_notes,
    ROUND(AVG(n.valeur), 2) AS moyenne_notes
FROM student.cours c
LEFT JOIN student.note n ON c.id_cours = n.id_cours
GROUP BY c.id_cours, c.titre
HAVING COUNT(n.id_note) >= 5
ORDER BY nombre_notes DESC;
```

**Résultat** : Cours ayant au moins 5 notes, avec leur moyenne

---

## 🏆 Exemple 5 : Meilleure note par cours

### Objectif : Trouver la meilleure note pour chaque cours

```sql
SELECT 
    c.titre AS cours,
    MAX(n.valeur) AS meilleure_note
FROM student.cours c
LEFT JOIN student.note n ON c.id_cours = n.id_cours
GROUP BY c.id_cours, c.titre
ORDER BY meilleure_note DESC;
```

**Résultat** : La meilleure note obtenue dans chaque cours

---

### Avec le nom de l'étudiant qui a eu la meilleure note

```sql
SELECT DISTINCT ON (c.id_cours)
    c.titre AS cours,
    e.nom,
    e.prenom,
    n.valeur AS meilleure_note
FROM student.cours c
LEFT JOIN student.note n ON c.id_cours = n.id_cours
LEFT JOIN student.etudiant e ON n.id_etudiant = e.id_etudiant
ORDER BY c.id_cours, n.valeur DESC;
```

> 💡 **Note** : `DISTINCT ON` est une fonctionnalité PostgreSQL avancée

---

## 📈 Exemple 6 : Statistiques par établissement

### Objectif : Moyenne des notes par établissement

```sql
SELECT 
    etab.nom AS etablissement,
    COUNT(DISTINCT e.id_etudiant) AS nombre_etudiants,
    COUNT(n.id_note) AS nombre_notes,
    ROUND(AVG(n.valeur), 2) AS moyenne_notes
FROM student.etablissement etab
LEFT JOIN student.etudiant e ON etab.id_etablissement = e.id_etablissement
LEFT JOIN student.note n ON e.id_etudiant = n.id_etudiant
GROUP BY etab.id_etablissement, etab.nom
ORDER BY moyenne_notes DESC NULLS LAST;
```

**Résultat** : Statistiques complètes par établissement

**Note** : UTBM devrait avoir une moyenne de 20.00 grâce à Laurent Gauthier 🥚

---

## 🎯 Exemple 7 : Nombre d'inscriptions par cours

```sql
SELECT 
    c.titre AS cours,
    c.categorie,
    COUNT(i.id_etudiant) AS nombre_inscrits
FROM student.cours c
LEFT JOIN student.inscription i ON c.id_cours = i.id_cours
GROUP BY c.id_cours, c.titre, c.categorie
ORDER BY nombre_inscrits DESC;
```

**Résultat** : Nombre d'étudiants inscrits par cours

---

## 🔢 Exemple 8 : Nombre de cours par étudiant

```sql
SELECT 
    e.nom,
    e.prenom,
    COUNT(i.id_cours) AS nombre_cours
FROM student.etudiant e
LEFT JOIN student.inscription i ON e.id_etudiant = i.id_etudiant
GROUP BY e.id_etudiant, e.nom, e.prenom
ORDER BY nombre_cours DESC;
```

**Résultat** : Nombre de cours auxquels chaque étudiant est inscrit

---

## 📊 Exemple 9 : Moyenne par catégorie de cours

```sql
SELECT 
    c.categorie,
    COUNT(DISTINCT c.id_cours) AS nombre_cours,
    COUNT(n.id_note) AS nombre_notes,
    ROUND(AVG(n.valeur), 2) AS moyenne_notes
FROM student.cours c
LEFT JOIN student.note n ON c.id_cours = n.id_cours
GROUP BY c.categorie
ORDER BY moyenne_notes DESC;
```

**Résultat** : Moyenne des notes par catégorie de cours (Informatique, Data Science, etc.)

---

## 🎓 Exercices sur les notes

### Exercice 1 : Moyenne par cours

```sql
SELECT 
    c.titre AS cours,
    ROUND(AVG(n.valeur), 2) AS moyenne_notes
FROM student.cours c
LEFT JOIN student.note n ON c.id_cours = n.id_cours
GROUP BY c.id_cours, c.titre
HAVING COUNT(n.id_note) > 0
ORDER BY moyenne_notes DESC;
```

**Résultat** : Moyenne des notes pour chaque cours ayant au moins une note

---

### Exercice 2 : Meilleure note par cours

```sql
SELECT 
    c.titre AS cours,
    MAX(n.valeur) AS meilleure_note
FROM student.cours c
LEFT JOIN student.note n ON c.id_cours = n.id_cours
GROUP BY c.id_cours, c.titre
HAVING MAX(n.valeur) IS NOT NULL
ORDER BY meilleure_note DESC;
```

**Résultat** : La meilleure note obtenue dans chaque cours

**Note** : "Prof de SQL" devrait avoir 20.00 (Laurent Gauthier 🥚)

---

### Exercice 3 : Statistiques complètes par cours

```sql
SELECT 
    c.titre AS cours,
    COUNT(n.id_note) AS nombre_notes,
    ROUND(AVG(n.valeur), 2) AS moyenne_notes,
    MIN(n.valeur) AS note_minimum,
    MAX(n.valeur) AS note_maximum,
    ROUND(MAX(n.valeur) - MIN(n.valeur), 2) AS ecart_notes
FROM student.cours c
LEFT JOIN student.note n ON c.id_cours = n.id_cours
GROUP BY c.id_cours, c.titre
HAVING COUNT(n.id_note) > 0
ORDER BY moyenne_notes DESC;
```

**Résultat** : Statistiques complètes (moyenne, min, max, écart) par cours

---

## ⚠️ Erreurs courantes avec GROUP BY

### 1. Oublier une colonne dans GROUP BY

```sql
-- ❌ ERREUR : "nom" n'est pas dans GROUP BY
SELECT nom, COUNT(*)
FROM student.etudiant
GROUP BY id_etudiant;

-- ✅ CORRECT
SELECT nom, COUNT(*)
FROM student.etudiant
GROUP BY id_etudiant, nom;
```

---

### 2. Utiliser WHERE avec fonction d'agrégation

```sql
-- ❌ ERREUR : WHERE ne peut pas utiliser AVG()
SELECT c.titre, AVG(n.valeur)
FROM student.cours c
LEFT JOIN student.note n ON c.id_cours = n.id_cours
WHERE AVG(n.valeur) > 15;  -- ❌ Erreur !

-- ✅ CORRECT : Utiliser HAVING
SELECT c.titre, AVG(n.valeur)
FROM student.cours c
LEFT JOIN student.note n ON c.id_cours = n.id_cours
GROUP BY c.id_cours, c.titre
HAVING AVG(n.valeur) > 15;
```

---

### 3. Mélanger colonnes agrégées et non-agrégées sans GROUP BY

```sql
-- ❌ ERREUR : Mélange colonne normale et fonction d'agrégation
SELECT nom, COUNT(*)
FROM student.etudiant;

-- ✅ CORRECT : Utiliser GROUP BY
SELECT nom, COUNT(*)
FROM student.etudiant
GROUP BY nom;
```

---

## 📋 Ordre d'exécution des clauses SQL

### Ordre logique avec GROUP BY :

```sql
SELECT colonnes                    -- 5. Que sélectionner ?
FROM table                         -- 1. De quelle table ?
WHERE condition                    -- 2. Filtrer les lignes
GROUP BY colonnes                  -- 3. Regrouper
HAVING condition                   -- 4. Filtrer les groupes
ORDER BY colonne                   -- 6. Trier
LIMIT nombre;                      -- 7. Limiter
```

### Exemple complet :

```sql
SELECT 
    c.titre,
    AVG(n.valeur) AS moyenne
FROM student.cours c
LEFT JOIN student.note n ON c.id_cours = n.id_cours
WHERE n.valeur IS NOT NULL
GROUP BY c.id_cours, c.titre
HAVING AVG(n.valeur) > 10
ORDER BY moyenne DESC
LIMIT 10;
```

**Étapes** :
1. FROM : Depuis les tables cours et note
2. WHERE : Filtrer les notes non NULL
3. GROUP BY : Regrouper par cours
4. HAVING : Filtrer les cours avec moyenne > 10
5. SELECT : Sélectionner titre et moyenne
6. ORDER BY : Trier par moyenne décroissante
7. LIMIT : Limiter à 10 résultats

---

## 🧪 Exercices pratiques

### Niveau 1 : GROUP BY simple

1. Compter le nombre de notes par étudiant
2. Calculer la moyenne des notes par cours
3. Trouver la meilleure note par cours

### Niveau 2 : HAVING

4. Trouver les cours avec une moyenne supérieure à 15
5. Trouver les cours ayant au moins 10 notes
6. Trouver les étudiants ayant plus de 5 notes

### Niveau 3 : Statistiques avancées

7. Calculer les statistiques complètes par cours (moyenne, min, max, nombre)
8. Calculer la moyenne des notes par établissement
9. Trouver les cours avec le plus grand écart entre la meilleure et la pire note

---

## 📋 Récapitulatif

| Concept | Description | Exemple |
|---------|-------------|---------|
| **COUNT()** | Compter les lignes | `COUNT(*)` |
| **SUM()** | Somme | `SUM(valeur)` |
| **AVG()** | Moyenne | `AVG(valeur)` |
| **MIN()** | Minimum | `MIN(valeur)` |
| **MAX()** | Maximum | `MAX(valeur)` |
| **GROUP BY** | Regrouper | `GROUP BY colonne` |
| **HAVING** | Filtrer les groupes | `HAVING AVG(valeur) > 10` |

---

## 💡 Ce qu'on a appris

✅ Utiliser les fonctions d'agrégation (COUNT, SUM, AVG, MIN, MAX)  
✅ Regrouper les données avec GROUP BY  
✅ Filtrer les groupes avec HAVING  
✅ Différencier WHERE (filtre lignes) et HAVING (filtre groupes)  
✅ Calculer des statistiques par groupe (moyenne par cours, meilleure note)  
✅ Éviter les erreurs courantes (colonnes manquantes dans GROUP BY)  
✅ Comprendre l'ordre d'exécution des clauses SQL  

---

## 🚀 Prochaines étapes

Dans les prochains cours, nous verrons :

- **Sous-requêtes** : Requêtes dans les requêtes
- **Vues** : Sauvegarder des requêtes complexes
- **Index** : Optimiser les performances
- **Transactions** : Gérer les opérations multiples

