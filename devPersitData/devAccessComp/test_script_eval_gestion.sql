---------------------------------PROCEDURE-------------------------------------

DELIMITER //

CREATE PROCEDURE markup_check(
    IN orderid INT(5)
)
BEGIN
    SELECT `orders`.`OrderID` AS 'nCom', `ShipCountry` AS 'paysClient', `Country` AS 'paysFournis', `order details`.`ProductID` AS 'prodCmd', (`order details`.`UnitPrice`*`Quantity`) AS 'prodPrice' 
    FROM `orders`
        JOIN `order details` 
        ON `orders`.`OrderID` = `order details`.`OrderID`
            JOIN `products` 
            ON `order details`.`ProductID` = `products`.`ProductID`
                JOIN `suppliers`
                ON `products`.`SupplierID` = `suppliers`.`SupplierID`
    WHERE `order details`.`OrderID` = orderid;
END //

DELIMITER ;

----------------------------------TRIGGER--------------------------------------
DROP TRIGGER IF EXISTS transp_check 

DELIMITER //

CREATE TRIGGER transp_check AFTER INSERT ON `order details`
    FOR EACH ROW
    
    BEGIN
        DECLARE IDorder INT;
        DECLARE pays_cli VARCHAR(50);
        DECLARE pays_fournis VARCHAR(50);
        SET IDorder = 0;
        SELECT OrderID AS IDorder INTO @IDorder FROM `order details` ORDER BY OrderID DESC LIMIT 1;
        CALL markup_check(IDorder);
        SET pays_cli = paysClient;
        SET pays_fournis = paysFournis;
        
        IF paysClient != paysFournis THEN
        SIGNAL SQLSTATE '40000' SET MESSAGE_TEXT = 'Une majoration de 5% est appliqué pour palier aux coûts de transport.';
    END IF;

    END //

DELIMITER ;

INSERT INTO `orders` (`OrderID`, `CustomerID`, `OrderDate`, `ShipCountry`) VALUES
    (11078, 'DUMON', CURRENT_DATE, 'France');

INSERT INTO `order details` (`OrderID`, `ProductID`, `UnitPrice`, `Quantity`) VALUES
    (11078, 12, 21.3500, 2);