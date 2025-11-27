-- 10 Quartiers, 20 Bars, 40 Bières, 150+ Prix

SET search_path TO barabar;


INSERT INTO barabar.quartier (nom_quartier) VALUES 

('Centre-Ville'),
('République'),
('Gare'),
('Montchapet'),
('Toison d Or'),
('Drapeau'),
('Bourroches'),
('Fontaine d Ouche'),
('Université'),
('Grésilles');

INSERT INTO barabar.bar (nom_bar, adresse, id_quartier) VALUES 

('Le QG', '12 Rue de la Soif', 1),
('L Amnésie', '5 Rue des Forges', 1),
('Le Bureau', '8 Place de la Libé', 1),
('Chez Tonton', '22 Rue Berbisey', 1),
('Le Lion Rouge', '1 Rue des Godrans', 1),
('L Irlando', '15 Rue Monge', 1),
('Le before', '10 Rue Vannerie', 1),
('Le Havana', '2 Boulevard Carnot', 2),
('Le Salsa', '4 Place de la Rep', 2),
('Le Terminus', '1 Avenue Foch', 3),
('Le Rétro', '5 Rue de la Gare', 3),
('La Fac de Soif', 'Boulevard Gabriel', 9),
('Le Campus', 'Rue de Mirande', 9),
('L Afterwork', 'Esplanade Erasme', 9),
('Le Montchapet', 'Rue de la Côte', 4),
('Le Zénith', 'Allée du Zénith', 5), 
('L Escale', 'Avenue du Drapeau', 6),
('Le PMU des Bourroches', 'Avenue Eiffel', 7),
('Le Bar du Lac', 'Quai des Carrières', 8), 
('L Olympique', 'Place Galilée', 10);

INSERT INTO barabar.biere (nom_biere, type_biere) VALUES 

('Chouffe', 'Blonde'),
('Delirium Tremens', 'Blonde'),
('Leffe Blonde', 'Blonde'),
('Cuvée des Trolls', 'Blonde'),
('Rince Cochon', 'Blonde'),
('Heineken', 'Lager'),
('1664', 'Lager'),
('Corona', 'Lager'),
('Kronenbourg', 'Lager'),
('Meteor', 'Pils'),
('Stella Artois', 'Pils'),
('Jupiler', 'Pils'),
('Fischer', 'Blonde'),
('La Goudale', 'Garde'),
('Jenlain', 'Garde'),
('Punk IPA', 'IPA'),
('Lagunitas IPA', 'IPA'),
('Gallia West IPA', 'IPA'),
('Brewdog Elvis Juice', 'IPA'),
('Brooklyn Defender', 'IPA'),
('Goose Island', 'IPA'),
('Vedett IPA', 'IPA'),
('Hoegaarden', 'Blanche'),
('Grimbergen Blanche', 'Blanche'),
('1664 Blanc', 'Blanche'),
('Edelweiss', 'Blanche'),
('Blanche de Namur', 'Blanche'),
('Karmeliet', 'Triple'),
('Paix Dieu', 'Triple'),
('Chimay Bleue', 'Trappiste'),
('Orval', 'Trappiste'),
('Rochefort 10', 'Trappiste'),
('Westmalle', 'Trappiste'),
('Duvel', 'Blonde Forte'),
('La Bête', 'Ambrée'),
('Kwak', 'Ambrée'),
('Guinness', 'Stout'),
('Pelforth Brune', 'Brune'),
('Desperados', 'Aromatisée'),
('Kriek Mort Subite', 'Fruitée');



DO $$
DECLARE
    i INTEGER;
    v_id_bar INTEGER;
    v_id_biere INTEGER;
    v_prix DECIMAL(5,2);
BEGIN
    FOR i IN 1..160 LOOP
        LOOP

            v_id_bar := 1 + (RANDOM() * 19)::INTEGER;   
            v_id_biere := 1 + (RANDOM() * 39)::INTEGER;
            v_prix := ROUND((4.50 + RANDOM() * 5.00)::NUMERIC, 2);

            BEGIN

                INSERT INTO barabar.prix (id_bar, id_biere, prix)
                VALUES (v_id_bar, v_id_biere, v_prix);
                EXIT;
            EXCEPTION WHEN unique_violation THEN
                CONTINUE;
            END;
        END LOOP;
    END LOOP;
END $$;

