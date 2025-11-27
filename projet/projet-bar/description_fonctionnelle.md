Les entités principales:

    1.Quartier
    2.Bar
    3.Carte_prix
    4.Biere


Les relations:

    QUARTIER <--> BAR : Relation 0_N
    BAR <--> CARTE_PRIX : Relation 1_N
    BIERE <--> CARTE_PRIX : Relation 0_N 


Les règles métier:

    Un bar ne peut proposer qu'un seul prix pour une même bière.
    Une bière peut être créée dans le catalogue sans être vendue par aucun bar.
    Un bar enregistré dans la base doit avoir au moins une bière à sa carte.


Les attributs importants:

    1.Quartiers :

                id_quartier

                nom_quartier

    Bars :

                id_bar

                nom_bar

                id_quartier

                adresse

    Biere :

                id_biere (Identifiant unique)

                nom_biere

                type_biere

    Carte_Prix :

                prix (€)

                id_bar

                id_biere