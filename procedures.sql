-- Procedure #1: Gera boletim por CPF.

DELIMITER $$

CREATE PROCEDURE gerar_boletim(IN p_cpf_input VARCHAR(14))
BEGIN
    DECLARE v_id_aluno INT;

    SELECT a.id_aluno INTO v_id_aluno
    FROM alunos a
    WHERE REPLACE(REPLACE(REPLACE(a.cpf, '.', ''), '-', ''), ' ', '') = 
          REPLACE(REPLACE(REPLACE(p_cpf_input, '.', ''), '-', ''), ' ', '')
    LIMIT 1;

    IF v_id_aluno IS NULL THEN
        SELECT 'Aluno com CPF informado não encontrado.' AS mensagem;
    ELSE
        SELECT
            a.nome_completo AS aluno,
            a.cpf,
            t.nome_turma,
            t.ano_letivo,
            d.nome_disciplina,
            ROUND(AVG(n.nota_valor), 2) AS media_final,
            CASE
                WHEN ROUND(AVG(n.nota_valor), 2) >= 6.0 THEN 'APROVADO'
                ELSE 'REPROVADO'
            END AS resultado_calculado
        FROM alunos a
        JOIN matriculas m ON a.id_aluno = m.id_aluno
        JOIN turmas t ON m.id_turma = t.id_turma
        LEFT JOIN notas n ON m.id_matricula = n.id_matricula
        LEFT JOIN disciplinas d ON n.id_disciplina = d.id_disciplina
        WHERE a.id_aluno = v_id_aluno
        GROUP BY
            a.nome_completo,
            a.cpf,
            t.nome_turma,
            t.ano_letivo,
            d.nome_disciplina
        ORDER BY d.nome_disciplina;
    END IF;
END $$
DELIMITER ;

-- Procedure #2: Consulta a vaga das turmas ativas

DELIMITER $$

CREATE PROCEDURE consultar_vagas()
BEGIN
    SELECT
        t.id_turma,
        t.nome_turma,
        t.ano_letivo,
        t.turno,
        t.vagas AS total_vagas,
        COUNT(m.id_matricula) AS matriculas_ativas,
        t.vagas - COUNT(m.id_matricula) AS vagas_disponiveis
    FROM turmas t
    LEFT JOIN matriculas m 
        ON t.id_turma = m.id_turma AND m.status_matricula = 'ATIVA'
    WHERE t.status = 'ATIVA'
    GROUP BY t.id_turma, t.nome_turma, t.ano_letivo, t.turno, t.vagas
    ORDER BY t.ano_letivo, t.nome_turma;
END $$
DELIMITER ;

-- Procedure #3: Exibe turmas por ano letivo

DELIMITER $$

CREATE PROCEDURE listar_turmas_por_ano(IN p_ano_letivo INT)
BEGIN
    SELECT
        t.id_turma,
        t.nome_turma,
        t.ano_letivo,
        t.turno,
        t.sala,
        t.vagas,
        p.nome_completo AS professor_responsavel,
        t.status
    FROM turmas t
    LEFT JOIN professores p ON t.id_professor_responsavel = p.id_professor
    WHERE t.ano_letivo = p_ano_letivo
    ORDER BY t.nome_turma;
END $$
DELIMITER ;
