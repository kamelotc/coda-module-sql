# 🏗️ Fondamentaux du SQL

## 🎯 Objectifs du cours

- Comprendre la structure d'une base de données (tables, colonnes, lignes)
- Découvrir les types de données SQL
- Maîtriser les clés primaires et étrangères
- Apprendre à créer des tables avec CREATE TABLE
- Comprendre les relations entre tables

---

## 📊 Tables, colonnes, lignes : rappel fondamental

### Qu'est-ce qu'une table ?

Une **table** est comme un **tableau Excel** :
- Elle stocke des données de manière structurée
- Elle a un nom unique dans la base de données
- Elle contient des lignes et des colonnes

### Exemple : La table `etudiant`

```
┌────────────┬─────────┬─────────┬──────────────────────┬─────────────────┬──────────────────┐
│id_etudiant │   nom   │ prenom  │        email         │ date_naissance  │ id_etablissement │
├────────────┼─────────┼─────────┼──────────────────────┼─────────────────┼──────────────────┤
│     1      │ Dupont  │  Jean   │ etudiant1@coda.com   │   2001-05-12    │        1         │
│     2      │ Martin  │ Sophie  │ etudiant2@coda.com   │   2002-08-23    │        2         │
│     3      │ Bernard │  Lucas  │ etudiant3@coda.com   │   2000-11-30    │        1         │
└────────────┴─────────┴─────────┴──────────────────────┴─────────────────┴──────────────────┘
```

---

## 📐 Les trois composants

### 1️⃣ **TABLE** = Le conteneur
- Nom : `etudiant`
- Fonction : Stocker tous les étudiants

### 2️⃣ **COLONNE** = Les propriétés
- `id_etudiant`, `nom`, `prenom`, `email`, `date_naissance`, `id_etablissement`
- Chaque colonne a un **type de données** spécifique

### 3️⃣ **LIGNE** (ou enregistrement) = Une entrée
- Chaque ligne représente **un étudiant**
- Exemple : Jean Dupont est une ligne

---

## 🎨 Types de données SQL

Les types de données définissent **ce qu'on peut stocker** dans une colonne.

### Types numériques

| Type | Description | Exemple |
|------|-------------|---------|
| `INTEGER` ou `INT` | Nombres entiers | 42, -10, 2024 |
| `SERIAL` | Entier auto-incrémenté | 1, 2, 3, 4... |
| `NUMERIC(p,s)` | Nombres décimaux précis | 15.75, 18.50 |
| `REAL` / `FLOAT` | Nombres à virgule flottante | 3.14159 |

**Exemple d'usage** :
```sql
id_etudiant SERIAL          -- 1, 2, 3, 4...
id_etablissement INT        -- 1, 2, 3...
valeur NUMERIC(5,2)        -- 15.75 (5 chiffres, 2 décimales)
```

---

## 📝 Types de texte

| Type | Description | Exemple |
|------|-------------|---------|
| `VARCHAR(n)` | Texte de longueur variable (max n) | 'Dupont', 'Sophie' |
| `CHAR(n)` | Texte de longueur fixe | 'FR', 'US' |
| `TEXT` | Texte de longueur illimitée | Long paragraphe... |

**Exemple d'usage** :
```sql
nom VARCHAR(255)           -- "Dupont" (max 255 caractères)
prenom VARCHAR(255)        -- "Jean"
email VARCHAR(255)         -- "jean.dupont@email.com"
adresse TEXT               -- Texte long sans limite
```

> 💡 **VARCHAR vs TEXT** : VARCHAR(255) limite la longueur, TEXT n'a pas de limite

---

## 📅 Types date et temps

| Type | Description | Exemple |
|------|-------------|---------|
| `DATE` | Date (année-mois-jour) | 2001-05-12 |
| `TIME` | Heure (heure:minute:seconde) | 14:30:00 |
| `TIMESTAMP` | Date + heure | 2024-11-19 14:30:00 |
| `BOOLEAN` | Vrai ou faux | TRUE, FALSE |

**Exemple d'usage** :
```sql
date_naissance DATE        -- 2001-05-12
date_inscription DATE      -- 2024-09-01
date_note DATE            -- 2024-10-15
```

---

## 🔑 Clé primaire : rôle et création

### Qu'est-ce qu'une clé primaire (PRIMARY KEY) ?

Une **clé primaire** est une colonne (ou un groupe de colonnes) qui :
- ✅ Identifie **UNIQUEMENT** chaque ligne de la table
- ✅ Ne peut **JAMAIS** être vide (NOT NULL)
- ✅ Ne peut **JAMAIS** être dupliquée
- ✅ Est souvent un nombre auto-incrémenté

> 🎯 **Analogie** : C'est comme un numéro de carte d'identité unique pour chaque enregistrement

---

## 🔐 Exemples de clés primaires

