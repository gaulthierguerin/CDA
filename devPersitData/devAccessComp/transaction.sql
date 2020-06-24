-- Mise en situation
-- Exercice 1
-- A exécuter lignes par lignes
START TRANSACTION;
-- 
SELECT nomfou FROM fournis WHERE numfou=120;
-- 
UPDATE fournis  SET nomfou= 'GROSBRIGAND' WHERE numfou=120;
-- 
SELECT nomfou FROM fournis WHERE numfou=120;

-- La transaction n'est pas terminée, il faudrait utiliser une commande 'COMMIT' pour la conclure, ou bien 'ROLLBACK' pour l'annuler.

COMMIT; -- pour que les modifications soient effectives dans la bdd

ROLLBACK; --pour annuler toute transaction faites depuis le 'START TRANSACTION'