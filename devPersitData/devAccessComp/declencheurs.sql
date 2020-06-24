-- exemple
DELIMITER //
CREATE TRIGGER `insert_station` AFTER INSERT ON `station`
 FOR EACH ROW BEGIN
        DECLARE altitude INT;
        SET altitude = NEW.sta_altitude;
        IF altitude<1000 THEN
            SIGNAL SQLSTATE '40000' SET MESSAGE_TEXT = 'Un problème est survenu. Règle de gestion altitude !';
        END IF;
END //
DELIMITER ;

-- CAS HÔTEL

-- modif_reservation interdire la modification des réservations (on autorise l'ajout et la suppression).
DELIMITER //
CREATE TRIGGER modif_reservation AFTER UPDATE ON reservation
    FOR EACH ROW
    BEGIN
        SIGNAL SQLSTATE '40000' SET MESSAGE_TEXT = 'Impossible de modifier une réservation. Veuillez la supprimer puis renseignez les nouvelles dates.';
    END    //
DELIMITER ;

-- insert_reservation : interdire l'ajout de réservation pour les hôtels possédant déjà 10 réservations.
DELIMITER //
CREATE TRIGGER insert_reservation AFTER INSERT ON reservation
    FOR EACH ROW
    BEGIN
    DECLARE nb_resa INT;
    SET nb_resa = COUNT(res_id);
         IF nb_resa>10 THEN
            SIGNAL SQLSTATE '40000' SET MESSAGE_TEXT = 'Ajout impossible. Le nombre de réservation a atteint son maximum.';
        END IF;
    END //
DELIMITER ;

-- insert_reservation2 : interdire les réservations si le client possède déjà 3 réservations.
DELIMITER //
CREATE TRIGGER insert_reservation2 AFTER INSERT ON reservation
    FOR EACH ROW
    BEGIN
    DECLARE nb_cli_resa INT;
    SET nb_cli_resa = COUNT(res_cli_id);
        IF nb_cli_resa>3 THEN
            SIGNAL SQLSTATE '40000' SET MESSAGE_TEXT = 'Réservation impossible. Ce client possède déjà 3 réservations.';
        END IF;
    END //
DELIMITER ;


-- insert_chambre : lors d'une insertion, on calcule le total des capacités des chambres pour l'hôtel, si ce total est supérieur à 50, on interdit l'insertion de la chambre.
DELIMITER //

CREATE TRIGGER insert_chambre AFTER INSERT ON chambre
    FOR EACH ROW
    BEGIN
    DECLARE nb_cha INT;
    SET nb_cha = SUM(cha_capacite);
        IF nb_cha>50 THEN
             SIGNAL SQLSTATE '40000' SET MESSAGE_TEXT = 'Ajout impossible. Le total de capacité excède 50.';
       END IF;
    END //

DELIMITER ;


-- CAS COMMANDE PRODUIT
DELIMITER //
CREATE TRIGGER maj_total AFTER INSERT ON lignedecommande
    FOR EACH ROW
    BEGIN
        DECLARE id_c INT;
        DECLARE tot DOUBLE;
        SET id_c = NEW.id_commande; -- nous captons le numéro de commande concerné
        SET tot = (SELECT sum(prix*quantite) FROM lignedecommande WHERE id_commande=id_c); -- on recalcul le total
        UPDATE commande SET total=tot WHERE id=id_c; -- on stocke le total dans la table commande
END //
DELIMITER ;