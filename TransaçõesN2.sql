-- Inicia uma transação para garantir que o cadastro do aluno seja uma operação atômica
START TRANSACTION;

SET @nome_aluno_novo = 'João Pedro';
SET @data_nascimento_aluno_novo = '2007-07-25';
SET @cpf_aluno_novo = '123.456.789-09'; -- EX: Altere este CPF para um valor único a cada execução
SET @email_aluno_novo = 'joao.pedro@email.com';
SET @telefone_aluno_novo = '99887-7665';

INSERT INTO alunos (nome_completo, data_nascimento, cpf, email, telefone, status)
VALUES (@nome_aluno_novo, @data_nascimento_aluno_novo, @cpf_aluno_novo, @email_aluno_novo, @telefone_aluno_novo, 'ATIVO');

COMMIT;

SELECT id_aluno, nome_completo, cpf FROM alunos WHERE cpf = @cpf_aluno_novo;

DELIMITER $$

DROP PROCEDURE IF EXISTS matricular_aluno_na_turma;

CREATE PROCEDURE matricular_aluno_na_turma(
    IN p_id_aluno INT,
    IN p_id_turma INT
)
BEGIN
    DECLARE v_vagas_disponiveis INT DEFAULT 0;

    START TRANSACTION;

    SELECT vagas INTO v_vagas_disponiveis
    FROM turmas
    WHERE id_turma = p_id_turma
    FOR UPDATE;

    IF v_vagas_disponiveis > 0 THEN
        UPDATE turmas
        SET vagas = vagas - 1
        WHERE id_turma = p_id_turma;

        INSERT INTO matriculas (id_aluno, id_turma, data_matricula, status_matricula, resultado_final)
        VALUES (p_id_aluno, p_id_turma, CURDATE(), 'ATIVA', 'EM_ANDAMENTO');

        COMMIT;
        SELECT CONCAT('Sucesso: Aluno ID ', p_id_aluno, ' matriculado na turma ID ', p_id_turma, '. Vagas restantes: ', v_vagas_disponiveis - 1) AS 'Status da Matrícula';
    ELSE
        ROLLBACK;
        SELECT CONCAT('Erro: Não foi possível matricular o aluno ID ', p_id_aluno, ' na turma ID ', p_id_turma, '. Não há vagas disponíveis.') AS 'Status da Matrícula';
    END IF;
END$$

DELIMITER ;

SELECT
    id_turma,
    nome_turma,
    vagas
FROM
    turmas
WHERE
    id_turma = 1;
    
    CALL matricular_aluno_na_turma(37, 1);