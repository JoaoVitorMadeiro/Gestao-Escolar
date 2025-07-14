-- =====================================================================
-- PARTE 1: CRIAÇÃO DAS TABELAS DE TESTE
-- =====================================================================

-- Limpando o ambiente de teste (opcional)
DROP TABLE IF EXISTS notas, matriculas, alunos, turmas, professores, disciplinas;

-- Tabelas principais
CREATE TABLE alunos (
    id_aluno INT AUTO_INCREMENT PRIMARY KEY,
    nome_completo VARCHAR(255) NOT NULL,
    cpf VARCHAR(14) NOT NULL UNIQUE
);

CREATE TABLE professores (
    id_professor INT AUTO_INCREMENT PRIMARY KEY,
    nome_completo VARCHAR(255) NOT NULL
);

CREATE TABLE disciplinas (
    id_disciplina INT AUTO_INCREMENT PRIMARY KEY,
    nome_disciplina VARCHAR(100) NOT NULL
);

CREATE TABLE turmas (
    id_turma INT AUTO_INCREMENT PRIMARY KEY,
    nome_turma VARCHAR(100) NOT NULL,
    ano_letivo YEAR NOT NULL,
    turno VARCHAR(20),
    sala VARCHAR(20),
    vagas INT NOT NULL,
    -- COLUNA ADICIONADA APENAS PARA TESTAR O TRIGGER. NÃO É RECOMENDADA EM PRODUÇÃO.
    vagas_disponiveis INT,
    id_professor_responsavel INT,
    status ENUM('ATIVA', 'INATIVA', 'CONCLUÍDA') NOT NULL,
    FOREIGN KEY (id_professor_responsavel) REFERENCES professores(id_professor)
);

CREATE TABLE matriculas (
    id_matricula INT AUTO_INCREMENT PRIMARY KEY,
    id_aluno INT NOT NULL,
    id_turma INT NOT NULL,
    status_matricula ENUM('ATIVA', 'TRANSFERIDA', 'CANCELADA') NOT NULL,
    FOREIGN KEY (id_aluno) REFERENCES alunos(id_aluno),
    FOREIGN KEY (id_turma) REFERENCES turmas(id_turma)
);

CREATE TABLE notas (
    id_nota INT AUTO_INCREMENT PRIMARY KEY,
    id_matricula INT NOT NULL,
    id_disciplina INT NOT NULL,
    nota_valor DECIMAL(4, 2) NOT NULL,
    FOREIGN KEY (id_matricula) REFERENCES matriculas(id_matricula),
    FOREIGN KEY (id_disciplina) REFERENCES disciplinas(id_disciplina)
);


-- =====================================================================
-- PARTE 2: INSERÇÃO DE DADOS DE TESTE
-- =====================================================================

-- Professores
INSERT INTO professores (id_professor, nome_completo) VALUES
(1, 'Alberto Santos'),
(2, 'Beatriz Lima');

-- Disciplinas
INSERT INTO disciplinas (id_disciplina, nome_disciplina) VALUES
(1, 'Matemática'),
(2, 'Português'),
(3, 'História');

-- Alunos (com CPFs em formatos diferentes)
INSERT INTO alunos (id_aluno, nome_completo, cpf) VALUES
(1, 'Maria Souza', '111.222.333-44'),   -- Aluna que será aprovada
(2, 'João Silva', '55566677788'),      -- Aluno que será reprovado
(3, 'Carlos Pereira', '333.333.333-33'), -- Aluno que será transferido
(4, 'Ana Costa', '444.444.444-44'),      -- Aluna que terá matrícula cancelada
(5, 'Pedro Martins', '777 777 777 77');  -- Aluno sem notas

-- Turmas
-- (Note que vagas e vagas_disponiveis começam iguais para o teste do trigger)
INSERT INTO turmas (id_turma, nome_turma, ano_letivo, turno, sala, vagas, vagas_disponiveis, id_professor_responsavel, status) VALUES
(1, '101-A', 2025, 'Manhã', 'SALA 01', 30, 30, 1, 'ATIVA'),
(2, '102-B', 2025, 'Tarde', 'SALA 02', 2, 2, 2, 'ATIVA'), -- Turma pequena para teste de lotação
(3, '201-A', 2024, 'Manhã', 'SALA 03', 25, 25, 1, 'CONCLUÍDA');

-- Matrículas
INSERT INTO matriculas (id_matricula, id_aluno, id_turma, status_matricula) VALUES
(1, 1, 1, 'ATIVA'), -- Maria na Turma 101-A
(2, 2, 1, 'ATIVA'), -- João na Turma 101-A
(3, 3, 2, 'ATIVA'), -- Carlos na Turma 102-B
(4, 4, 2, 'ATIVA'), -- Ana na Turma 102-B
(5, 5, 1, 'ATIVA'); -- Pedro na Turma 101-A

-- Notas
-- Notas para Maria (aprovada)
INSERT INTO notas (id_matricula, id_disciplina, nota_valor) VALUES
(1, 1, 7.5), (1, 1, 8.5),
(1, 2, 6.0), (1, 2, 7.0);

-- Notas para João (reprovado)
INSERT INTO notas (id_matricula, id_disciplina, nota_valor) VALUES
(2, 1, 4.0), (2, 1, 5.5),
(2, 2, 5.0), (2, 2, 6.0);

