CREATE DATABASE exerciciodefixacao;
USE exerciciodefixacao;

--EX01
--A)
CREATE TABLE nomes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255)
);
INSERT INTO nomes (nome) VALUES
    ('Roberta'),
    ('Roberto'),
    ('Maria Clara'),
    ('João');

--B)
SELECT UPPER(nome) AS nome_maiusculo FROM nomes;

--C)
SELECT nome, LENGTH(nome) AS tamanho_nome FROM nomes;

--D)
-- Selecionar nomes com tratamento adequado
SELECT 
    CASE 
        WHEN nome LIKE '%Roberto%' OR nome LIKE '%João%' THEN CONCAT('Sr. ', nome)
        WHEN nome LIKE '%Roberta%' OR nome LIKE '%Maria Clara%' THEN CONCAT('Sra. ', nome)
        ELSE nome
    END AS nome_com_tratamento
FROM nomes;


--EX02
--A)
CREATE TABLE produtos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    produto VARCHAR(255) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL,
    quantidade INT NOT NULL
);

--B)
SELECT produto, ROUND(preco, 2) AS preco_arredondado, quantidade
FROM produtos;

--C)
SELECT produto, preco, ABS(quantidade) AS quantidade_absoluta
FROM produtos;

--D)
SELECT AVG(preco) AS media_precos
FROM produtos;
