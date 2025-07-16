import mysql.connector
import os

def conectar_banco():
    """Estabelece a conexão com o banco de dados."""
    return mysql.connector.connect(
        host='localhost',
        user='root',      # Altere conforme necessário
        password='1234',  # Altere conforme necessário
        database='gestao_escolar_final2'
    )

def listar_alunos(conn):
    cursor = conn.cursor()
    cursor.execute("SELECT id_aluno, nome_completo, cpf, status FROM alunos")
    alunos = cursor.fetchall()
    print("\n--- Lista de Alunos ---")
    for a in alunos:
        print(f"ID: {a[0]}, Nome: {a[1]}, CPF: {a[2]}, Status: {a[3]}")
    cursor.close()

def inserir_aluno(conn):
    print("\n--- Inserir Novo Aluno ---")
    nome = input("Nome completo: ")
    data_nasc = input("Data de nascimento (YYYY-MM-DD): ")
    cpf = input("CPF: ")
    email = input("Email: ")
    telefone = input("Telefone: ")
    
    cursor = conn.cursor()
    sql = '''
        INSERT INTO alunos (nome_completo, data_nascimento, cpf, email, telefone, status)
        VALUES (%s, %s, %s, %s, %s, 'ATIVO')
    '''
    valores = (nome, data_nasc, cpf, email, telefone)
    try:
        cursor.execute(sql, valores)
        conn.commit()
        print("\n[SUCESSO] Aluno inserido.")
    except mysql.connector.Error as err:
        print(f"\n[ERRO] Falha ao inserir aluno: {err}")
    cursor.close()

def demonstrar_view_alunos_turma(conn):
    """Demonstra uma VIEW fazendo um SELECT nela."""
    print("\n--- (VIEW) Alunos por Turma ---")
    id_turma = input("Digite o ID da turma para ver os alunos: ")
    cursor = conn.cursor()
    query = "SELECT nome_turma, nome_completo, status_aluno FROM vw_alunos_por_turma WHERE id_turma = %s"
    cursor.execute(query, (id_turma,))
    resultados = cursor.fetchall()
    
    if resultados:
        print(f"\nAlunos da Turma '{resultados[0][0]}':")
        for linha in resultados:
            print(f"  - Aluno: {linha[1]} | Status: {linha[2]}")
    else:
        print("Nenhum aluno encontrado para esta turma ou turma inexistente.")
    cursor.close()

def demonstrar_procedure_gerar_boletim(conn):
    """Demonstra uma PROCEDURE chamando-a com CALLPROC."""
    print("\n--- (PROCEDURE) Gerar Boletim do Aluno ---")
    cpf_aluno = input("Digite o CPF do aluno para gerar o boletim: ")
    cursor = conn.cursor()
    try:
        cursor.callproc('gerar_boletim', [cpf_aluno])
        print("\n--- Boletim ---")
        for result in cursor.stored_results():
            boletim = result.fetchall()
            if not boletim:
                print("Nenhuma nota encontrada ou aluno não existe.")
            else:
                for linha in boletim:
                    if 'Aluno com CPF informado não encontrado.' in linha:
                        print(linha[0])
                        break
                    print(f"Disciplina: {linha[4]}, Média: {linha[5]}, Resultado: {linha[6]}")
    except mysql.connector.Error as err:
        print(f"\n[ERRO] Falha ao executar procedure: {err}")
    cursor.close()

def demonstrar_procedure_consultar_vagas(conn):
    """Demonstra uma PROCEDURE sem parâmetros."""
    print("\n--- (PROCEDURE) Consultar Vagas Disponíveis ---")
    cursor = conn.cursor()
    try:
        cursor.callproc('consultar_vagas')
        print("\n--- Vagas por Turma Ativa ---")
        for result in cursor.stored_results():
            vagas = result.fetchall()
            for linha in vagas:
                print(f"Turma: {linha[1]} ({linha[2]}) | Total: {linha[4]} | Disponíveis: {linha[6]}")
    except mysql.connector.Error as err:
        print(f"\n[ERRO] Falha ao executar procedure: {err}")
    cursor.close()

