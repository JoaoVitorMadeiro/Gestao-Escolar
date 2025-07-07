CREATE OR REPLACE VIEW vw_alunos_por_turma AS
SELECT 
    t.id_turma,
    t.nome_turma,
    a.id_aluno,
    a.nome_completo,
    a.status AS status_aluno
FROM turmas t
JOIN matriculas m ON m.id_turma = t.id_turma
JOIN alunos a ON a.id_aluno = m.id_aluno;

CREATE OR REPLACE VIEW vw_professores_por_turma AS
SELECT
    t.id_turma,
    t.nome_turma,
    p.id_professor,
    p.nome_completo
FROM turmas t
JOIN professores p ON p.id_professor = t.id_professor_responsavel;

CREATE OR REPLACE VIEW vw_status_alunos_por_ano AS
SELECT 
    YEAR(m.data_matricula) AS ano_letivo,
    a.status AS status_aluno,
    COUNT(*) AS quantidade
FROM matriculas m
JOIN alunos a ON a.id_aluno = m.id_aluno
GROUP BY ano_letivo, a.status
ORDER BY ano_letivo, a.status;

CREATE OR REPLACE VIEW vw_turmas_disciplinas_professor AS
SELECT
    p.id_professor,
    p.nome_completo AS professor,
    t.id_turma,
    t.nome_turma,
    d.id_disciplina,
    d.nome_disciplina
FROM professores p
JOIN turmas t ON t.id_professor_responsavel = p.id_professor
CROSS JOIN disciplinas d
WHERE t.status = 'ATIVA' AND d.status = 'ATIVA'
ORDER BY p.nome_completo, t.nome_turma, d.nome_disciplina;