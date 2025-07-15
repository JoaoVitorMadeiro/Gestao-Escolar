CREATE DATABASE IF NOT EXISTS gestao_escolar_final2;
USE gestao_escolar_final2;

-- 1. Tabela de Alunos
CREATE TABLE alunos (
    id_aluno INT AUTO_INCREMENT PRIMARY KEY,
    nome_completo VARCHAR(255) NOT NULL,
    data_nascimento DATE NOT NULL,
    cpf VARCHAR(14) NOT NULL UNIQUE,
    email VARCHAR(255),
    telefone VARCHAR(20),
    status ENUM('ATIVO', 'INATIVO', 'TRANSFERIDO') DEFAULT 'ATIVO'
);

-- 2. Tabela de Professores
CREATE TABLE professores (
    id_professor INT AUTO_INCREMENT PRIMARY KEY,
    nome_completo VARCHAR(255) NOT NULL,
    cpf VARCHAR(14) NOT NULL UNIQUE,
    email VARCHAR(255) UNIQUE,
    telefone VARCHAR(20),
    formacao VARCHAR(100) NOT NULL,
    status ENUM('ATIVO', 'INATIVO') DEFAULT 'ATIVO'
);

-- 3. Tabela de Turmas
CREATE TABLE turmas (
    id_turma INT AUTO_INCREMENT PRIMARY KEY,
    nome_turma VARCHAR(100) NOT NULL,
    ano_letivo YEAR NOT NULL,
    turno ENUM('MANHA', 'TARDE', 'NOITE') NOT NULL,
    sala VARCHAR(50) NOT NULL, -- Novo campo
    vagas INT NOT NULL, -- Novo campo
    id_professor_responsavel INT,
    status ENUM('ATIVA', 'INATIVA') DEFAULT 'ATIVA',
    
    FOREIGN KEY (id_professor_responsavel) REFERENCES professores(id_professor)
);

-- 4. Tabela de Disciplinas
CREATE TABLE disciplinas (
    id_disciplina INT AUTO_INCREMENT PRIMARY KEY,
    nome_disciplina VARCHAR(100) NOT NULL UNIQUE,
    carga_horaria INT DEFAULT 60, -- horas por semestre
    status ENUM('ATIVA', 'INATIVA') DEFAULT 'ATIVA'
);

-- 5. Tabela de Matrículas
CREATE TABLE matriculas (
    id_matricula INT AUTO_INCREMENT PRIMARY KEY,
    id_aluno INT NOT NULL,
    id_turma INT NOT NULL,
    data_matricula DATE NOT NULL,
    status_matricula ENUM('ATIVA', 'TRANCADA', 'TRANSFERIDA', 'CONCLUIDA', 'CANCELADA') DEFAULT 'ATIVA',
    resultado_final ENUM('APROVADO', 'REPROVADO', 'EM_ANDAMENTO') DEFAULT 'EM_ANDAMENTO',
    
    FOREIGN KEY (id_aluno) REFERENCES alunos(id_aluno) ON DELETE CASCADE,
    FOREIGN KEY (id_turma) REFERENCES turmas(id_turma) ON DELETE CASCADE,
    
    UNIQUE KEY uk_aluno_turma (id_aluno, id_turma)
);

-- 6. Tabela de Notas
CREATE TABLE notas (
    id_nota INT AUTO_INCREMENT PRIMARY KEY,
    id_matricula INT NOT NULL,
    id_disciplina INT NOT NULL,
    bimestre TINYINT NOT NULL CHECK (bimestre BETWEEN 1 AND 4),
    nota_valor DECIMAL(4,2) NOT NULL CHECK (nota_valor BETWEEN 0 AND 10),
    tipo_avaliacao ENUM('ANALISE', 'AVALIACAO') NOT NULL,
    
    FOREIGN KEY (id_matricula) REFERENCES matriculas(id_matricula) ON DELETE CASCADE,
    FOREIGN KEY (id_disciplina) REFERENCES disciplinas(id_disciplina) ON DELETE CASCADE
);