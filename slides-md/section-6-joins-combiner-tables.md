# 🔗 JOIN : Combiner plusieurs tables

## 🎯 Objectifs du cours

- Comprendre pourquoi combiner plusieurs tables
- Maîtriser INNER JOIN
- Découvrir LEFT JOIN, RIGHT JOIN, FULL JOIN
- Utiliser les alias de tables
- Gérer les ambiguïtés de colonnes
- Pratiquer avec des exemples concrets sur la base codaSchool

---

## 🤔 Pourquoi combiner des tables ?

### Problème : Données dispersées

Nos données sont réparties dans plusieurs tables :

```
Table etudiant          Table note              Table cours
┌─────────────┐        ┌─────────────┐         ┌─────────────┐
│ id_etudiant │        │ id_note     │         │ id_cours    │
│ nom         │        │ id_etudiant │─────────│ titre       │
│ prenom      │        │ id_cours    │─────────│ categorie   │
│ email       │        │ valeur      │         └─────────────┘
└─────────────┘        └─────────────┘
```

**Question** : Comment afficher le nom de l'étudiant avec sa note et le titre du cours ?

**Réponse** : Utiliser `JOIN` pour combiner les tables !

---

## 🔗 Qu'est-ce qu'un JOIN ?

Un **JOIN** permet de **combiner** les lignes de plusieurs tables en une seule requête.

### Principe

On relie les tables grâce aux **clés étrangères** et **clés primaires**.

```
etudiant (1) ────────< (N) note
cours (1) ───────────< (N) note
```

---

## 📊 Types de JOIN

| Type | Description | Résultat |
|------|-------------|----------|
| **INNER JOIN** | Intersection | Lignes qui matchent dans les deux tables |
| **LEFT JOIN** | Toutes les lignes de gauche | + lignes qui matchent à droite |
| **RIGHT JOIN** | Toutes les lignes de droite | + lignes qui matchent à gauche |
| **FULL JOIN** | Union complète | Toutes les lignes des deux tables |

---

## 🎯 INNER JOIN : L'intersection

### Qu'est-ce qu'INNER JOIN ?

`INNER JOIN` retourne **uniquement** les lignes qui ont une correspondance dans les deux tables.

### Syntaxe :

```sql
SELECT colonnes
FROM table1
INNER JOIN table2 ON table1.colonne = table2.colonne;
```

> 💡 **INNER** est optionnel : `JOIN` = `INNER JOIN`

---

## 📝 Exemple 1 : Étudiants avec leurs notes

### Objectif : Afficher nom, prénom et note

```sql
SELECT 
    e.nom,
    e.prenom,
    n.valeur AS note
FROM student.etudiant e
INNER JOIN student.note n ON e.id_etudiant = n.id_etudiant;
```

**Décortiquons** :
- `e` : Alias pour `etudiant` (plus court à écrire)
- `n` : Alias pour `note`
- `e.id_etudiant = n.id_etudiant` : Condition de jointure

**Résultat** : Toutes les combinaisons étudiant-note qui existent

---

## 🔍 Alias de tables

### Pourquoi utiliser des alias ?

Les alias rendent les requêtes **plus lisibles** et **plus courtes**.

### Syntaxe :

```sql
FROM table1 alias1
JOIN table2 alias2 ON alias1.colonne = alias2.colonne
```

### Exemples :

```sql
-- Sans alias (long)
SELECT student.etudiant.nom, student.note.valeur
FROM student.etudiant
INNER JOIN student.note ON student.etudiant.id_etudiant = student.note.id_etudiant;

-- Avec alias (court et lisible)
SELECT e.nom, n.valeur
FROM student.etudiant e
INNER JOIN student.note n ON e.id_etudiant = n.id_etudiant;
```

---

## 📚 Exemple 2 : Étudiants avec leurs cours

### Objectif : Afficher nom, prénom et titre du cours

```sql
SELECT 
    e.nom,
    e.prenom,
    c.titre AS cours
FROM student.etudiant e
INNER JOIN student.inscription i ON e.id_etudiant = i.id_etudiant
INNER JOIN student.cours c ON i.id_cours = c.id_cours;
```

**Explication** :
1. Joint `etudiant` avec `inscription` (via `id_etudiant`)
2. Joint le résultat avec `cours` (via `id_cours`)

**Résultat** : Tous les étudiants avec leurs cours inscrits

---

## 🎓 Exemple 3 : Notes complètes avec détails

### Objectif : Afficher nom, prénom, cours et note

```sql
SELECT 
    e.nom,
    e.prenom,
    c.titre AS cours,
    n.valeur AS note
FROM student.etudiant e
INNER JOIN student.note n ON e.id_etudiant = n.id_etudiant
INNER JOIN student.cours c ON n.id_cours = c.id_cours;
```

