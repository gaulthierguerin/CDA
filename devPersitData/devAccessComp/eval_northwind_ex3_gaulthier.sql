-- J'ai repris le code d'Anastasiia que j'ai modifié

CREATE TABLE messages (
OrderID INT NOT NULL,
ContenuMess VARCHAR(50),

PRIMARY KEY (OrderID),
FOREIGN KEY (OrderID) REFERENCES `order details`(OrderID) -- Je reprend l'orderID dans une optique de lisibilité
) ENGINE=InnoDB;


-- le trigger

DROP TRIGGER IF EXISTS transp_check;

DELIMITER |
CREATE TRIGGER transp_check AFTER INSERT ON `order details`
    FOR EACH ROW
    BEGIN
        DECLARE orderid INT; 
        DECLARE productid INT;
        DECLARE paysClient VARCHAR(15);
        DECLARE paysFournis VARCHAR(15);
        -- je récupère les valeurs dont j'ai besoin
        SET orderid = NEW.OrderID; 
        SET productid = NEW.ProductID;
        -- puis les pays pour les comparer ensuite
        SET paysClient = (SELECT DISTINCT Country FROM `order details` 
                            JOIN orders 
                            ON `order details`.OrderID = orders.OrderID
                                JOIN customers 
                                ON orders.CustomerID = customers.CustomerID
                            WHERE orders.OrderID = orderid);
        SET paysFournis = (SELECT suppliers.Country FROM orders 
                            JOIN `order details` 
                            ON `order details`.OrderID = orders.OrderID
                                JOIN products 
                                ON `order details`.ProductID = products.ProductID
                                    JOIN suppliers 
                                    ON products.SupplierID = suppliers.SupplierID
                            WHERE products.ProductID = productid AND orders.OrderID = orderid);

        IF paysClient = paysFournis THEN
            INSERT INTO messages (OrderID, ContenuMess) VALUES(orderid, 'Pays identique. Pas de majoration');
        ELSE 
            INSERT INTO messages (OrderID, ContenuMess) VALUES(orderid, 'Pays différent. Majoration de 5% sur le prix total.');
        END IF;  

END|

DELIMITER ;