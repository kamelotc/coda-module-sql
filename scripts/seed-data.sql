-- =========================================
-- Script de données de test (seed) - Version Large
-- Base de données : codaSchool
-- Schéma : student
-- 2000+ étudiants, 100+ cours, 1000 inscriptions, 1000 notes
-- =========================================

-- Utilisation du schéma student
SET search_path TO student;

-- =========================================
-- Données pour Etablissement
-- =========================================
INSERT INTO student.etablissement (nom, adresse) VALUES
    ('CODA Dijon', '15 Rue de la Formation, 21000 Dijon'),
    ('CODA Orléans', '42 Avenue du Développement, 45000 Orléans'),
    ('Université Paris-Saclay', '3 Rue Joliot Curie, 91190 Gif-sur-Yvette'),
    ('Sorbonne Université', '21 Rue de l''École de Médecine, 75006 Paris'),
    ('École Polytechnique', 'Route de Saclay, 91128 Palaiseau'),
    ('ESCP Business School', '79 Avenue de la République, 75011 Paris');

-- =========================================
-- Fonction helper pour générer des données
-- =========================================

-- Générer 2000 étudiants
DO $$
DECLARE
    noms TEXT[] := ARRAY['Dupont', 'Martin', 'Bernard', 'Petit', 'Durand', 'Leroy', 'Moreau', 'Simon', 
                         'Laurent', 'Michel', 'Garcia', 'Roux', 'David', 'Bertrand', 'Morel', 'Fournier',
                         'Girard', 'Bonnet', 'Blanc', 'Rousseau', 'Vincent', 'Muller', 'Lefebvre', 'Mercier',
                         'Denis', 'Boyer', 'Lemaire', 'Gauthier', 'Robert', 'Chevalier', 'Fontaine', 'Robin',
                         'Leclerc', 'Clement', 'Francois', 'Martinez', 'Picard', 'Roger', 'Guillaume', 'Henry',
                         'Blanchard', 'Olivier', 'Aubert', 'Giraud', 'Lucas', 'Collet', 'Carpentier', 'Caron',
                         'Perrin', 'Arnaud', 'Masson', 'Meunier', 'Benoit', 'Jacques', 'Lambert', 'Dumas'];
    prenoms TEXT[] := ARRAY['Jean', 'Sophie', 'Lucas', 'Emma', 'Thomas', 'Chloé', 'Alexandre', 'Léa',
                            'Hugo', 'Clara', 'Louis', 'Camille', 'Nathan', 'Sarah', 'Paul', 'Julie',
                            'Arthur', 'Manon', 'Gabriel', 'Inès', 'Jules', 'Laura', 'Raphaël', 'Marie',
                            'Adam', 'Zoé', 'Ethan', 'Lola', 'Tom', 'Alice', 'Théo', 'Louise',
                            'Antoine', 'Rose', 'Mathis', 'Anna', 'Maxime', 'Eva', 'Nicolas', 'Lisa',
                            'Victor', 'Jade', 'Pierre', 'Elise', 'Benjamin', 'Anaïs', 'Clément', 'Lucie'];
    i INTEGER;
BEGIN
    FOR i IN 1..2000 LOOP
        INSERT INTO student.etudiant (nom, prenom, email, date_naissance, id_etablissement)
        VALUES (
            noms[(i % array_length(noms, 1)) + 1],
            prenoms[(i % array_length(prenoms, 1)) + 1],
            'etudiant' || i || '@coda-school.com',
            DATE '2000-01-01' + (RANDOM() * 2000)::INTEGER,
            ((i % 6) + 1)
        );
    END LOOP;
END $$;

