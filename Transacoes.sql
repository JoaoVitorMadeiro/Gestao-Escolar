-- Exemplo 1: Inserção de um novo aluno em transação
START TRANSACTION;
INSERT INTO alunos (nome_completo, data_nascimento, cpf, email, telefone, status)
VALUES ('João da Silva', '2005-08-15', '12345678900', 'joao@email.com', '11999999999', 'ATIVO');
-- Se tudo estiver certo, confirme:
COMMIT;
-- Se houver erro, use:
-- ROLLBACK;

-- Exemplo 2: Atualização de dados de um aluno em transação
START TRANSACTION;
UPDATE alunos SET email = 'novoemail@email.com' WHERE cpf = '12345678900';
-- Se tudo estiver certo, confirme:
COMMIT;
-- Se houver erro, use:
-- ROLLBACK;

-- Exemplo 3: Exclusão de um aluno em transação
START TRANSACTION;
DELETE FROM alunos WHERE cpf = '12345678900';
-- Se tudo estiver certo, confirme:
COMMIT;
-- Se houver erro, use:
-- ROLLBACK; 