-- Exerciice 1 : Vues sur la base Hotel

-- 1. Afficher la liste des hôtels avec leur station
CREATE VIEW `v_hot_sta`
AS
SELECT `hot_nom`, `sta_nom` 
FROM `hotel`
JOIN `station` 
ON `hot_sta_id` = `sta_id`

-- 2. Afficher la liste des chambres et leur hôtel
CREATE VIEW `v_cha_hot`
AS
SELECT `hot_nom`, `cha_numero`
FROM `hotel`
JOIN `chambre`
ON `hot_id` = `cha_hot_id`

-- 3. Afficher la liste des réservations avec le nom des clients
CREATE VIEW `v_res_client`
AS
SELECT `res_date_debut`, `res_date_fin`, CONCAT(`cli_nom`, ' ', `cli_prenom`) AS `nom client`
FROM `client`
JOIN `reservation`
ON `res_cli_id` = `cli_id`


-- 4. Afficher la liste des chambres avec le nom de l’hôtel et le nom de la station
CREATE VIEW `v_chanum_hotsta_nom`
AS
SELECT `cha_numero`, `hot_nom`, `sta_nom`
FROM `chambre`
JOIN `hotel`
ON `cha_hot_id` = `hot_id`
    JOIN `station`
    ON `hot_sta_id` = `sta_id`

-- 5. Afficher les réservations avec le nom du client et le nom de l’hôtel
CREATE VIEW `v_res_client_hot`
AS
SELECT `res_date_debut`, `res_date_fin`, CONCAT(`cli_nom`, ' ', `cli_prenom`) AS `nom client`, `hot_nom`
FROM `client`
JOIN `reservation`
ON `res_cli_id` = `cli_id`
JOIN `chambre` 
ON `res_cha_id` = `cha_hot_id`
JOIN `hotel`
ON `cha_hot_id` = `hot_id`



-- Exercice 2 : vues sur la base papyrus
-- Réalisez les vues suivantes sur papyrus:

-- v_GlobalCde correspondant à la requête : A partir de la table Ligcom, afficher par code produit, la somme des quantités commandées et 
-- le prix total correspondant : on nommera la colonne correspondant à la somme des quantités commandées, QteTot et le prix total, PrixTot.
CREATE VIEW `v_GlobalCde`
AS
SELECT `codart`, SUM(`qtecde`) AS `QteTot`, `priuni` * SUM(`qtecde`) AS `PrixTot`
FROM `ligcom` 
GROUP BY `codart`

-- v_VentesI100 correspondant à la requête : Afficher les ventes dont le code produit est le I100 (affichage de toutes les colonnes de la table Vente).
CREATE VIEW `v_VentesI100`
AS
SELECT *
FROM vente
WHERE codart = 'I100'

-- A partir de la vue précédente, créez v_VentesI100Grobrigan remontant toutes les ventes concernant le produit I100 et le fournisseur 00120.
CREATE VIEW `v_VentesI100Grobrigan`
AS
SELECT *
FROM vente
WHERE codart = 'I100' and numfou = '00120'