### Dans la table `etudiant` :

```sql
CREATE TABLE student.etudiant (
    id_etudiant SERIAL PRIMARY KEY,  -- ← Clé primaire
    nom VARCHAR(255) NOT NULL,
    prenom VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL
);
```

**Pourquoi `id_etudiant` ?**
- ✅ Unique pour chaque étudiant
- ✅ Auto-incrémenté (SERIAL)
- ✅ Jamais NULL
- ✅ Simple (un seul champ)

---

## 🆔 Autres exemples de clés primaires

### Table `cours` :
```sql
id_cours SERIAL PRIMARY KEY
```

### Table `etablissement` :
```sql
id_etablissement SERIAL PRIMARY KEY
```

### Table `note` :
```sql
id_note SERIAL PRIMARY KEY
```

> 💡 **Convention** : Souvent nommée `id_nom_de_table`

---

## 🔗 Clé étrangère : relations entre tables

### Qu'est-ce qu'une clé étrangère (FOREIGN KEY) ?

Une **clé étrangère** est une colonne qui :
- 📌 Fait référence à la **clé primaire** d'une autre table
- 🔗 Crée une **relation** entre deux tables
- ✅ Garantit l'**intégrité référentielle** (pas de données orphelines)

> 🎯 **Analogie** : C'est comme un lien hypertexte qui pointe vers une autre page

---

## 🔗 Exemple : Relation Etablissement ↔ Etudiant

### Schéma de la relation :

```
┌─────────────────────────┐
│    etablissement        │
├─────────────────────────┤
│ id_etablissement (PK)   │◄──┐
│ nom                     │   │
│ adresse                 │   │
└─────────────────────────┘   │
                              │ FOREIGN KEY
                              │
┌─────────────────────────┐   │
│    etudiant             │   │
├─────────────────────────┤   │
│ id_etudiant (PK)        │   │
│ nom                     │   │
│ prenom                  │   │
│ email                   │   │
│ date_naissance          │   │
│ id_etablissement (FK)   │───┘
└─────────────────────────┘
```

**Signification** : Chaque étudiant appartient à UN établissement

---

## 📝 Code SQL de la relation

```sql
CREATE TABLE student.etablissement (
    id_etablissement SERIAL PRIMARY KEY,
    nom VARCHAR(255) NOT NULL,
    adresse TEXT NOT NULL
);

CREATE TABLE student.etudiant (
    id_etudiant SERIAL PRIMARY KEY,
    nom VARCHAR(255) NOT NULL,
    prenom VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    date_naissance DATE NOT NULL,
    id_etablissement INT NOT NULL,
    
    -- ⬇️ Déclaration de la clé étrangère
    FOREIGN KEY (id_etablissement) 
        REFERENCES student.etablissement(id_etablissement)
);
```

---

## 🔍 Anatomie de FOREIGN KEY

```sql
FOREIGN KEY (id_etablissement)           -- ← Colonne dans cette table
    REFERENCES etablissement(id_etablissement)  -- ← Table et colonne référencées
```

**Ce que ça garantit** :
- ❌ On ne peut pas ajouter un étudiant avec `id_etablissement = 999` si l'établissement 999 n'existe pas
- ❌ On ne peut pas supprimer un établissement s'il a encore des étudiants
- ✅ L'intégrité des données est préservée

---

## 🔗 Relations dans notre base codaSchool

### Relation 1 : Etudiant → Etablissement
```sql
FOREIGN KEY (id_etablissement) 
    REFERENCES etablissement(id_etablissement)
```
**Type** : Many-to-One (plusieurs étudiants, un établissement)

### Relation 2 : Inscription → Etudiant
```sql
FOREIGN KEY (id_etudiant) 
    REFERENCES etudiant(id_etudiant)
```

### Relation 3 : Inscription → Cours
```sql
FOREIGN KEY (id_cours) 
    REFERENCES cours(id_cours)
```

**Type** : Many-to-Many (plusieurs étudiants ↔ plusieurs cours)

---

## 🏗️ CREATE TABLE expliqué ligne par ligne

### Syntaxe générale :

```sql
CREATE TABLE nom_schema.nom_table (
    colonne1 TYPE CONTRAINTES,
    colonne2 TYPE CONTRAINTES,
    ...
    CONTRAINTES_DE_TABLE
);
```

---

## 📚 Exemple complet : Table Cours

```sql
CREATE TABLE student.cours (
    id_cours SERIAL PRIMARY KEY,
    titre VARCHAR(255) NOT NULL,
    categorie VARCHAR(100) NOT NULL
);
```

### Décortiquons ligne par ligne :

---

## 1️⃣ CREATE TABLE student.cours

```sql
CREATE TABLE student.cours (
```

