-- Création d'un déclencheur AFTER UPDATE
-- Créer une table ARTICLES_A_COMMANDER avec les colonnes :

-- CODART : Code de l'article, voir la table produit
-- DATE : date du jour (par défaut)
-- QTE : à calculer
-- Créer un déclencheur UPDATE sur la table produit : lorsque le stock physique devient inférieur ou égal au stock d'alerte, 
-- une nouvelle ligne est insérée dans la table ARTICLES_A_COMMANDER.

-- Attention, il faut prendre en compte les quantités déjà commandées dans la table ARTICLES_A_COMMANDER .

-- Pour comprendre le problème :

-- Soit l'article I120, le stock d'alerte = 5, le stock physique = 20

-- Nous retirons 15 produits du stock. stock d'alerte = 5, le stock physique = 5, le stock physique n'est pas inférieur au stock d'alerte, on ne fait rien.

-- Nous retirons 1 produit du stock. stock d'alerte = 5, le stock physique = 4, le stock physique est inférieur au stock d'alerte, 
-- nous devons recommander des produits. Nous insérons une ligne dans la table ARTICLES_A_COMMANDER avec QTE = (stock alerte - stock physique) = 1

-- Nous retirons 2 produit du stock. stock d'alerte = 5, le stock physique = 2. le stock physique est inférieur au stock d'alerte, 
-- nous devons recommander des produits. Nous insérons une ligne dans la table ARTICLES_A_COMMANDER avec 
-- QTE = (stock alerte - stock physique) – quantité déjà commandée dans ARTICLES_A_COMMANDER : QTE = (5 - 2) – 1 = 2

CREATE TABLE `articles_a_commander` (
    `codart` CHAR(4) NOT NULL,
    `date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `qte`INT NOT NULL,
    PRIMARY KEY (`codart`),
    FOREIGN KEY (`codart`) REFERENCES produit(`codart`)
)ENGINE=InnoDB;

-- déclencheur

DELIMITER //

CREATE TRIGGER commande_restock AFTER UPDATE ON produit
    FOR EACH ROW
    BEGIN
        DECLARE art INT;
        DECLARE stk_phy INT;
        DECLARE stk_cmd INT;
        DECLARE stock_tot INT;
        SET art = NEW.codart;
        SET stk_phy = NEW.produit.stkphy;
        SET stk_cmd = NEW.articles_a_commander.qte;
        SET stock_tot = (SELECT SUM(stk_phy+stk_cmd) WHERE codart=art);
    IF stock_tot <= stkale THEN
    INSERT INTO `articles_a_commander` (`codart`, `date`, `qte`) VALUES
        