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


--EX06
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


--EX09
-- Eu escolhi a procedure 1 para explicar, é o seguinte:
DELIMITER // --O delimiter é o delimitador do código, normalmente é usado ";" para finalizar cada comando e etc, com o delimiter, passa-se a usar // para finalizar o código
  CREATE PROCEDURE sp_ListarAutores() --CREATE PROCEDURE - vai criar um procedimento armazenado chamado sp_ListarAutores()
  BEGIN -- BEGIN começa
    SELECT nome, sobrenome FROM Autor; -- O SELECT vai fazer um consulta das colunas nome e sobrenome da tabela Autor
  END -- END termina
// -- Termina o delimitador //
DELIMITER ; -- Delimitador volta a ser ";"
CALL sp_ListarAutores(); -- CALL vai fazer a chamada da procedure criada

--EX10
DELIMITER //
CREATE PROCEDURE sp_LivrosESeusAutores()
BEGIN
    SELECT Livro.Titulo, Autor.Nome, Autor.Sobrenome FROM Livro
    JOIN Autor_Livro ON Livro.Livro_ID = Autor_Livro.Livro_ID
    JOIN Autor ON Autor_Livro.Autor_ID = Autor.Autor_ID;
END //
DELIMITER ;
CALL sp_LivrosESeusAutores();
