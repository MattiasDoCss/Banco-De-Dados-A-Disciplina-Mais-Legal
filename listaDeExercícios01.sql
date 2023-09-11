--Exercício 1:
SELECT titulo FROM livros;

--Exercício 2:
SELECT nome FROM autores WHERE nascimento < 1900-01-01;

--Exercício 3:
SELECT titulo, autor_id, nome FROM livros 
JOIN autores a ON a.id = l.autor_id
WHERE a.nome = 'J.K Rowling';

--Exercício 4:
SELECT aluno_id, nome, curso FROM alunos a
LEFT JOIN matriculas m ON m.id  = a.id
WHERE curso = "Engenharia de Software";

--Exercício 5:
SELECT produto, SUM(receita) AS total.r FROM vendas
GROUP BY produto;
