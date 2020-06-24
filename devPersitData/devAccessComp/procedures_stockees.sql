-- Créez la procédure stockée Lst_fournis correspondant à la requête n°2 
--"afficher le code des fournisseurs pour lesquels une commande a été passée".

DROP PROCEDURE IF EXISTS Lst_fournis

DELIMITER |

CREATE PROCEDURE Lst_fournis()
BEGIN
    SELECT numfou FROM entcom
    GROUP BY numfou;
END |

DELIMITER ;

-- Exercice 2 : création d'une procédure stockée avec un paramètre en entrée
-- Créer la procédure stockée Lst_Commandes, qui liste les commandes ayant un libellé 
-- particulier dans le champ obscom (cette requête sera construite à partir de la requête n°11).

DROP PROCEDURE IF EXISTS Lst_commandes;

DELIMITER |

CREATE PROCEDURE Lst_commandes(IN obs Varchar(50))
BEGIN
    SELECT * FROM entcom
    WHERE obscom = obs;
END |

DELIMITER ;

CALL Lst_commandes("Commande urgente")

-- ____________________________________

DELIMITER |
    CREATE PROCEDURE lst_commandes(In observation Varchar(50))
    BEGIN
        SELECT
            entcom.numcom,
            fournis.nomfou,
            produit.libart,
            ligcom.qtecde*priuni
        FROM
            entcom
        JOIN
            fournis
        ON
            entcom.numfou = fournis.numfou
        JOIN
            ligcom
        ON
            ligcom.numcom = entcom.numcom
        JOIN
            produit
        ON
            produit.codart = ligcom.codart
        WHERE
            entcom.obscom LIKE CONCAT('%',observation,'%');
    END |
DELIMITER ;

-- Exercice 3 : création d'une procédure stockée avec plusieurs paramètres
-- Créer la procédure stockée CA_ Fournisseur, qui pour un code fournisseur et une année entrée en paramètre, 
-- calcule et restitue le CA potentiel de ce fournisseur pour l'année souhaitée (cette requête sera construite à partir de la requête n°19).

DROP PROCEDURE IF EXISTS CA_fournisseur;

DELIMITER |

CREATE PROCEDURE CA_fournisseur(
    IN four INT(11),
    IN annee INT(4)
)
BEGIN
    SELECT fournis.numfou, SUM(qtecde * priuni * 1.20) AS `Chiffre d'affaire`
    FROM fournis
        JOIN entcom
        ON fournis.numfou = entcom.numfou
            JOIN ligcom
            ON entcom.numcom = ligcom.numcom
    WHERE fournis.numfou = four AND YEAR(`entcom`.`datcom`) = annee;
END |

DELIMITER ;

-- DELIMITER |

-- CREATE PROCEDURE CA_fournisseur(
--     IN four INT(11),
--     IN annee INT(4)
-- )
-- BEGIN
--     SELECT fournis.numfou, SUM(qtecde * priuni * 0.20) AS `Chiffre d'affaire`
--     FROM fournis
--         JOIN entcom
--         ON fournis.numfou = entcom.numfou
--             JOIN ligcom
--             ON entcom.numcom = ligcom.numcom
--     WHERE fournis.numfou = four;
-- END |

-- DELIMITER ;