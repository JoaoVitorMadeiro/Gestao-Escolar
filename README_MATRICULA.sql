-- PASSO 1: Cadastrar um novo aluno (exemplo)
INSERT INTO alunos (nome_completo, data_nascimento, cpf, email, telefone, status)
VALUES ('Maria da Silva', '2006-03-12', '12345678901', 'maria@email.com', '11988887777', 'ATIVO');
-- Após executar, anote o id_aluno gerado (por exemplo, 5)

-- PASSO 2: Criar a procedure de matrícula (execute apenas uma vez)
DELIMITER $$
CREATE PROCEDURE matricular_aluno_na_turma(
    IN p_id_aluno INT,
    IN p_id_turma INT
)
BEGIN
    DECLARE v_vagas_disponiveis INT DEFAULT 0;
    DECLARE erro INT DEFAULT 0;

    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        BEGIN
            SET erro = 1;
            ROLLBACK;
        END;

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
    ELSE
        SET erro = 1;
        ROLLBACK;
        SELECT CONCAT('Erro: Não há vagas disponíveis para a turma ID ', p_id_turma) AS 'Status da Matrícula';
    END IF;

    IF erro = 0 THEN
        COMMIT;
        SELECT CONCAT('Sucesso: Aluno ID ', p_id_aluno, ' matriculado na turma ID ', p_id_turma, '. Vagas restantes: ', v_vagas_disponiveis - 1) AS 'Status da Matrícula';
    END IF;
END$$
DELIMITER ;

-- PASSO 3: Matricular o aluno em uma turma
-- Substitua 5 pelo id_aluno e 2 pelo id_turma desejado
CALL matricular_aluno_na_turma(5, 2); 