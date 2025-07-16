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
