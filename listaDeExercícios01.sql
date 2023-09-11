SELECT titulo FROM livros;

SELECT nome FROM autores WHERE nascimento < 1900-01-01;

SELECT titulo, autor_id, nome FROM livros 
JOIN autores a ON a.id = l.autor_id
WHERE a.nome = 'J.K Rowling';