-- =========================================
-- Générer 100 cours
-- =========================================
INSERT INTO student.cours (titre, categorie) VALUES
    -- Informatique (30 cours)
    ('Introduction aux Bases de Données', 'Informatique'),
    ('Algorithmique Avancée', 'Informatique'),
    ('Développement Web Frontend', 'Informatique'),
    ('Développement Web Backend', 'Informatique'),
    ('Architecture Logicielle', 'Informatique'),
    ('Programmation Orientée Objet', 'Informatique'),
    ('Conception UML', 'Informatique'),
    ('DevOps et CI/CD', 'Informatique'),
    ('Sécurité Informatique', 'Informatique'),
    ('Cloud Computing AWS', 'Informatique'),
    ('Cloud Computing Azure', 'Informatique'),
    ('Développement Mobile iOS', 'Informatique'),
    ('Développement Mobile Android', 'Informatique'),
    ('React et Redux', 'Informatique'),
    ('Vue.js Avancé', 'Informatique'),
    ('Angular Framework', 'Informatique'),
    ('Node.js et Express', 'Informatique'),
    ('Django et Python Web', 'Informatique'),
    ('Spring Boot Java', 'Informatique'),
    ('Microservices Architecture', 'Informatique'),
    ('Docker et Kubernetes', 'Informatique'),
    ('Tests Unitaires et TDD', 'Informatique'),
    ('GraphQL API Design', 'Informatique'),
    ('REST API Best Practices', 'Informatique'),
    ('Git et Versioning', 'Informatique'),
    ('Linux Administration', 'Informatique'),
    ('Windows Server', 'Informatique'),
    ('Réseaux et Protocoles', 'Informatique'),
    ('Blockchain Fundamentals', 'Informatique'),
    ('WebAssembly', 'Informatique'),
    
    -- Data Science et IA (20 cours)
    ('Machine Learning Fondamentaux', 'Intelligence Artificielle'),
    ('Deep Learning avec TensorFlow', 'Intelligence Artificielle'),
    ('Deep Learning avec PyTorch', 'Intelligence Artificielle'),
    ('NLP et Traitement du Langage', 'Intelligence Artificielle'),
    ('Computer Vision', 'Intelligence Artificielle'),
    ('Data Science avec Python', 'Data Science'),
    ('Data Science avec R', 'Data Science'),
    ('Big Data et Hadoop', 'Data Science'),
    ('Apache Spark', 'Data Science'),
    ('Analyse de Données', 'Data Science'),
    ('Visualisation de Données', 'Data Science'),
    ('Statistics Avancées', 'Data Science'),
    ('SQL pour Data Scientists', 'Data Science'),
    ('NoSQL Databases', 'Data Science'),
    ('ETL et Data Pipelines', 'Data Science'),
    ('Data Warehousing', 'Data Science'),
    ('Time Series Analysis', 'Data Science'),
    ('Reinforcement Learning', 'Intelligence Artificielle'),
    ('MLOps', 'Intelligence Artificielle'),
    ('IA Éthique', 'Intelligence Artificielle'),
    
    -- Management et Business (25 cours)
    ('Gestion de Projet Agile', 'Management'),
    ('Scrum Master Certification', 'Management'),
    ('Leadership et Management', 'Management'),
    ('Management d''Équipe', 'Management'),
    ('Product Management', 'Management'),
    ('Marketing Digital', 'Commerce'),
    ('Social Media Marketing', 'Commerce'),
    ('Content Marketing', 'Commerce'),
    ('SEO et SEA', 'Commerce'),
    ('E-commerce Strategy', 'Commerce'),
    ('Finance d''Entreprise', 'Finance'),
    ('Comptabilité Générale', 'Finance'),
    ('Analyse Financière', 'Finance'),
    ('Trading et Marchés', 'Finance'),
    ('Blockchain et Crypto', 'Finance'),
    ('Risk Management', 'Finance'),
    ('Droit des Affaires', 'Droit'),
    ('Droit du Numérique', 'Droit'),
    ('RGPD et Protection des Données', 'Droit'),
    ('Entrepreneuriat', 'Business'),
    ('Business Model Canvas', 'Business'),
    ('Pitch et Levée de Fonds', 'Business'),
    ('Innovation et Disruption', 'Business'),
    ('Design Thinking', 'Business'),
    ('Lean Startup', 'Business'),
    
    -- Sciences et Mathématiques (15 cours)
    ('Mathématiques Appliquées', 'Mathématiques'),
    ('Algèbre Linéaire', 'Mathématiques'),
    ('Calcul Différentiel', 'Mathématiques'),
    ('Probabilités', 'Mathématiques'),
    ('Statistiques Inférentielles', 'Mathématiques'),
    ('Recherche Opérationnelle', 'Mathématiques'),
    ('Optimisation', 'Mathématiques'),
    ('Cryptographie', 'Mathématiques'),
    ('Théorie des Graphes', 'Mathématiques'),
    ('Physique Quantique', 'Sciences'),
    ('Chimie Organique', 'Sciences'),
    ('Bioinformatique', 'Sciences'),
    ('Biotechnologie', 'Sciences'),
    ('Énergies Renouvelables', 'Sciences'),
    ('Développement Durable', 'Sciences'),
    
    -- Soft Skills et Communication (10 cours)
    ('Communication Professionnelle', 'Communication'),
    ('Prise de Parole en Public', 'Communication'),
    ('Négociation', 'Communication'),
    ('Intelligence Émotionnelle', 'Développement Personnel'),
    ('Gestion du Stress', 'Développement Personnel'),
    ('Gestion du Temps', 'Développement Personnel'),
    ('Créativité et Innovation', 'Développement Personnel'),
    ('Anglais Professionnel', 'Langues'),
    ('Espagnol des Affaires', 'Langues'),
    ('Chinois Mandarin', 'Langues');