- `CREATE TABLE` : Commande pour créer une nouvelle table
- `student` : Nom du schéma (namespace)
- `cours` : Nom de la table
- `(` : Début de la définition des colonnes

---

## 2️⃣ id_cours SERIAL PRIMARY KEY

```sql
    id_cours SERIAL PRIMARY KEY,
```

- `id_cours` : Nom de la colonne
- `SERIAL` : Type auto-incrémenté (1, 2, 3, 4...)
- `PRIMARY KEY` : Identifiant unique de la table
- `,` : Séparateur entre colonnes

**Résultat** : Clé primaire qui s'incrémente automatiquement

---

## 3️⃣ titre VARCHAR(255) NOT NULL

```sql
    titre VARCHAR(255) NOT NULL,
```

- `titre` : Nom de la colonne
- `VARCHAR(255)` : Texte variable (max 255 caractères)
- `NOT NULL` : Cette colonne est **obligatoire**
- `,` : Séparateur

**Exemples de valeurs** : "Introduction aux Bases de Données", "Machine Learning Fondamentaux"

---

## 4️⃣ categorie VARCHAR(100) NOT NULL

```sql
    categorie VARCHAR(100) NOT NULL
```

- `categorie` : Nom de la colonne
- `VARCHAR(100)` : Texte variable (max 100 caractères)
- `NOT NULL` : Cette colonne est **obligatoire**
- **Pas de virgule** : c'est la dernière colonne !

**Exemples de valeurs** : "Informatique", "Data Science", "Management"

---

## 5️⃣ Fermeture

```sql
);
```

- `)` : Fin de la définition des colonnes
- `;` : Fin de la commande SQL

---

## 📊 Exemple plus complexe : Table Note

```sql
CREATE TABLE student.note (
    id_note SERIAL PRIMARY KEY,
    id_etudiant INT NOT NULL,
    id_cours INT NOT NULL,
    valeur NUMERIC(5,2) NOT NULL CHECK (valeur >= 0 AND valeur <= 20),
    date_note DATE NOT NULL DEFAULT NOW(),

    FOREIGN KEY (id_etudiant) REFERENCES student.etudiant(id_etudiant),
    FOREIGN KEY (id_cours) REFERENCES student.cours(id_cours)
);
```

---

## 🔍 Analyse détaillée : Table Note

### Clé primaire
```sql
id_note SERIAL PRIMARY KEY
```
Identifiant unique de chaque note

### Clés étrangères
```sql
id_etudiant INT NOT NULL
id_cours INT NOT NULL
```
Références vers les tables `etudiant` et `cours`

---

### Valeur de la note
```sql
valeur NUMERIC(5,2) NOT NULL CHECK (valeur >= 0 AND valeur <= 20)
```

**Décortiquons** :
- `NUMERIC(5,2)` : Nombre décimal (5 chiffres, 2 décimales) → Ex: 18.75
- `NOT NULL` : Obligatoire
- `CHECK (...)` : **Contrainte de validation**
  - La note doit être entre 0 et 20
  - ❌ Impossible d'insérer -5 ou 25

---

### Date avec valeur par défaut
```sql
date_note DATE NOT NULL DEFAULT NOW()
```

**Décortiquons** :
- `DATE` : Type date
- `NOT NULL` : Obligatoire
- `DEFAULT NOW()` : Si on ne spécifie pas de date, utilise la date du jour

> 💡 **Pratique** : On n'a pas besoin de saisir la date manuellement !

---

### Relations (contraintes de table)
```sql
FOREIGN KEY (id_etudiant) REFERENCES student.etudiant(id_etudiant),
FOREIGN KEY (id_cours) REFERENCES student.cours(id_cours)
```

**Ce que ça signifie** :
- Une note doit être liée à un étudiant existant
- Une note doit être liée à un cours existant
- Garantit l'intégrité des données

---

## 🎓 Exemple : Table Inscription (relation N-N)

```sql
CREATE TABLE student.inscription (
    id_inscription SERIAL PRIMARY KEY,
    id_etudiant INT NOT NULL,
    id_cours INT NOT NULL,
    date_inscription DATE NOT NULL DEFAULT NOW(),

    FOREIGN KEY (id_etudiant) REFERENCES student.etudiant(id_etudiant),
    FOREIGN KEY (id_cours) REFERENCES student.cours(id_cours),

    -- Contrainte d'unicité
    UNIQUE (id_etudiant, id_cours)
);
```

---

## 🔐 Contrainte UNIQUE

```sql
UNIQUE (id_etudiant, id_cours)
```

**Signification** :
- ✅ Un étudiant peut s'inscrire à plusieurs cours
- ✅ Un cours peut avoir plusieurs étudiants
- ❌ Un étudiant ne peut PAS s'inscrire **deux fois** au même cours