def demonstrar_trigger_transferir_aluno(conn):
    """Demonstra uma TRIGGER causando o evento que a dispara."""
    print("\n--- (TRIGGER) Demonstrar Transferência de Aluno ---")
    id_matricula = input("Digite o ID da matrícula para transferir: ")
    cursor = conn.cursor()
    try:
        cursor.execute("SELECT t.vagas_disponiveis FROM turmas t JOIN matriculas m ON t.id_turma = m.id_turma WHERE m.id_matricula = %s", (id_matricula,))
        vagas_antes = cursor.fetchone()
        if not vagas_antes:
            print("\n[ERRO] Matrícula não encontrada.")
            cursor.close()
            return

        print(f"\nVagas disponíveis ANTES da transferência: {vagas_antes[0]}")
        print("... Transferindo matrícula ...")
        cursor.execute("UPDATE matriculas SET status_matricula = 'TRANSFERIDA' WHERE id_matricula = %s", (id_matricula,))
        conn.commit()
        print("[SUCESSO] Matrícula atualizada para TRANSFERIDA.")

        cursor.execute("SELECT t.vagas_disponiveis FROM turmas t JOIN matriculas m ON t.id_turma = m.id_turma WHERE m.id_matricula = %s", (id_matricula,))
        vagas_depois = cursor.fetchone()
        print(f"Vagas disponíveis DEPOIS da transferência: {vagas_depois[0]}")
        
        if vagas_depois[0] > vagas_antes[0]:
            print("\nProva: A TRIGGER funcionou e incrementou o número de vagas!")
        else:
            print("\nProva: A TRIGGER não parece ter alterado o número de vagas como esperado.")
    except mysql.connector.Error as err:
        print(f"\n[ERRO] Falha ao atualizar matrícula: {err}")
    cursor.close()

def matricular_aluno_na_turma(conn):
    """Chama a procedure de matrícula de aluno em uma turma, garantindo atomicidade."""
    print("\n--- Matricular Aluno em Turma ---")
    id_aluno = input("Digite o ID do aluno: ")
    id_turma = input("Digite o ID da turma: ")
    cursor = conn.cursor()
    try:
        cursor.callproc('matricular_aluno_na_turma', [id_aluno, id_turma])
        for result in cursor.stored_results():
            mensagem = result.fetchone()
            if mensagem:
                print(mensagem[0])
    except mysql.connector.Error as err:
        print(f"\n[ERRO] Falha ao executar matrícula: {err}")
    cursor.close()

def menu():
    try:
        conn = conectar_banco()
        while True:
            print("\n---------------- MENU DE GESTÃO ESCOLAR ----------------")
            print("--- Alunos ---")
            print("1. Listar todos os alunos")
            print("2. Inserir novo aluno")
            print("\n--- Demonstrações do Banco de Dados ---")
            print("5. [VIEW]      Ver alunos de uma turma específica")
            print("6. [PROCEDURE] Gerar boletim de um aluno (por CPF)")
            print("7. [PROCEDURE] Consultar vagas disponíveis nas turmas")
            print("8. [TRIGGER]   Realizar a transferência de uma matrícula")
            print("3. Matricular aluno em turma")
            print("\n0. Sair")

            opcao = input("Escolha uma opção: ")
            
            if opcao == '1':
                listar_alunos(conn)
            elif opcao == '2':
                inserir_aluno(conn)
            elif opcao == '5':
                demonstrar_view_alunos_turma(conn)
            elif opcao == '6':
                demonstrar_procedure_gerar_boletim(conn)
            elif opcao == '7':
                demonstrar_procedure_consultar_vagas(conn)
            elif opcao == '8':
                demonstrar_trigger_transferir_aluno(conn)
            elif opcao == '3':
                matricular_aluno_na_turma(conn)
            elif opcao == '0':
                break
            else:
                print("Opção inválida. Tente novamente.")
        conn.close()
        print("Conexão com o banco de dados encerrada.")
    except mysql.connector.Error as err:
        print(f"Erro fatal de conexão com o banco de dados: {err}")

if __name__ == '__main__':
    menu()