**Résultat** : Toutes les notes avec les détails complets

**Exemple de résultat** :
```
nom      | prenom | cours                          | note
---------|--------|--------------------------------|------
Dupont   | Jean   | Introduction aux Bases de Données | 15.50
Martin   | Sophie | Machine Learning Fondamentaux  | 18.00
Gauthier | Laurent| Prof de SQL                    | 20.00 🥚
```

---

## 🏫 Exemple 4 : Étudiants avec leur établissement

### Objectif : Afficher nom, prénom et nom de l'établissement

```sql
SELECT 
    e.nom,
    e.prenom,
    etab.nom AS etablissement
FROM student.etudiant e
INNER JOIN student.etablissement etab ON e.id_etablissement = etab.id_etablissement;
```

**Résultat** : Tous les étudiants avec le nom de leur établissement

---

## 🔍 Gérer les ambiguïtés de colonnes

### Problème : Colonnes avec le même nom

Si deux tables ont une colonne avec le même nom, il faut **préciser** la table :

```sql
-- ❌ ERREUR : Ambiguïté sur "nom"
SELECT nom
FROM student.etudiant e
INNER JOIN student.etablissement etab ON e.id_etablissement = etab.id_etablissement;

-- ✅ CORRECT : Préciser la table
SELECT e.nom AS nom_etudiant, etab.nom AS nom_etablissement
FROM student.etudiant e
INNER JOIN student.etablissement etab ON e.id_etablissement = etab.id_etablissement;
```

---

## 📊 LEFT JOIN : Toutes les lignes de gauche

### Qu'est-ce qu'LEFT JOIN ?

`LEFT JOIN` retourne **toutes les lignes** de la table de gauche, même s'il n'y a pas de correspondance à droite.

### Syntaxe :

```sql
SELECT colonnes
FROM table1
LEFT JOIN table2 ON table1.colonne = table2.colonne;
```

---

## 📝 Exemple LEFT JOIN : Tous les étudiants, même sans notes

```sql
SELECT 
    e.nom,
    e.prenom,
    n.valeur AS note
FROM student.etudiant e
LEFT JOIN student.note n ON e.id_etudiant = n.id_etudiant;
```

**Résultat** :
- ✅ Tous les étudiants sont affichés
- ✅ Les étudiants **sans notes** ont `NULL` dans la colonne `note`

**Exemple de résultat** :
```
nom      | prenom | note
---------|--------|------
Dupont   | Jean   | 15.50
Martin   | Sophie | 18.00
Bernard  | Lucas  | NULL  ← Pas de note
```

---

## 🎯 Cas d'usage LEFT JOIN

### Trouver les étudiants sans notes

```sql
SELECT 
    e.nom,
    e.prenom
FROM student.etudiant e
LEFT JOIN student.note n ON e.id_etudiant = n.id_etudiant
WHERE n.id_note IS NULL;
```

**Résultat** : Uniquement les étudiants qui n'ont **aucune note**

---

### Trouver les cours sans étudiants inscrits

```sql
SELECT 
    c.titre AS cours
FROM student.cours c
LEFT JOIN student.inscription i ON c.id_cours = i.id_cours
WHERE i.id_inscription IS NULL;
```

**Résultat** : Les cours auxquels **personne n'est inscrit**

---

## ➡️ RIGHT JOIN : Toutes les lignes de droite

### Qu'est-ce qu'RIGHT JOIN ?

`RIGHT JOIN` retourne **toutes les lignes** de la table de droite, même s'il n'y a pas de correspondance à gauche.

### Syntaxe :

```sql
SELECT colonnes
FROM table1
RIGHT JOIN table2 ON table1.colonne = table2.colonne;
```

---

## 📝 Exemple RIGHT JOIN

```sql
SELECT 
    e.nom,
    e.prenom,
    n.valeur AS note
FROM student.etudiant e
RIGHT JOIN student.note n ON e.id_etudiant = n.id_etudiant;
```

**Résultat** :
- ✅ Toutes les notes sont affichées
- ✅ Les notes **sans étudiant** (impossible normalement) auraient `NULL` dans nom/prenom

> 💡 **Note** : RIGHT JOIN est rarement utilisé. On préfère inverser l'ordre et utiliser LEFT JOIN.

---

## 🔄 FULL JOIN : Union complète

### Qu'est-ce qu'FULL JOIN ?

`FULL JOIN` retourne **toutes les lignes** des deux tables, avec `NULL` là où il n'y a pas de correspondance.

### Syntaxe :

