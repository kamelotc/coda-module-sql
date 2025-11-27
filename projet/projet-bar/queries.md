1. prix moyen de la bière par quartier

SELECT q.nom_quartier
FROM quartier q
JOIN bar b ON q.id_quartier = b.id_quartier
JOIN prix p ON b.id_bar = p.id_bar
GROUP BY q.nom_quartier
ORDER BY prix_moyen DESC;


2. bars vendant l'IPA la moins chère

SELECT b.nom_bar, bi.nom_biere, p.prix
FROM bar b
JOIN prix p ON b.id_bar = p.id_bar
JOIN biere bi ON p.id_biere = bi.id_biere
WHERE bi.type_biere = 'IPA'
ORDER BY p.prix ASC;


3. bières vendues dans ≥ 5 bars

SELECT bi.nom_biere, COUNT(p.id_bar) as nb_bars
FROM biere bi
JOIN prix p ON bi.id_biere = p.id_biere
GROUP BY bi.nom_biere
HAVING COUNT(p.id_bar) >= 5
ORDER BY nb_bars DESC;


4. bars sans bière à moins de 6€

SELECT b.nom_bar
FROM bar b
JOIN prix p ON b.id_bar = p.id_bar
GROUP BY b.nom_bar
HAVING MIN(p.prix) >= 6.00;


5. top bar avec panier moyen maximum