-- Atualizando o contador de vagas_disponiveis para refletir as matrículas iniciais (simulando o que um trigger de INSERT faria)
UPDATE turmas SET vagas_disponiveis = vagas_disponiveis - 3 WHERE id_turma = 1; -- 3 alunos na turma 1
UPDATE turmas SET vagas_disponiveis = vagas_disponiveis - 2 WHERE id_turma = 2; -- 2 alunos na turma 2


-- =====================================================================
-- PARTE 3: SCRIPT DE VALIDAÇÃO
-- Execute esta parte após criar e carregar os dados.
-- =====================================================================

-- ------
-- Teste 1: Procedure `listar_turmas_por_ano`
-- ------
SELECT '-- Testando listar_turmas_por_ano (2025) --' AS Teste;
CALL listar_turmas_por_ano(2025);
-- Resultado Esperado: Deve listar as turmas 101-A e 102-B.

SELECT '-- Testando listar_turmas_por_ano (2023) --' AS Teste;
CALL listar_turmas_por_ano(2023);
-- Resultado Esperado: Deve retornar um conjunto vazio.


-- ------
-- Teste 2: Procedure `consultar_vagas`
-- ------
SELECT '-- Testando consultar_vagas (estado inicial) --' AS Teste;
CALL consultar_vagas();
-- Resultado Esperado:
-- Turma 101-A: total_vagas=30, matriculas_ativas=3, vagas_disponiveis=27
-- Turma 102-B: total_vagas=2, matriculas_ativas=2, vagas_disponiveis=0
-- A turma 201-A não deve aparecer, pois não está ATIVA.


-- ------
-- Teste 3: Procedure `gerar_boletim`
-- ------
SELECT '-- Testando gerar_boletim (Aluna Aprovada) --' AS Teste;
CALL gerar_boletim('111.222.333-44');
-- Resultado Esperado: Boletim da Maria Souza com médias >= 6.0 e status 'APROVADO'.

SELECT '-- Testando gerar_boletim (Aluno Reprovado) --' AS Teste;
CALL gerar_boletim('55566677788');
-- Resultado Esperado: Boletim do João Silva com pelo menos uma média < 6.0 e status 'REPROVADO'.

SELECT '-- Testando gerar_boletim (Aluno Sem Notas) --' AS Teste;
CALL gerar_boletim('777 777 777 77');
-- Resultado Esperado: Retorna o nome do aluno, turma, mas com média e resultado nulos.

SELECT '-- Testando gerar_boletim (CPF Inexistente) --' AS Teste;
CALL gerar_boletim('000.000.000-00');
-- Resultado Esperado: Mensagem 'Aluno com CPF informado não encontrado.'.


-- ------
-- Teste 4: Trigger `transferir_aluno`
-- ------
-- **Lembrete:** Este teste só funciona porque a coluna `vagas_disponiveis` foi adicionada à tabela `turmas`.

SELECT '-- Testando o TRIGGER (passo 1: estado atual das vagas) --' AS Teste;
SELECT id_turma, nome_turma, vagas, vagas_disponiveis FROM turmas WHERE id_turma = 2;
-- Resultado Esperado: Turma 102-B com vagas_disponiveis = 0.

SELECT '-- Testando o TRIGGER (passo 2: transferindo um aluno) --' AS Teste;
-- O aluno Carlos Pereira (id_aluno=3, id_matricula=3) será transferido.
UPDATE matriculas SET status_matricula = 'TRANSFERIDA' WHERE id_matricula = 3;
-- Ação Esperada: O trigger deve ser acionado.

SELECT '-- Testando o TRIGGER (passo 3: verificando o resultado) --' AS Teste;
SELECT id_turma, nome_turma, vagas, vagas_disponiveis FROM turmas WHERE id_turma = 2;
-- Resultado Esperado: O trigger deve ter incrementado as vagas. Turma 102-B com vagas_disponiveis = 1.

SELECT '-- Testando o TRIGGER (passo 4: retornando o aluno para ATIVA) --' AS Teste;
UPDATE matriculas SET status_matricula = 'ATIVA' WHERE id_matricula = 3;
-- Ação Esperada: O trigger deve ser acionado novamente.

SELECT '-- Testando o TRIGGER (passo 5: verificando o resultado) --' AS Teste;
SELECT id_turma, nome_turma, vagas, vagas_disponiveis FROM turmas WHERE id_turma = 2;
-- Resultado Esperado: O trigger deve ter decrementado as vagas. Turma 102-B com vagas_disponiveis = 0.

-- Teste de comportamento não esperado pelo trigger
SELECT '-- Testando o TRIGGER (passo 6: cancelando uma matrícula) --' AS Teste;
-- A aluna Ana Costa (id_aluno=4, id_matricula=4) será cancelada.
UPDATE matriculas SET status_matricula = 'CANCELADA' WHERE id_matricula = 4;

SELECT '-- Testando o TRIGGER (passo 7: verificando o resultado) --' AS Teste;
SELECT id_turma, nome_turma, vagas, vagas_disponiveis FROM turmas WHERE id_turma = 2;
-- Resultado Esperado: O valor de vagas_disponiveis deve continuar 0, pois o trigger não trata o status 'CANCELADA'.

-- Verificando com a procedure `consultar_vagas`, que mostra a realidade
SELECT '-- Verificação final com a procedure `consultar_vagas` --' AS Teste;
CALL consultar_vagas();
-- Resultado Esperado: A procedure `consultar_vagas` mostrará que a Turma 102-B agora tem
-- 1 vaga disponível (Carlos ATIVO), pois não conta a matrícula CANCELADA de Ana.
-- Isso prova a inconsistência entre o trigger e a procedure.