**Exemple** :
```sql
-- ✅ OK : Jean s'inscrit à "SQL"
INSERT INTO inscription (id_etudiant, id_cours) VALUES (1, 10);

-- ❌ ERREUR : Jean essaie de s'inscrire à nouveau à "SQL"
INSERT INTO inscription (id_etudiant, id_cours) VALUES (1, 10);
```

---

## 🛡️ Les contraintes SQL

### NOT NULL
```sql
nom VARCHAR(255) NOT NULL
```
La colonne **doit** avoir une valeur

### UNIQUE
```sql
email VARCHAR(255) UNIQUE
```
Toutes les valeurs doivent être **différentes**

### CHECK
```sql
valeur NUMERIC(5,2) CHECK (valeur >= 0 AND valeur <= 20)
```
Validation personnalisée

---

### DEFAULT
```sql
date_inscription DATE DEFAULT NOW()
```
Valeur par défaut si non spécifiée

### PRIMARY KEY
```sql
id_etudiant SERIAL PRIMARY KEY
```
Unique + Not Null + Index

### FOREIGN KEY
```sql
FOREIGN KEY (id_etablissement) REFERENCES etablissement(id_etablissement)
```
Relation vers une autre table

---

## 📊 Schéma complet de notre base

```
┌─────────────────┐
│  etablissement  │
│  (6 lignes)     │
└────────┬────────┘
         │ 1
         │
         │ N
┌────────┴────────┐         ┌─────────────────┐
│    etudiant     │         │     cours       │
│  (2000 lignes)  │         │  (100 lignes)   │
└────────┬────────┘         └────────┬────────┘
         │                           │
         │ N                     N   │
         │                           │
         └────────┐     ┌────────────┘
                  │     │
              ┌───┴─────┴───┐
              │ inscription │
              │ (1000 lignes)│
              └──────────────┘
                     │
                     │
              ┌──────┴──────┐
              │    note     │
              │ (1000 lignes)│
              └─────────────┘
```

---

## 🔢 Types de relations

### 1-N (One to Many)
**Exemple** : Un établissement a plusieurs étudiants
```
etablissement (1) ─────< (N) etudiant
```

### N-N (Many to Many)
**Exemple** : Plusieurs étudiants ↔ plusieurs cours
```
etudiant (N) >───< inscription >───< (N) cours
```

> 💡 Pour une relation N-N, on utilise une **table de liaison** (ici : `inscription`)

---

## 🧪 Exercices pratiques

### Niveau 1 : Compréhension

1. Combien de colonnes a la table `etudiant` ?
2. Quel est le type de données de `date_naissance` ?
3. Quelle est la clé primaire de la table `cours` ?
4. Quelle colonne de `etudiant` est une clé étrangère ?

### Niveau 2 : Analyse

5. Pourquoi utilise-t-on SERIAL pour les clés primaires ?
6. Que se passe-t-il si on essaie d'ajouter un étudiant avec un `id_etablissement` qui n'existe pas ?
7. Pourquoi la table `inscription` a-t-elle une contrainte UNIQUE sur (id_etudiant, id_cours) ?

---

### Niveau 3 : Création

8. Créez une table `professeur` avec :
   - `id_professeur` (clé primaire)
   - `nom` (obligatoire, max 255 caractères)
   - `prenom` (obligatoire, max 255 caractères)
   - `specialite` (max 100 caractères)
   - `date_embauche` (date, obligatoire)

9. Créez une table `salle` avec :
   - `id_salle` (clé primaire)
   - `numero` (texte court, obligatoire, unique)
   - `capacite` (entier, obligatoire)
   - `batiment` (texte)

---

## 📋 Récapitulatif

| Concept | Description | Exemple |
|---------|-------------|---------|
| **Table** | Conteneur de données | `etudiant`, `cours` |
| **Colonne** | Propriété/Attribut | `nom`, `prenom`, `email` |
| **Ligne** | Un enregistrement | Un étudiant spécifique |
| **PRIMARY KEY** | Identifiant unique | `id_etudiant` |
| **FOREIGN KEY** | Lien vers autre table | `id_etablissement` |
| **NOT NULL** | Obligatoire | `nom VARCHAR(255) NOT NULL` |
| **UNIQUE** | Valeurs différentes | `email VARCHAR(255) UNIQUE` |
| **CHECK** | Validation | `CHECK (valeur >= 0)` |
| **DEFAULT** | Valeur par défaut | `DEFAULT NOW()` |

---

## 💡 Ce qu'on a appris

✅ Structure d'une base de données (tables, colonnes, lignes)  
✅ Types de données SQL (numériques, texte, dates)  
✅ Clés primaires pour identifier uniquement chaque ligne  
✅ Clés étrangères pour relier les tables  
✅ CREATE TABLE pour créer des tables  
✅ Contraintes pour garantir l'intégrité des données  
✅ Relations entre tables (1-N, N-N)  

