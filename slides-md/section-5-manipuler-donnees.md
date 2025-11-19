# 🔧 Manipuler les données

## 🎯 Objectifs du cours

- Apprendre à insérer des données avec `INSERT`
- Maîtriser `SELECT` simple pour consulter les données
- Filtrer les résultats avec `WHERE`
- Utiliser les fonctions d'agrégation (COUNT, MIN, MAX, AVG)
- Trier les résultats avec `ORDER BY`
- Modifier les données avec `UPDATE`
- Supprimer les données avec `DELETE`

---

## ➕ INSERT : Insérer des données

### Qu'est-ce qu'INSERT ?

La commande `INSERT` permet d'**ajouter de nouvelles lignes** dans une table.

### Syntaxe de base :

```sql
INSERT INTO nom_table (colonne1, colonne2, colonne3)
VALUES (valeur1, valeur2, valeur3);
```

---

## 📝 Exemple : Insérer un nouvel étudiant

### Structure de la table `etudiant` :

```sql
CREATE TABLE student.etudiant (
    id_etudiant SERIAL PRIMARY KEY,      -- Auto-incrémenté
    nom VARCHAR(255) NOT NULL,
    prenom VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    date_naissance DATE NOT NULL,
    id_etablissement INT NOT NULL
);
```

### Insertion complète :

```sql
INSERT INTO student.etudiant (nom, prenom, email, date_naissance, id_etablissement)
VALUES ('Martin', 'Sophie', 'sophie.martin@coda-school.com', '2002-03-15', 1);
```

**Résultat** : Un nouvel étudiant est ajouté avec `id_etudiant` généré automatiquement.

---

## 🎯 INSERT : Points importants

### 1. Ordre des colonnes

Les colonnes dans `INSERT INTO` doivent correspondre à l'ordre des `VALUES` :

```sql
-- ✅ Correct
INSERT INTO student.etudiant (nom, prenom, email, date_naissance, id_etablissement)
VALUES ('Dupont', 'Jean', 'jean@email.com', '2001-05-12', 1);

-- ❌ Erreur : ordre incorrect
INSERT INTO student.etudiant (nom, prenom, email, date_naissance, id_etablissement)
VALUES ('2001-05-12', 'Jean', 'jean@email.com', 'Dupont', 1);
```

### 2. Colonnes auto-incrémentées

Ne pas inclure les colonnes `SERIAL` (auto-incrémentées) :

```sql
-- ✅ Correct : id_etudiant est généré automatiquement
INSERT INTO student.etudiant (nom, prenom, email, date_naissance, id_etablissement)
VALUES ('Martin', 'Sophie', 'sophie@email.com', '2002-03-15', 1);

-- ❌ Erreur : ne pas spécifier id_etudiant
INSERT INTO student.etudiant (id_etudiant, nom, prenom, ...)
VALUES (1, 'Martin', 'Sophie', ...);
```

---

### 3. Valeurs par défaut (DEFAULT)

Si une colonne a une valeur par défaut, on peut l'omettre :

```sql
-- Table inscription avec DEFAULT NOW()
CREATE TABLE student.inscription (
    date_inscription DATE NOT NULL DEFAULT NOW()
);

-- ✅ On peut omettre date_inscription
INSERT INTO student.inscription (id_etudiant, id_cours)
VALUES (1, 10);
-- date_inscription prendra automatiquement la date du jour
```

---

## 📊 SELECT simple : Rappel

### Syntaxe de base :

```sql
SELECT colonnes
FROM nom_table;
```

### Exemples :

```sql
-- Tous les étudiants
SELECT * FROM student.etudiant;

-- Colonnes spécifiques
SELECT nom, prenom FROM student.etudiant;

-- Avec LIMIT
SELECT nom, prenom, email 
FROM student.etudiant 
LIMIT 10;
```

---

## 🔍 WHERE : Filtrer les résultats

### Qu'est-ce que WHERE ?

La clause `WHERE` permet de **filtrer** les lignes selon des conditions.

### Syntaxe :

```sql
SELECT colonnes
FROM nom_table
WHERE condition;
```

