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