```sql
SELECT colonnes
FROM table1
FULL JOIN table2 ON table1.colonne = table2.colonne;
```

---

## 📝 Exemple FULL JOIN

```sql
SELECT 
    e.nom,
    e.prenom,
    n.valeur AS note
FROM student.etudiant e
FULL JOIN student.note n ON e.id_etudiant = n.id_etudiant;
```

**Résultat** :
- ✅ Tous les étudiants (même sans notes)
- ✅ Toutes les notes (même sans étudiants - cas théorique)

---

## 🎯 Comparaison visuelle des JOINs

### Schéma conceptuel :

```
Table A          Table B
┌─────┐          ┌─────┐
│  1  │          │  3  │
│  2  │          │  4  │
│  3  │          │  5  │
└─────┘          └─────┘
```

### INNER JOIN
```
Résultat : {3}
(Les deux ont 3)
```

### LEFT JOIN
```
Résultat : {1, 2, 3}
(Tout A + correspondances B)
```

### RIGHT JOIN
```
Résultat : {3, 4, 5}
(Tout B + correspondances A)
```

### FULL JOIN
```
Résultat : {1, 2, 3, 4, 5}
(Tout A + tout B)
```

---

## 🔍 WHERE avec JOIN

### Filtrer les résultats après jointure

```sql
SELECT 
    e.nom,
    e.prenom,
    n.valeur AS note
FROM student.etudiant e
INNER JOIN student.note n ON e.id_etudiant = n.id_etudiant
WHERE n.valeur > 15;
```

**Résultat** : Uniquement les étudiants avec des notes supérieures à 15

---

### Filtrer avant la jointure (plus efficace)

```sql
SELECT 
    e.nom,
    e.prenom,
    n.valeur AS note
FROM student.etudiant e
INNER JOIN (
    SELECT * FROM student.note WHERE valeur > 15
) n ON e.id_etudiant = n.id_etudiant;
```

> 💡 **Note** : Cette syntaxe avancée sera vue plus tard

---

## 📊 ORDER BY avec JOIN

### Trier les résultats combinés

```sql
SELECT 
    e.nom,
    e.prenom,
    c.titre AS cours,
    n.valeur AS note
FROM student.etudiant e
INNER JOIN student.note n ON e.id_etudiant = n.id_etudiant
INNER JOIN student.cours c ON n.id_cours = c.id_cours
ORDER BY n.valeur DESC;
```

**Résultat** : Notes triées de la plus haute à la plus basse

---

## 🎓 Exemple complet : Top 10 des meilleures notes

```sql
SELECT 
    e.nom,
    e.prenom,
    c.titre AS cours,
    n.valeur AS note
FROM student.etudiant e
INNER JOIN student.note n ON e.id_etudiant = n.id_etudiant
INNER JOIN student.cours c ON n.id_cours = c.id_cours
ORDER BY n.valeur DESC
LIMIT 10;
```

**Résultat** : Les 10 meilleures notes avec tous les détails

**Note** : La première devrait être Laurent Gauthier avec 20/20 dans "Prof de SQL" 🥚

---

## 🔢 Fonctions d'agrégation avec JOIN

### Compter les notes par étudiant

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

**Résultat** : Nombre de notes par étudiant (0 pour ceux sans notes)

> 💡 **Note** : GROUP BY sera vu dans le prochain cours

---

### Moyenne des notes par cours

```sql
SELECT 
    c.titre AS cours,
    ROUND(AVG(n.valeur), 2) AS moyenne_notes
FROM student.cours c
LEFT JOIN student.note n ON c.id_cours = n.id_cours
GROUP BY c.id_cours, c.titre
ORDER BY moyenne_notes DESC;
```

**Résultat** : Moyenne des notes pour chaque cours

---

## 🥚 Bonus : Trouver les easter eggs avec JOIN

### Laurent Gauthier et sa note parfaite

```sql
SELECT 
    e.nom,
    e.prenom,
    etab.nom AS etablissement,
    c.titre AS cours,
    n.valeur AS note
FROM student.etudiant e
INNER JOIN student.etablissement etab ON e.id_etablissement = etab.id_etablissement
INNER JOIN student.note n ON e.id_etudiant = n.id_etudiant
INNER JOIN student.cours c ON n.id_cours = c.id_cours
WHERE e.nom = 'Gauthier' AND e.prenom = 'Laurent';
```

**Résultat** : Laurent Gauthier (UTBM) avec 20/20 dans "Prof de SQL" 🥚

---

### Yoan Thirion et sa note très faible