> 💡 **Pensez à WHERE comme à "où..." ou "qui..."**

---

## 🎯 Opérateurs de comparaison

| Opérateur | Signification | Exemple |
|-----------|---------------|---------|
| `=` | Égal à | `nom = 'Dupont'` |
| `!=` ou `<>` | Différent de | `nom != 'Dupont'` |
| `>` | Supérieur à | `valeur > 15` |
| `<` | Inférieur à | `valeur < 10` |
| `>=` | Supérieur ou égal | `valeur >= 15` |
| `<=` | Inférieur ou égal | `valeur <= 10` |

---

## 📝 Exemples WHERE : Filtres simples

### 1. Trouver un étudiant par nom

```sql
SELECT *
FROM student.etudiant
WHERE nom = 'Dupont';
```

**Résultat** : Tous les étudiants nommés "Dupont"

---

### 2. Trouver les étudiants d'un établissement

```sql
SELECT nom, prenom, email
FROM student.etudiant
WHERE id_etablissement = 1;
```

**Résultat** : Tous les étudiants de l'établissement n°1 (CODA Dijon)

---

### 3. Trouver les notes supérieures à 15

```sql
SELECT *
FROM student.note
WHERE valeur > 15;
```

**Résultat** : Toutes les notes supérieures à 15/20 (incluant la note parfaite de 20/20 🥚)

---

### 4. Trouver les notes très faibles

```sql
SELECT *
FROM student.note
WHERE valeur < 1;
```

**Résultat** : Notes inférieures à 1/20 (incluant la note de 0.5 de Yoan Thirion 🥚)

---

### 5. Trouver les notes entre 10 et 15

```sql
SELECT *
FROM student.note
WHERE valeur >= 10 AND valeur <= 15;
```

**Résultat** : Notes entre 10 et 15 inclus

---

## 🔗 Opérateurs logiques

### AND (ET)

```sql
-- Les deux conditions doivent être vraies
SELECT *
FROM student.etudiant
WHERE nom = 'Dupont' AND id_etablissement = 1;
```

**Résultat** : Les Dupont qui sont dans l'établissement 1

---

### OR (OU)

```sql
-- Au moins une condition doit être vraie
SELECT *
FROM student.etudiant
WHERE nom = 'Dupont' OR nom = 'Martin';
```

**Résultat** : Tous les Dupont ET tous les Martin

---

### NOT (NON)

```sql
-- Inverse la condition
SELECT *
FROM student.etudiant
WHERE NOT id_etablissement = 1;
```

**Résultat** : Tous les étudiants SAUF ceux de l'établissement 1

---

## 📅 WHERE avec dates

### Trouver les étudiants nés après 2002

```sql
SELECT nom, prenom, date_naissance
FROM student.etudiant
WHERE date_naissance > '2002-01-01';
```

**Format de date** : `'YYYY-MM-DD'` (année-mois-jour)

---

### Trouver les étudiants nés en 2001

```sql
SELECT nom, prenom, date_naissance
FROM student.etudiant
WHERE date_naissance >= '2001-01-01' 
  AND date_naissance < '2002-01-01';
```

**Résultat** : Tous les étudiants nés en 2001

---

## 🔢 Fonctions d'agrégation : COUNT, MIN, MAX, AVG

### Qu'est-ce qu'une fonction d'agrégation ?

Les fonctions d'agrégation **calculent une valeur** à partir d'un ensemble de lignes.

---

## 📊 COUNT : Compter les lignes

### Compter tous les étudiants

```sql
SELECT COUNT(*)
FROM student.etudiant;
```

