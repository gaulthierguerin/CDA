-- Codez deux procédures stockées correspondant aux requêtes 9 et 10. Les procédures stockées doivent prendre en compte les éventuels paramètres.

-- 9 – Depuis quelle date le client « Du monde entier » n’a plus commandé ?

DROP PROCEDURE IF EXISTS date_lastorder

DELIMITER //

CREATE PROCEDURE date_lastorder (
    IN client CHAR(5)
)
BEGIN
    SELECT `CustomerID`, `OrderDate` AS 'Date de dernière commande'
    FROM `orders`
    WHERE `CustomerID` = client
    ORDER BY `Date de dernière commande` DESC
    LIMIT 1;
    END //

DELIMITER ;


-- 10 – Quel est le délai moyen de livraison en jours ?

DROP PROCEDURE IF EXISTS delai_liv_moy

DELIMITER //

CREATE PROCEDURE delai_liv_moy ()

BEGIN

    SELECT ROUND(AVG(DATEDIFF(`ShippedDate`,`OrderDate`))) AS 'Délai moyen de livraison en jours'
    FROM `orders`;

END //

DELIMITER ;