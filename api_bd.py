import mysql.connector
import os

def conectar_banco():
    return mysql.connector.connect(
        host='localhost',
        user='root',  # Altere conforme necessário
        password='1005',  # Altere conforme necessário
        database='gestao_escolar_final2'
    )

def listar_alunos(conn):
    cursor = conn.cursor()
    cursor.execute("SELECT id_aluno, nome_completo, cpf, status FROM alunos")
    alunos = cursor.fetchall()
    print("\nAlunos:")
    for a in alunos:
        print(f"ID: {a[0]}, Nome: {a[1]}, CPF: {a[2]}, Status: {a[3]}")
    cursor.close()

def consultar_aluno(conn):
    cpf = input("Digite o CPF do aluno: ")
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM alunos WHERE cpf = %s", (cpf,))
    aluno = cursor.fetchone()
    if aluno:
        print(f"\nDados do Aluno: {aluno}")
    else:
        print("Aluno não encontrado.")
    cursor.close()

def inserir_aluno(conn):
    nome = input("Nome completo: ")
    data_nasc = input("Data de nascimento (YYYY-MM-DD): ")
    cpf = input("CPF: ")
    email = input("Email: ")
    telefone = input("Telefone: ")
    status = input("Status (ATIVO, INATIVO, TRANSFERIDO) [ATIVO]: ") or "ATIVO"

    cursor = conn.cursor()
    sql = '''
        INSERT INTO alunos (nome_completo, data_nascimento, cpf, email, telefone, status)
        VALUES (%s, %s, %s, %s, %s, %s)
    '''
    valores = (nome, data_nasc, cpf, email, telefone, status)
    try:
        cursor.execute(sql, valores)
        conn.commit()
        print("Aluno inserido com sucesso.")
    except mysql.connector.Error as err:
        print(f"Erro ao inserir aluno: {err}")
    cursor.close()

def deletar_aluno(conn):
    cpf = input("Digite o CPF do aluno a deletar: ")
    cursor = conn.cursor()
    cursor.execute("DELETE FROM alunos WHERE cpf = %s", (cpf,))
    conn.commit()
    if cursor.rowcount:
        print("Aluno deletado com sucesso.")
    else:
        print("Aluno não encontrado.")
    cursor.close()

def listar_views(conn):
    cursor = conn.cursor()
    cursor.execute("SELECT table_name FROM information_schema.views WHERE table_schema = 'gestao_escolar_final2'")
    views = cursor.fetchall()
    print("\nViews:")
    for v in views:
        print(f"View: {v[0]}")
    cursor.close()


def listar_triggers(conn):
    cursor = conn.cursor()
    cursor.execute("SELECT trigger_name, event_manipulation, event_object_table FROM information_schema.triggers WHERE trigger_schema = 'gestao_escolar_final2'")
    triggers = cursor.fetchall()
    print("\nTriggers:")
    for t in triggers:
        print(f"Trigger: {t[0]}, Evento: {t[1]}, Tabela: {t[2]}")
    cursor.close()


def listar_procedures(conn):
    cursor = conn.cursor()
    cursor.execute("SELECT routine_name FROM information_schema.routines WHERE routine_type='PROCEDURE' AND routine_schema = 'gestao_escolar_final2'")
    procedures = cursor.fetchall()
    print("\nProcedures:")
    for p in procedures:
        print(f"Procedure: {p[0]}")
    cursor.close()


def mostrar_transacoes_ativas(conn):
    cursor = conn.cursor()
    cursor.execute("SHOW PROCESSLIST")
    processos = cursor.fetchall()
    print("\nTransações ativas (processos):")
    for proc in processos:
        print(f"Id: {proc[0]}, Usuário: {proc[1]}, Host: {proc[2]}, DB: {proc[3]}, Comando: {proc[4]}, Tempo: {proc[5]}, Estado: {proc[6]}, Info: {proc[7]}")
    cursor.close()

def executar_script_sql(conn, caminho_arquivo):
    if not os.path.exists(caminho_arquivo):
        print(f"Arquivo não encontrado: {caminho_arquivo}")
        return
    with open(caminho_arquivo, 'r', encoding='utf-8') as f:
        script = f.read()
    cursor = conn.cursor()
    try:
        for result in cursor.execute(script, multi=True):
            pass  # Apenas executa, não precisa processar resultados
        conn.commit()
        print(f"Script '{os.path.basename(caminho_arquivo)}' executado com sucesso!")
    except Exception as e:
        print(f"Erro ao executar script '{os.path.basename(caminho_arquivo)}': {e}")
    cursor.close()


def executar_todos_scripts(conn):
    base = os.path.dirname(os.path.abspath(__file__))
    arquivos = ['VIEW.sql', 'trigger.sql', 'procedures.sql']
    for nome in arquivos:
        caminho = os.path.join(base, nome)
        executar_script_sql(conn, caminho)

def menu():
    try:
        conn = conectar_banco()
        while True:
            print("\n--- MENU ---")
            print("1. Listar alunos")
            print("2. Consultar aluno por CPF")
            print("3. Inserir novo aluno")
            print("4. Deletar aluno")
            print("5. Listar views do banco")
            print("6. Listar triggers do banco")
            print("7. Listar procedures do banco")
            print("8. Mostrar transações/processos ativos")
            print("9. Executar scripts SQL (VIEW, TRIGGER, PROCEDURES)")
            print("0. Sair")

            opcao = input("Escolha uma opção: ")
            if opcao == '1':
                listar_alunos(conn)
            elif opcao == '2':
                consultar_aluno(conn)
            elif opcao == '3':
                inserir_aluno(conn)
            elif opcao == '4':
                deletar_aluno(conn)
            elif opcao == '5':
                listar_views(conn)
            elif opcao == '6':
                listar_triggers(conn)
            elif opcao == '7':
                listar_procedures(conn)
            elif opcao == '8':
                mostrar_transacoes_ativas(conn)
            elif opcao == '9':
                executar_todos_scripts(conn)
            elif opcao == '0':
                break
            else:
                print("Opção inválida.")
        conn.close()
    except mysql.connector.Error as err:
        print(f"Erro ao conectar ao banco de dados: {err}")

if __name__ == '__main__':
    menu()