**Résultat** : `2002` (nombre total d'étudiants, incluant les easter eggs 🥚)

---

### Compter avec condition

```sql
-- Compter les étudiants de l'établissement 1
SELECT COUNT(*)
FROM student.etudiant
WHERE id_etablissement = 1;
```

**Résultat** : Nombre d'étudiants dans l'établissement 1

---

### Compter les valeurs non NULL

```sql
-- Compter les notes (exclut les NULL)
SELECT COUNT(valeur)
FROM student.note;
```

---

## 📈 MIN et MAX : Minimum et Maximum

### Note minimale

```sql
SELECT MIN(valeur)
FROM student.note;
```

**Résultat** : La note la plus basse : `0.50` (Yoan Thirion dans "Introduction aux Bases de Données" 🥚)

---

### Note maximale

```sql
SELECT MAX(valeur)
FROM student.note;
```

**Résultat** : La note la plus haute : `20.00` (Laurent Gauthier dans "Prof de SQL" 🥚)

---

### Date de naissance la plus ancienne

```sql
SELECT MIN(date_naissance)
FROM student.etudiant;
```

**Résultat** : La date de naissance la plus ancienne (probablement `1990-01-01` - Laurent Gauthier 🥚)

---

### Date de naissance la plus récente

```sql
SELECT MAX(date_naissance)
FROM student.etudiant;
```

**Résultat** : La date de naissance la plus récente

---

## 📊 AVG : Moyenne

### Moyenne des notes

```sql
SELECT AVG(valeur)
FROM student.note;
```

**Résultat** : La moyenne de toutes les notes (ex: `12.45`)

---

### Moyenne avec arrondi

```sql
SELECT ROUND(AVG(valeur), 2)
FROM student.note;
```

**Résultat** : Moyenne arrondie à 2 décimales (ex: `12.45`)

---

## 🎓 Exercices : Calculer les âges

### Calculer l'âge à partir de la date de naissance

PostgreSQL permet de calculer l'âge avec la fonction `AGE()` :

```sql
SELECT 
    nom,
    prenom,
    date_naissance,
    AGE(date_naissance) AS age
FROM student.etudiant
LIMIT 10;
```

**Résultat** : Affiche l'âge de chaque étudiant

---

### Calculer l'âge en années

```sql
SELECT 
    nom,
    prenom,
    date_naissance,
    EXTRACT(YEAR FROM AGE(date_naissance)) AS age_annees
FROM student.etudiant
LIMIT 10;
```

**Résultat** : Âge en années entières (ex: 23, 24, 25...)

---

## 📊 Exercices : Statistiques sur les âges

### 1. Âge minimum

```sql
SELECT MIN(EXTRACT(YEAR FROM AGE(date_naissance))) AS age_minimum
FROM student.etudiant;
```

**Résultat** : L'âge le plus jeune parmi tous les étudiants

---

### 2. Âge maximum

```sql
SELECT MAX(EXTRACT(YEAR FROM AGE(date_naissance))) AS age_maximum
FROM student.etudiant;
```

**Résultat** : L'âge le plus âgé parmi tous les étudiants

---

### 3. Âge moyen

```sql
SELECT ROUND(AVG(EXTRACT(YEAR FROM AGE(date_naissance))), 2) AS age_moyen
FROM student.etudiant;
```

**Résultat** : L'âge moyen de tous les étudiants (ex: `23.45`)

---

### 4. Nombre d'étudiants

```sql
SELECT COUNT(*) AS nombre_etudiants
FROM student.etudiant;
```

**Résultat** : Le nombre total d'étudiants (`2002` avec les easter eggs 🥚)

---

### 5. Combiner toutes les statistiques

```sql
SELECT 
    COUNT(*) AS nombre_etudiants,
    MIN(EXTRACT(YEAR FROM AGE(date_naissance))) AS age_minimum,
    MAX(EXTRACT(YEAR FROM AGE(date_naissance))) AS age_maximum,
    ROUND(AVG(EXTRACT(YEAR FROM AGE(date_naissance))), 2) AS age_moyen
FROM student.etudiant;
```

**Résultat** : Toutes les statistiques en une seule requête

---

## 🥚 Bonus : Trouver les easter eggs

### Trouver Laurent Gauthier et sa note parfaite

```sql
SELECT e.nom, e.prenom, c.titre, n.valeur
FROM student.etudiant e
JOIN student.note n ON e.id_etudiant = n.id_etudiant
JOIN student.cours c ON n.id_cours = c.id_cours
WHERE e.nom = 'Gauthier' AND e.prenom = 'Laurent';
```

**Résultat** : Laurent Gauthier avec 20/20 dans "Prof de SQL" 🥚

> 💡 **Note** : Cette requête utilise JOIN (vu dans un prochain cours)

---

### Trouver Yoan Thirion et sa note très faible

```sql
SELECT e.nom, e.prenom, c.titre, n.valeur
FROM student.etudiant e
JOIN student.note n ON e.id_etudiant = n.id_etudiant
JOIN student.cours c ON n.id_cours = c.id_cours
WHERE e.nom = 'Thirion' AND e.prenom = 'Yoan';
```

**Résultat** : Yoan Thirion avec 0.5/20 dans "Introduction aux Bases de Données" 🥚

---

### Trouver toutes les notes parfaites (20/20)

```sql
SELECT *
FROM student.note
WHERE valeur = 20;
```

**Résultat** : Toutes les notes à 20/20 (incluant Laurent Gauthier 🥚)

---

## 📋 Alias avec AS

### Qu'est-ce qu'un alias ?

Un alias permet de **renommer** une colonne dans le résultat.

### Syntaxe :

```sql
SELECT colonne AS nom_alias
FROM table;
```

### Exemples :

```sql
-- Sans alias
SELECT COUNT(*) FROM student.etudiant;
-- Résultat : count
--            -----
--            2000

-- Avec alias
SELECT COUNT(*) AS nombre_etudiants FROM student.etudiant;
-- Résultat : nombre_etudiants
--            ----------------
--            2000
```

---

## 🔄 ORDER BY : Trier les résultats

### Qu'est-ce qu'ORDER BY ?

La clause `ORDER BY` permet de **trier** les résultats selon une ou plusieurs colonnes.

### Syntaxe :

```sql
SELECT colonnes
FROM table
ORDER BY colonne [ASC|DESC];
```

- `ASC` : Croissant (par défaut) - A à Z, 1 à 10
- `DESC` : Décroissant - Z à A, 10 à 1

---

## 📝 Exemples ORDER BY

### 1. Trier par nom (ordre alphabétique)

```sql
SELECT nom, prenom, email
FROM student.etudiant
ORDER BY nom;
```

**Résultat** : Étudiants triés par nom (A à Z)

---

### 2. Trier par nom décroissant

```sql
SELECT nom, prenom, email
FROM student.etudiant
ORDER BY nom DESC;
```

**Résultat** : Étudiants triés par nom (Z à A)

---

### 3. Trier par note (du plus haut au plus bas)

```sql
SELECT *
FROM student.note
ORDER BY valeur DESC;
```

**Résultat** : Notes triées de la plus haute à la plus basse

---

### 4. Trier par plusieurs colonnes

```sql
SELECT nom, prenom, date_naissance
FROM student.etudiant
ORDER BY nom, prenom;
```

**Résultat** : Tri d'abord par nom, puis par prénom

---

## 🔗 ORDER BY + LIMIT : Les meilleurs résultats

### Les 10 meilleures notes

```sql
SELECT *
FROM student.note
ORDER BY valeur DESC
LIMIT 10;
```

**Résultat** : Les 10 notes les plus élevées (la première devrait être 20.00)

---

### Les 5 étudiants les plus jeunes

```sql
SELECT nom, prenom, date_naissance
FROM student.etudiant
ORDER BY date_naissance DESC
LIMIT 5;
```

**Résultat** : Les 5 étudiants avec les dates de naissance les plus récentes

---

### Les 3 étudiants les plus âgés

```sql
SELECT nom, prenom, date_naissance
FROM student.etudiant
ORDER BY date_naissance ASC
LIMIT 3;
```

**Résultat** : Les 3 étudiants avec les dates de naissance les plus anciennes

---

## ✏️ UPDATE : Modifier les données

### Qu'est-ce qu'UPDATE ?

La commande `UPDATE` permet de **modifier** des données existantes dans une table.

### Syntaxe :

```sql
UPDATE nom_table
SET colonne1 = nouvelle_valeur1,
    colonne2 = nouvelle_valeur2
WHERE condition;
```

> ⚠️ **ATTENTION** : Sans `WHERE`, TOUTES les lignes seront modifiées !

---

## 📝 Exemples UPDATE

### 1. Modifier l'email d'un étudiant

```sql
UPDATE student.etudiant
SET email = 'nouveau.email@coda-school.com'
WHERE id_etudiant = 1;
```

**Résultat** : L'email de l'étudiant n°1 est mis à jour

---

### 2. Modifier plusieurs colonnes

```sql
UPDATE student.etudiant
SET nom = 'Dupont',
    prenom = 'Jean-Pierre'
WHERE id_etudiant = 1;
```

**Résultat** : Nom et prénom de l'étudiant n°1 sont modifiés

---

### 3. Augmenter toutes les notes de 1 point

```sql
UPDATE student.note
SET valeur = valeur + 1
WHERE valeur < 20;
```

**Résultat** : Toutes les notes inférieures à 20 sont augmentées de 1 point

> 💡 **Note** : Les notes à 20 restent à 20 (condition `valeur < 20`)

---

## ⚠️ UPDATE : Précautions importantes

### ❌ DANGER : UPDATE sans WHERE

```sql
-- ⚠️ DANGEREUX : Modifie TOUS les étudiants !
UPDATE student.etudiant
SET email = 'test@email.com';
```

**Résultat** : TOUS les étudiants auront le même email ! 😱

### ✅ Toujours utiliser WHERE

```sql
-- ✅ SÉCURISÉ : Modifie uniquement l'étudiant n°1
UPDATE student.etudiant
SET email = 'test@email.com'
WHERE id_etudiant = 1;
```

---

## 🗑️ DELETE : Supprimer des données

### Qu'est-ce que DELETE ?

La commande `DELETE` permet de **supprimer** des lignes d'une table.

### Syntaxe :

```sql
DELETE FROM nom_table
WHERE condition;
```

> ⚠️ **ATTENTION** : Sans `WHERE`, TOUTES les lignes seront supprimées !

---

## 📝 Exemples DELETE

### 1. Supprimer un étudiant spécifique

```sql
DELETE FROM student.etudiant
WHERE id_etudiant = 1;
```

**Résultat** : L'étudiant n°1 est supprimé

---

### 2. Supprimer les notes inférieures à 5

```sql
DELETE FROM student.note
WHERE valeur < 5;
```

**Résultat** : Toutes les notes inférieures à 5 sont supprimées

---

### 3. Supprimer tous les étudiants d'un établissement

```sql
DELETE FROM student.etudiant
WHERE id_etablissement = 6;
```

**Résultat** : Tous les étudiants de l'établissement n°6 sont supprimés

> ⚠️ **Attention** : Cela peut échouer si des inscriptions ou notes sont liées (contrainte FOREIGN KEY)

---

## ⚠️ DELETE : Précautions importantes

### ❌ DANGER : DELETE sans WHERE

```sql
-- ⚠️ DANGEREUX : Supprime TOUS les étudiants !
DELETE FROM student.etudiant;
```

**Résultat** : TOUS les étudiants sont supprimés ! 😱

### ✅ Toujours utiliser WHERE

```sql
-- ✅ SÉCURISÉ : Supprime uniquement l'étudiant n°1
DELETE FROM student.etudiant
WHERE id_etudiant = 1;
```

---

## 🔗 DELETE CASCADE : Suppression en cascade

### Qu'est-ce que CASCADE ?

Par défaut, PostgreSQL **empêche** la suppression d'un enregistrement si des enregistrements enfants y sont liés (contrainte FOREIGN KEY).

**Exemple de problème** :

```sql
-- ❌ ERREUR : Impossible de supprimer l'étudiant n°1
DELETE FROM student.etudiant
WHERE id_etudiant = 1;
```

**Erreur retournée** :
```
ERROR: update or delete on table "etudiant" violates foreign key constraint
DETAIL: Key (id_etudiant)=(1) is still referenced from table "note".
```

**Raison** : L'étudiant n°1 a des notes associées, donc on ne peut pas le supprimer.

---

### Solution 1 : Supprimer manuellement les enregistrements enfants

```sql
-- 1. D'abord supprimer les notes de l'étudiant
DELETE FROM student.note
WHERE id_etudiant = 1;

-- 2. Supprimer les inscriptions de l'étudiant
DELETE FROM student.inscription
WHERE id_etudiant = 1;

-- 3. Enfin supprimer l'étudiant
DELETE FROM student.etudiant
WHERE id_etudiant = 1;
```

**Inconvénient** : Long et fastidieux si plusieurs tables sont liées

---

### Solution 2 : Utiliser ON DELETE CASCADE

Avec `ON DELETE CASCADE`, la suppression d'un enregistrement parent **supprime automatiquement** tous les enregistrements enfants.

#### Créer une table avec CASCADE :

```sql
CREATE TABLE student.note (
    id_note SERIAL PRIMARY KEY,
    id_etudiant INT NOT NULL,
    id_cours INT NOT NULL,
    valeur NUMERIC(5,2) NOT NULL,
    
    FOREIGN KEY (id_etudiant) 
        REFERENCES student.etudiant(id_etudiant)
        ON DELETE CASCADE,  -- ← Suppression en cascade
    
    FOREIGN KEY (id_cours) 
        REFERENCES student.cours(id_cours)
);
```

#### Comportement avec CASCADE :

```sql
-- Supprimer l'étudiant n°1
DELETE FROM student.etudiant
WHERE id_etudiant = 1;
```

**Résultat** :
- ✅ L'étudiant n°1 est supprimé
- ✅ **Toutes ses notes sont automatiquement supprimées**
- ✅ **Toutes ses inscriptions sont automatiquement supprimées**

---

### Autres options de CASCADE

#### ON DELETE SET NULL

Met à `NULL` la clé étrangère au lieu de supprimer :

```sql
FOREIGN KEY (id_etudiant) 
    REFERENCES student.etudiant(id_etudiant)
    ON DELETE SET NULL
```

**Comportement** : Si l'étudiant est supprimé, `id_etudiant` dans les notes devient `NULL` (au lieu de supprimer la note)

---

#### ON DELETE RESTRICT (par défaut)

Empêche la suppression si des enregistrements enfants existent :

```sql
FOREIGN KEY (id_etudiant) 
    REFERENCES student.etudiant(id_etudiant)
    ON DELETE RESTRICT  -- ← Comportement par défaut
```

**Comportement** : ❌ Erreur si on essaie de supprimer un étudiant qui a des notes

---

### ⚠️ Attention avec CASCADE

**CASCADE peut être dangereux** :

```sql
-- ⚠️ DANGER : Supprime l'étudiant ET toutes ses notes/inscriptions
DELETE FROM student.etudiant
WHERE id_etudiant = 1;
```

**Conséquences** :
- ❌ Perte de toutes les notes de l'étudiant
- ❌ Perte de toutes les inscriptions
- ❌ **Action irréversible** (sauf si sauvegarde)

---

### Quand utiliser CASCADE ?

#### ✅ Utiliser CASCADE quand :
- Les données enfants n'ont **pas de sens** sans le parent
- Exemple : Les notes d'un étudiant n'ont pas de sens si l'étudiant n'existe plus

#### ❌ Ne PAS utiliser CASCADE quand :
- Les données enfants doivent **persister** même si le parent est supprimé
- Exemple : L'historique des commandes doit rester même si le client est supprimé

---

### Exemple pratique : Notre base codaSchool

Dans notre base actuelle, les contraintes sont en `RESTRICT` (par défaut) :

```sql
-- ❌ Échoue si l'étudiant a des notes
DELETE FROM student.etudiant WHERE id_etudiant = 1;
```

**Pour activer CASCADE**, il faudrait modifier la table :

```sql
-- Supprimer l'ancienne contrainte
ALTER TABLE student.note
DROP CONSTRAINT note_id_etudiant_fkey;

-- Recréer avec CASCADE
ALTER TABLE student.note
ADD CONSTRAINT note_id_etudiant_fkey
FOREIGN KEY (id_etudiant) 
REFERENCES student.etudiant(id_etudiant)
ON DELETE CASCADE;
```

> 💡 **Note** : Dans un environnement de production, réfléchissez bien avant d'activer CASCADE !

---

## 🔄 Ordre d'exécution des clauses SQL

### Ordre logique :

```sql
SELECT colonnes                    -- 1. Que sélectionner ?
FROM table                         -- 2. De quelle table ?
WHERE condition                    -- 3. Filtrer les lignes
ORDER BY colonne [ASC|DESC]        -- 4. Trier les résultats
LIMIT nombre;                      -- 5. Limiter le nombre
```

### Exemple complet :

```sql
SELECT nom, prenom, date_naissance
FROM student.etudiant
WHERE id_etablissement = 1
ORDER BY nom ASC
LIMIT 10;
```

**Étapes** :
1. Sélectionne nom, prenom, date_naissance
2. Depuis la table etudiant
3. Où id_etablissement = 1
4. Trie par nom (A à Z)
5. Limite à 10 résultats

---

## 🧪 Exercices pratiques

### Niveau 1 : INSERT et SELECT

1. Insérez un nouvel étudiant dans l'établissement 1
2. Affichez tous les étudiants de l'établissement 1
3. Affichez les étudiants nés après 2002

### Niveau 2 : WHERE et fonctions d'agrégation

4. Trouvez tous les étudiants nommés "Dupont"
5. Comptez le nombre d'étudiants par établissement
6. Calculez la moyenne, le minimum et le maximum des notes
7. Trouvez les notes supérieures à 15

### Niveau 3 : ORDER BY et manipulations

8. Affichez les 10 meilleures notes (triées)
9. Affichez les 5 étudiants les plus jeunes
10. Modifiez l'email d'un étudiant
11. Supprimez une note spécifique

---

## 📋 Récapitulatif

| Commande | Fonction | Exemple |
|----------|----------|---------|
| **INSERT** | Ajouter des données | `INSERT INTO etudiant VALUES (...)` |
| **SELECT** | Consulter des données | `SELECT * FROM etudiant` |
| **WHERE** | Filtrer les résultats | `WHERE nom = 'Dupont'` |
| **COUNT** | Compter les lignes | `SELECT COUNT(*) FROM etudiant` |
| **MIN/MAX** | Minimum/Maximum | `SELECT MIN(valeur) FROM note` |
| **AVG** | Moyenne | `SELECT AVG(valeur) FROM note` |
| **ORDER BY** | Trier les résultats | `ORDER BY nom ASC` |
| **LIMIT** | Limiter le nombre | `LIMIT 10` |
| **UPDATE** | Modifier des données | `UPDATE etudiant SET email = '...'` |
| **DELETE** | Supprimer des données | `DELETE FROM etudiant WHERE id = 1` |
| **ON DELETE CASCADE** | Suppression automatique des enfants | `ON DELETE CASCADE` |
| **ON DELETE RESTRICT** | Empêche suppression si enfants existent | `ON DELETE RESTRICT` (défaut) |
| **ON DELETE SET NULL** | Met FK à NULL au lieu de supprimer | `ON DELETE SET NULL` |

---

## 💡 Ce qu'on a appris

✅ Insérer des données avec INSERT  
✅ Consulter les données avec SELECT  
✅ Filtrer avec WHERE et les opérateurs logiques  
✅ Utiliser les fonctions d'agrégation (COUNT, MIN, MAX, AVG)  
✅ Calculer des statistiques sur les âges  
✅ Trier les résultats avec ORDER BY  
✅ Combiner ORDER BY et LIMIT  
✅ Modifier les données avec UPDATE  
✅ Supprimer les données avec DELETE  
✅ DELETE CASCADE pour supprimer automatiquement les enfants  
✅ ON DELETE RESTRICT, CASCADE, SET NULL : options de suppression  
✅ ⚠️ Toujours utiliser WHERE avec UPDATE et DELETE !  

