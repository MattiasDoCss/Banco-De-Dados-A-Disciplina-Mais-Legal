--EX01
DELIMITER $$

CREATE FUNCTION total_livros_por_genero(nome_genero_param VARCHAR(255)) RETURNS INT
BEGIN
    DECLARE total INT;
    DECLARE done INT DEFAULT 0;
    DECLARE livro_id INT;
    
    SELECT id INTO total FROM Genero WHERE nome_genero = nome_genero_param;
    

    SET total = 0;
    
    DECLARE cur CURSOR FOR
        SELECT id FROM Livro WHERE id_genero = total;
  
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    OPEN cur;
    
    read_loop: LOOP
        FETCH cur INTO livro_id;
        IF done = 1 THEN
            LEAVE read_loop;
        END IF;
        
        SET total = total + 1;
    END LOOP;
    
    CLOSE cur;
    RETURN total;
END$$
DELIMITER ;

CALL total_livros_por_genero('Romance');

--EX02
DELIMITER //

CREATE FUNCTION listar_livros_por_autor(primeiro_nome_param VARCHAR(255), ultimo_nome_param VARCHAR(255)) RETURNS TEXT
BEGIN
    DECLARE lista_de_livros TEXT;
    DECLARE done INT DEFAULT 0;
    DECLARE livro_id INT;
    DECLARE titulo_livro VARCHAR(255);

    SET lista_de_livros = '';

    DECLARE cur CURSOR FOR
    SELECT la.id_livro, l.titulo
    FROM Livro_Autor la
    INNER JOIN Livro l ON la.id_livro = l.id
    INNER JOIN Autor a ON la.id_autor = a.id
    WHERE a.primeiro_nome = primeiro_nome_param AND a.ultimo_nome = ultimo_nome_param;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO livro_id, titulo_livro;
        IF done = 1 THEN
            LEAVE read_loop;
        END IF;

        SET lista_de_livros = CONCAT(lista_de_livros, titulo_livro, ', ');
    END LOOP;

    CLOSE cur;

    IF LENGTH(lista_de_livros) > 0 THEN
        SET lista_de_livros = LEFT(lista_de_livros, LENGTH(lista_de_livros) - 2);
    END IF;

    RETURN lista_de_livros;
END;
//

DELIMITER ;

--EX03
DELIMITER $$

CREATE FUNCTION atualizar_resumos()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE livro_id INT;
    DECLARE livro_resumo TEXT;
    DECLARE cur CURSOR FOR SELECT id, resumo FROM Livro;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO livro_id, livro_resumo;
        IF done = 1 THEN
            LEAVE read_loop;
        END IF;

        SET livro_resumo = CONCAT(livro_resumo, ' Este é um excelente livro!');

        UPDATE Livro SET resumo = livro_resumo WHERE id = livro_id;
    END LOOP;

    CLOSE cur;
END;
$$

DELIMITER ;

--EX04
DELIMITER $$

CREATE FUNCTION media_livros_por_editora() RETURNS DECIMAL(10, 2)
BEGIN
    DECLARE total_livros INT;
    DECLARE total_editoras INT;
    DECLARE editora_id INT;
    DECLARE editora_media DECIMAL(10, 2);

    SET total_livros = 0;
    SET total_editoras = 0;
    SET editora_media = 0.00;

    DECLARE cur_editoras CURSOR FOR SELECT id FROM Editora;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET total_editoras = -1;
    OPEN cur_editoras;

    read_editoras: LOOP
        FETCH cur_editoras INTO editora_id;
        IF total_editoras = -1 THEN
            LEAVE read_editoras;
        END IF;

        DECLARE cur_livros CURSOR FOR SELECT COUNT(*) FROM Livro WHERE id_editora = editora_id;
        DECLARE livro_count INT;

        SET livro_count = 0;
        OPEN cur_livros;
        FETCH cur_livros INTO livro_count;
        SET total_livros = total_livros + livro_count;
        CLOSE cur_livros;
    END LOOP;

    CLOSE cur_editoras;

    IF total_editoras > 0 THEN
        SET editora_media = total_livros / total_editoras;
    END IF;

    RETURN editora_media;
END;
$$
DELIMITER ;

--EX05
DELIMITER //

CREATE FUNCTION autores_sem_livros()
RETURNS TEXT
BEGIN
    DECLARE lista_autores TEXT;
    DECLARE done INT DEFAULT 0;
    DECLARE autor_id INT;
    DECLARE autor_nome VARCHAR(255);
    
    SET lista_autores = '';
    

    DECLARE cur CURSOR FOR
    SELECT id, CONCAT(primeiro_nome, ' ', ultimo_nome) FROM Autor;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    

    OPEN cur;
    
  
    read_loop: LOOP
        FETCH cur INTO autor_id, autor_nome;
        IF done = 1 THEN
            LEAVE read_loop;
        END IF;
        

        IF NOT EXISTS (SELECT 1 FROM Livro_Autor WHERE id_autor = autor_id) THEN

            SET lista_autores = CONCAT(lista_autores, autor_nome, ', ');
        END IF;
    END LOOP;
    
    CLOSE cur;
  
    IF lista_autores <> '' THEN
        SET lista_autores = SUBSTRING(lista_autores, 1, LENGTH(lista_autores) - 2);
    END IF;

    RETURN lista_autores;
END;
//

DELIMITER ;
