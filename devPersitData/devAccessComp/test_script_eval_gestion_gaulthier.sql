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

DELIMITER //

CREATE TRIGGER transp_check AFTER INSERT ON `orders`
    FOR EACH ROW
    
    BEGIN
        DECLARE IDorder INT;
        DECLARE pays_cli VARCHAR(50);
        DECLARE pays_fournis VARCHAR(50);

        SET IDorder = (SELECT OrderID FROM orders ORDER BY OrderID DESC LIMIT 1);
        CALL markup_check(IDorder);
        SET pays_cli = paysClient;
        SET pays_fournis = paysFournis;
        
        IF paysClient != paysFournis THEN
        SIGNAL SQLSTATE '40000' SET MESSAGE_TEXT = 'Une majoration de 5% est appliqué pour palier aux coûts de transport.';
    END IF;

    END //

DELIMITER ;

