CREATE USER 'user1'@'%' IDENTIFIED BY '1Ksable';
CREATE USER 'user2'@'%' IDENTIFIED BY '2Ksable';
CREATE USER 'user3'@'%' IDENTIFIED BY '3Ksable';

GRANT ALL PRIVILEGES 
ON papyrus.* 
TO 'user1'@'%';

GRANT SELECT 
ON papyrus.*
TO 'user2'@'%';

GRANT SELECT
ON papyrus.fournis
TO 'user3'@'%';