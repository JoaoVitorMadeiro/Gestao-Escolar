import mysql.connector

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

def menu():
    try:
        conn = conectar_banco()
        while True:
            print("\n--- MENU ---")
            print("1. Listar alunos")
            print("2. Consultar aluno por CPF")
            print("3. Inserir novo aluno")
            print("4. Deletar aluno")
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
            elif opcao == '0':
                break
            else:
                print("Opção inválida.")
        conn.close()
    except mysql.connector.Error as err:
        print(f"Erro ao conectar ao banco de dados: {err}")

if __name__ == '__main__':
    menu()