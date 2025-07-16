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

-- Remove o procedimento se ele já existir para evitar erros de "já existe"
DROP PROCEDURE IF EXISTS matricular_aluno_na_turma;

-- Cria um procedimento para matricular um aluno em uma turma
-- com verificação de vagas disponíveis.
-- Parâmetros:
--   p_id_aluno: O ID do aluno a ser matriculado.
--   p_id_turma: O ID da turma onde o aluno será matriculado.
CREATE PROCEDURE matricular_aluno_na_turma(
    IN p_id_aluno INT,
    IN p_id_turma INT
)
BEGIN
    -- Declara uma variável local para armazenar o número de vagas disponíveis.
    -- ATENÇÃO: As declarações de variáveis (DECLARE) devem vir no início do bloco BEGIN.
    DECLARE v_vagas_disponiveis INT DEFAULT 0;

    START TRANSACTION;

    -- Seleciona o número de vagas da turma.
    -- 'FOR UPDATE' bloqueia a linha da turma para evitar que outras transações
    -- alterem as vagas enquanto esta transação está em andamento (evita problemas de concorrência).
    SELECT vagas INTO v_vagas_disponiveis
    FROM turmas
    WHERE id_turma = p_id_turma
    FOR UPDATE;

    -- Verifica se há vagas disponíveis na turma
    IF v_vagas_disponiveis > 0 THEN
        -- Se houver vagas, decrementa o número de vagas na tabela 'turmas'
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

-- Para executar o procedimento de matrícula:
-- 1. Certifique-se de que o aluno com o 'ID_DO_ALUNO_AQUI' já existe na tabela 'alunos'.
-- 2. Certifique-se de que a turma com o 'ID_DA_TURMA_AQUI' existe e tem vagas.
-- Exemplo de uso:
-- CALL matricular_aluno_na_turma(1, 1); -- Tente matricular o aluno com ID 1 na turma com ID 1

SELECT
    id_turma,
    nome_turma,
    vagas
FROM
    turmas
WHERE
    id_turma = 1;
    
    CALL matricular_aluno_na_turma(37, 1);