DELIMITER $$

-- Procedure para matricular um aluno em uma turma, verificando vagas disponíveis
CREATE PROCEDURE matricular_aluno_na_turma(
    IN p_id_aluno INT,
    IN p_id_turma INT
)
BEGIN
    DECLARE v_vagas_disponiveis INT DEFAULT 0;
    DECLARE erro INT DEFAULT 0;

    -- Handler para capturar qualquer erro e acionar o rollback
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        BEGIN
            SET erro = 1;
            ROLLBACK;
        END;

    START TRANSACTION;

    -- Seleciona o número de vagas da turma e bloqueia a linha para evitar concorrência
    SELECT vagas INTO v_vagas_disponiveis
    FROM turmas
    WHERE id_turma = p_id_turma
    FOR UPDATE;

    -- Verifica se há vagas disponíveis na turma
    IF v_vagas_disponiveis > 0 THEN
        -- Decrementa o número de vagas
        UPDATE turmas
        SET vagas = vagas - 1
        WHERE id_turma = p_id_turma;

        -- Insere o registro de matrícula
        INSERT INTO matriculas (id_aluno, id_turma, data_matricula, status_matricula, resultado_final)
        VALUES (p_id_aluno, p_id_turma, CURDATE(), 'ATIVA', 'EM_ANDAMENTO');
    ELSE
        -- Se não houver vagas, faz rollback e retorna mensagem
        SET erro = 1;
        ROLLBACK;
        SELECT CONCAT('Erro: Não há vagas disponíveis para a turma ID ', p_id_turma) AS 'Status da Matrícula';
    END IF;

    -- Se não houve erro, confirma a transação e retorna mensagem de sucesso
    IF erro = 0 THEN
        COMMIT;
        SELECT CONCAT('Sucesso: Aluno ID ', p_id_aluno, ' matriculado na turma ID ', p_id_turma, '. Vagas restantes: ', v_vagas_disponiveis - 1) AS 'Status da Matrícula';
    END IF;
END$$
DELIMITER ;