```sql
SELECT 
    e.nom,
    e.prenom,
    etab.nom AS etablissement,
    c.titre AS cours,
    n.valeur AS note
FROM student.etudiant e
INNER JOIN student.etablissement etab ON e.id_etablissement = etab.id_etablissement
INNER JOIN student.note n ON e.id_etudiant = n.id_etudiant
INNER JOIN student.cours c ON n.id_cours = c.id_cours
WHERE e.nom = 'Thirion' AND e.prenom = 'Yoan';
```

**Résultat** : Yoan Thirion (CODA Dijon) avec 0.5/20 dans "Introduction aux Bases de Données" 🥚

---

## ⚠️ Erreurs courantes avec JOIN

### 1. Oublier la condition ON

```sql
-- ❌ ERREUR : Pas de condition de jointure
SELECT e.nom, n.valeur
FROM student.etudiant e
INNER JOIN student.note n;
```

**Erreur** : Produit cartésien (toutes les combinaisons possibles) = **millions de lignes** !

---

### 2. Mauvais alias

```sql
-- ❌ ERREUR : Alias non défini
SELECT etudiant.nom, n.valeur
FROM student.etudiant e
INNER JOIN student.note n ON e.id_etudiant = n.id_etudiant;
```

**Solution** : Utiliser `e.nom` au lieu de `etudiant.nom`

---

### 3. Ambiguïté de colonnes

```sql
-- ❌ ERREUR : Ambiguïté sur "nom"
SELECT nom
FROM student.etudiant e
INNER JOIN student.etablissement etab ON e.id_etablissement = etab.id_etablissement;
```

**Solution** : Préciser `e.nom` ou `etab.nom`

---

## 📋 Bonnes pratiques avec JOIN

### ✅ DO (À faire)

- ✅ Utiliser des alias courts et clairs (`e`, `n`, `c`)
- ✅ Toujours spécifier la condition `ON`
- ✅ Préfixer les colonnes avec l'alias (`e.nom`, `n.valeur`)
- ✅ Tester avec `LIMIT` sur de grandes tables
- ✅ Utiliser `LEFT JOIN` si on veut toutes les lignes de gauche

### ❌ DON'T (À éviter)

- ❌ Oublier la condition `ON` (produit cartésien)
- ❌ Utiliser des noms de tables complets partout
- ❌ Créer des ambiguïtés de colonnes
- ❌ Faire trop de JOINs dans une seule requête (max 3-4)

---

## 🧪 Exercices pratiques

### Niveau 1 : JOINs simples

1. Affichez tous les étudiants avec le nom de leur établissement
2. Affichez toutes les notes avec le nom de l'étudiant et le titre du cours
3. Affichez tous les étudiants inscrits avec le titre de leur cours

### Niveau 2 : LEFT JOIN

4. Trouvez tous les étudiants qui n'ont aucune note
5. Trouvez tous les cours auxquels personne n'est inscrit
6. Affichez tous les étudiants avec leurs notes (même ceux sans notes)

### Niveau 3 : JOINs multiples

7. Affichez nom, prénom, établissement, cours et note pour toutes les notes
8. Trouvez les 5 meilleures notes avec tous les détails (étudiant, cours, établissement)
9. Calculez la moyenne des notes par établissement

---

## 📋 Récapitulatif

| Type JOIN | Description | Quand l'utiliser |
|-----------|-------------|------------------|
| **INNER JOIN** | Intersection | Quand on veut uniquement les correspondances |
| **LEFT JOIN** | Toutes les lignes de gauche | Quand on veut toutes les lignes de gauche + correspondances |
| **RIGHT JOIN** | Toutes les lignes de droite | Rarement utilisé (préférer LEFT JOIN inversé) |
| **FULL JOIN** | Union complète | Quand on veut toutes les lignes des deux tables |

---

## 💡 Ce qu'on a appris

✅ Pourquoi combiner plusieurs tables avec JOIN  
✅ INNER JOIN pour les correspondances  
✅ LEFT JOIN pour inclure toutes les lignes de gauche  
✅ Utiliser des alias pour simplifier les requêtes  
✅ Gérer les ambiguïtés de colonnes  
✅ Filtrer et trier les résultats de JOIN  
✅ Utiliser les fonctions d'agrégation avec JOIN  
✅ Éviter les erreurs courantes (produit cartésien, ambiguïtés)  

---

## 🚀 Prochaines étapes

Dans le prochain cours, nous verrons :

- **GROUP BY** : Regrouper les données
- **HAVING** : Filtrer les groupes
- **Fonctions d'agrégation avancées** : Statistiques par groupe

Et plus tard :

- **Sous-requêtes** : Requêtes dans les requêtes
- **Vues** : Sauvegarder des requêtes complexes
- **Index** : Optimiser les performances

