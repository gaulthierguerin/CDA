DROP TRIGGER IF EXISTS ShipCost;

DELIMITER |

CREATE TRIGGER ShipCost AFTER INSERT ON orders
FOR EACH ROW 
BEGIN

DECLARE orderID INT (11);
DECLARE productID INT (11);
DECLARE CustCountry VARCHAR (11);
DECLARE SuppCountry VARCHAR (11);

SET orderID = NEW.OrderID;
SET productID = NEW.ProductID;

SET CustCountry = (SELECT ShipCountry FROM orders
WHERE OrderID = orderID);

SET SuppCountry = (SELECT suppliers.Country FROM orders 
JOIN `order details` 
ON `order details`.OrderID = orders.OrderID
JOIN products 
ON `order details`.ProductID = products.ProductID
JOIN suppliers 
ON products.SupplierID = suppliers.SupplierID
WHERE products.ProductID = productid AND orders.OrderID = orderid);

IF CustCountry = SuppCountry THEN
    UPDATE  SET `order details`.ShippingCost="Commandé et fournis dans le meme pays" WHERE `order details`.ShippingCost= NULL;
ELSE 
    UPDATE  SET `order details`.ShippingCost="nest pas commandé et fournis dans le meme pays" WHERE `order details`.ShippingCost= NULL;
END IF; 
END |
