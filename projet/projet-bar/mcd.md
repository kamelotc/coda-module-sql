erDiagram

    QUARTIER {
        int id_quartier
        string nom
    }
    BAR {
        int id_bar
        string nom
        int id_quartier
    }
    BIERE {
        int id_biere
        string nom
        string type
    }
    CARTE_PRIX {
        int id_bar
        int id_biere
        float prix
    }

    QUARTIER ||--o{ BAR : "0_N"
    BAR ||--|{ CARTE_PRIX : "1_N"
    BIERE ||--o{ CARTE_PRIX : "0_N "