-- Lista 2

--EX01

DELIMITER //
  CREATE PROCEDURE sp_ListarAutores()
  BEGIN
    SELECT nome, sobrenome FROM Autor;
  END
//
DELIMITER ;
CALL sp_ListarAutores();
