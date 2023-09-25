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

--EX02

DELIMITER //
CREATE PROCEDURE sp_LivrosPorCategoria(IN p_categoria varchar(100))
BEGIN
    SELECT titulo FROM Livro 
    WHERE Categoria_ID = (SELECT Categoria_ID FROM Categoria 
    WHERE Nome = p_categoria);
END
//
DELIMITER ;
CALL sp_LivrosPorCategoria("Romance");
CALL sp_LivrosPorCategoria("Autoajuda");
CALL sp_LivrosPorCategoria("Ficção Científica");
