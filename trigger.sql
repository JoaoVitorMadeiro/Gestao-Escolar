DELIMITER $$

CREATE TRIGGER transferir_aluno
AFTER UPDATE ON matriculas
FOR EACH ROW
BEGIN
    IF OLD.status_matricula <> 'TRANSFERIDA' AND NEW.status_matricula = 'TRANSFERIDA' THEN
        UPDATE turmas
        SET vagas_disponiveis = vagas_disponiveis + 1
        WHERE id_turma = NEW.id_turma;
    END IF;

    IF OLD.status_matricula = 'TRANSFERIDA' AND NEW.status_matricula = 'ATIVA' THEN
        UPDATE turmas
        SET vagas_disponiveis = vagas_disponiveis - 1
        WHERE id_turma = NEW.id_turma;
    END IF;
END $$

DELIMITER ;
