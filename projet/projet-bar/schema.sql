CREATE SCHEMA IF NOT EXISTS barabar;


SET search_path TO barabar;

-- =========================================
-- Table Quartier
-- =========================================
CREATE TABLE barabar.quartier (
    id_quartier SERIAL PRIMARY KEY,
    nom_quartier VARCHAR(255) NOT NULL UNIQUE
);

-- =========================================
-- Table Bar
-- =========================================
CREATE TABLE barabar.bar (
    id_bar SERIAL PRIMARY KEY,
    nom_bar VARCHAR(255) NOT NULL,
    adresse VARCHAR(255) NOT NULL,
    id_quartier INT NOT NULL,
    FOREIGN KEY (id_quartier) REFERENCES barabar.quartier(id_quartier)
);

-- =========================================
-- Table Biere
-- =========================================
CREATE TABLE barabar.biere (
    id_biere SERIAL PRIMARY KEY,
    nom_biere VARCHAR(255) NOT NULL,
    type_biere VARCHAR(255)
);


-- =========================================
-- Table Carte_Prix
-- =========================================
CREATE TABLE barabar.prix (
    id_bar INT NOT NULL,
    id_biere INT NOT NULL,
    prix DECIMAL(5,2) NOT NULL CHECK (prix > 0),

    PRIMARY KEY (id_bar, id_biere),

    FOREIGN KEY (id_bar) REFERENCES barabar.bar(id_bar) ON DELETE CASCADE,
    FOREIGN KEY (id_biere) REFERENCES barabar.biere(id_biere)
);


-- =========================================
-- Table Inscription (relation N..N entre Etudiant et Cours)
-- =========================================
CREATE TABLE barabar.inscription (
    id_inscription SERIAL PRIMARY KEY,
    id_bar INT NOT NULL,
    id_biere INT NOT NULL,
    date_inscription DATE NOT NULL DEFAULT NOW(),

    FOREIGN KEY (id_bar) REFERENCES barabar.bar(id_bar),
    FOREIGN KEY (id_biere) REFERENCES barabar.biere (id_biere),

    -- Un étudiant ne peut s'inscrire qu'une seule fois à un cours
    UNIQUE (id_bar, id_biere)
);

-- =========================================
-- Table Note (relation 0..N entre Etudiant et Cours)
-- =========================================
CREATE TABLE barabar.note (
    id_note SERIAL PRIMARY KEY,
    id_bar INT NOT NULL,
    id_biere  INT NOT NULL,
    valeur NUMERIC(5,2) NOT NULL CHECK (valeur >= 0 AND valeur <= 20),
    date_note DATE NOT NULL DEFAULT NOW(),

    FOREIGN KEY (id_bar) REFERENCES barabar.bar(id_bar),
    FOREIGN KEY (id_biere) REFERENCES barabar.cours(id_biere)
);
