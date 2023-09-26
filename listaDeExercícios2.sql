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

--EX03

DELIMITER //
CREATE PROCEDURE sp_LivrosPorCategoria(IN p_categoria varchar(100))
BEGIN
    SELECT Categoria_ID AS ID_DA_CATEGÓRIA , COUNT(*) AS QUANTIDADE_DE_LIVROS FROM Livro 
    WHERE Categoria_ID = (SELECT Categoria_ID FROM Categoria 
    WHERE Nome = p_categoria) GROUP BY Categoria_ID ORDER BY COUNT(Categoria_ID);
END
//

DELIMITER ;
CALL sp_LivrosPorCategoria("Autoajuda");

--EX04


--EX05
DELIMITER //
  CREATE PROCEDURE sp_LivrosAteAno(IN p_lpano INT)
  BEGIN
    SELECT Titulo, Ano_Publicacao FROM Livro
    WHERE Ano_Publicacao <= p_lpano
  END
//
DELIMITER ;
CALL sp_LivrosAteAno(2002);





-- Ex 8 
DELIMITER //

CREATE PROCEDURE EncontrarAutorMaisAntigo()
BEGIN
    SELECT nome, Sobrenome FROM Autor
    WHERE data_nascimento = (SELECT MIN(data_nascimento) FROM Autor);
END 
//
DELIMITER ;
CALL EncontrarAutorMaisAntigo();
