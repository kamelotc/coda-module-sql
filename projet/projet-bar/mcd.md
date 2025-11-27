erDiagram

    QUARTIER {
        int id_quartier
        string nom_quartier
    }
    BAR {
        int id_bar
        string nom_bar
        string adresse
        int id_quartier
    }
    BIERE {
        int id_biere
        string nom_biere
        string type_biere
    }
    PRIX {
        int id_bar
        int id_biere
        float prix
    }

    QUARTIER ||--o{ BAR : "0_N"
    BAR ||--|{ PRIX : "1_N"
    BIERE ||--o{ PRIX : "0_N "