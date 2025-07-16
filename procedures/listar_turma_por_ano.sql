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