-- =========================================
-- Générer 1000 inscriptions aléatoires
-- =========================================
DO $$
DECLARE
    i INTEGER;
    etudiant_id INTEGER;
    cours_id INTEGER;
BEGIN
    FOR i IN 1..1000 LOOP
        LOOP
            etudiant_id := 1 + (RANDOM() * 1999)::INTEGER;
            cours_id := 1 + (RANDOM() * 99)::INTEGER;
            
            BEGIN
                INSERT INTO student.inscription (id_etudiant, id_cours, date_inscription)
                VALUES (
                    etudiant_id,
                    cours_id,
                    DATE '2024-09-01' + (RANDOM() * 60)::INTEGER
                );
                EXIT;
            EXCEPTION WHEN unique_violation THEN
                -- Si la combinaison existe déjà, on réessaye
                CONTINUE;
            END;
        END LOOP;
    END LOOP;
END $$;

-- =========================================
-- Générer 1000 notes aléatoires
-- =========================================
DO $$
DECLARE
    i INTEGER;
    etudiant_id INTEGER;
    cours_id INTEGER;
BEGIN
    FOR i IN 1..1000 LOOP
        etudiant_id := 1 + (RANDOM() * 1999)::INTEGER;
        cours_id := 1 + (RANDOM() * 99)::INTEGER;
        
        INSERT INTO student.note (id_etudiant, id_cours, valeur, date_note)
        VALUES (
            etudiant_id,
            cours_id,
            ROUND((RANDOM() * 15 + 5)::NUMERIC, 2), -- Notes entre 5 et 20
            DATE '2024-10-01' + (RANDOM() * 45)::INTEGER
        );
    END LOOP;
END $$;

-- =========================================
-- Easter Eggs 🥚
-- =========================================

-- Ajouter l'établissement UTBM
INSERT INTO student.etablissement (nom, adresse) VALUES
    ('UTBM', 'Rue Ernest Thierry-Mieg, 90010 Belfort');

-- Ajouter Laurent Gauthier (étudiant UTBM)
INSERT INTO student.etudiant (nom, prenom, email, date_naissance, id_etablissement)
VALUES (
    'Gauthier',
    'Laurent',
    'laurent.gauthier@utbm.fr',
    '1990-01-01',
    (SELECT id_etablissement FROM student.etablissement WHERE nom = 'UTBM')
);

-- Ajouter le cours "Prof de SQL"
INSERT INTO student.cours (titre, categorie) VALUES
    ('Prof de SQL', 'Informatique');

-- Inscription de Laurent Gauthier au cours "Prof de SQL"
INSERT INTO student.inscription (id_etudiant, id_cours, date_inscription)
VALUES (
    (SELECT id_etudiant FROM student.etudiant WHERE email = 'laurent.gauthier@utbm.fr'),
    (SELECT id_cours FROM student.cours WHERE titre = 'Prof de SQL'),
    '2024-09-01'
);

-- Note de 20/20 pour Laurent Gauthier dans "Prof de SQL"
INSERT INTO student.note (id_etudiant, id_cours, valeur, date_note)
VALUES (
    (SELECT id_etudiant FROM student.etudiant WHERE email = 'laurent.gauthier@utbm.fr'),
    (SELECT id_cours FROM student.cours WHERE titre = 'Prof de SQL'),
    20.00,
    '2024-10-15'
);

-- Ajouter Yoan Thirion (étudiant CODA Dijon)
INSERT INTO student.etudiant (nom, prenom, email, date_naissance, id_etablissement)
VALUES (
    'Thirion',
    'Yoan',
    'yoan.thirion@coda-school.com',
    '2000-01-01',
    (SELECT id_etablissement FROM student.etablissement WHERE nom = 'CODA Dijon')
);

-- Inscription de Yoan Thirion au cours "Introduction aux Bases de Données" (cours SQL)
INSERT INTO student.inscription (id_etudiant, id_cours, date_inscription)
VALUES (
    (SELECT id_etudiant FROM student.etudiant WHERE email = 'yoan.thirion@coda-school.com'),
    (SELECT id_cours FROM student.cours WHERE titre = 'Introduction aux Bases de Données'),
    '2024-09-01'
);

-- Note de 0.5/20 pour Yoan Thirion dans "Introduction aux Bases de Données"
INSERT INTO student.note (id_etudiant, id_cours, valeur, date_note)
VALUES (
    (SELECT id_etudiant FROM student.etudiant WHERE email = 'yoan.thirion@coda-school.com'),
    (SELECT id_cours FROM student.cours WHERE titre = 'Introduction aux Bases de Données'),
    0.50,
    '2024-10-15'
);
