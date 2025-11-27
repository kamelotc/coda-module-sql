CREATE SCHEMA IF NOT EXISTS barabar;
SET search_path TO barabar;


CREATE TABLE barabar.quartier (
    id_quartier SERIAL PRIMARY KEY,
    nom_quartier VARCHAR(255) NOT NULL UNIQUE
);


CREATE TABLE barabar.bar (
    id_bar SERIAL PRIMARY KEY,
    nom_bar VARCHAR(255) NOT NULL,
    adresse VARCHAR(255) NOT NULL,
    id_quartier INT NOT NULL,
    FOREIGN KEY (id_quartier) REFERENCES barabar.quartier(id_quartier)
);


CREATE TABLE barabar.biere (
    id_biere SERIAL PRIMARY KEY,
    nom_biere VARCHAR(255) NOT NULL,
    type_biere VARCHAR(255)
);


CREATE TABLE barabar.prix (
    id_bar INT NOT NULL,
    id_biere INT NOT NULL,
    prix DECIMAL(5,2) NOT NULL CHECK (prix > 0),

    PRIMARY KEY (id_bar, id_biere),

    FOREIGN KEY (id_bar) REFERENCES barabar.bar(id_bar),
    FOREIGN KEY (id_biere) REFERENCES barabar.biere(id_biere)
);
