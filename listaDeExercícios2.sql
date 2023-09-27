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
DELIMITER //
CREATE PROCEDURE sp_VerificarLivrosCategoria(IN categoria_valor varchar(100), OUT tf_livros varchar(30))
BEGIN
    DECLARE verificar INT;
    WITH Selet_ID AS (
        SELECT (SELECT Categoria_ID FROM categoria WHERE nome = Categoria_valor) AS cate_valor
    )
    SELECT COUNT(*) INTO verificar FROM livro INNER JOIN Selet_ID on cate_valor = Categoria_ID;
    IF verificar > 0 THEN
        SET tf_livros = 'Possui Livros';
    ELSE
        SET tf_livros = 'Não Possui Livros';
    END IF;
END;
//
DELIMITER ;
CALL sp_VerificarLivrosCategoria('Ciência', @ver);
SELECT @ver as tem_ou_não;


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

-- EX07
DELIMITER //
CREATE PROCEDURE sp_AdicionarLivro(
    IN N_Livro_ID INT,
    IN N_Titulo VARCHAR(255),
    IN N_Editora_ID INT,
    IN N_Ano_Publicacao INT,
    IN N_Numero_Paginas INT,
    IN N_Categoria_ID INT
)
BEGIN
    DECLARE livro_existente INT;
    SELECT COUNT(*) INTO livro_existente FROM Livro WHERE Titulo = n_titulo;
    IF livro_existente = 0 THEN
        INSERT INTO Livro (Livro_ID, Titulo, Editora_ID, Ano_Publicacao, Numero_Paginas, Categoria_ID)
        VALUES (N_Livro_ID, N_Titulo, N_Editora_ID, N_Ano_Publicacao, N_Numero_Paginas, N_Categoria_ID);
    END IF;
END;
//
DELIMITER ;

CALL sp_AdicionarLivro(11, 'Máquina do Tempo Doidona', 1, 1999, 478, 2);
SELECT * FROM LIVRO;

-- Ex08 
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
