import mysql.connector
from mysql.connector import Error

def connect_to_database():
    try:
        connection = mysql.connector.connect(
            host='localhost',
            database='escola',
            user='root',
            password=''
        )
        return connection
    except Error as e:
        print(f"Erro ao conectar ao banco de dados: {e}")
        return None

def cadastrar_disciplina(nome, sigla, aulas_semanais, aulas_totais_semestre, carga_horaria, ementa):
    try:
        connection = connect_to_database()
        if connection is None:
            return "Não foi possível conectar ao banco de dados."

        cursor = connection.cursor()
        sql = """
        INSERT INTO disciplinas (nome, sigla, aulas_semanais, aulas_totais_semestre, carga_horaria, ementa)
        VALUES (%s, %s, %s, %s, %s, %s)
        """
        dados = (nome, sigla, aulas_semanais, aulas_totais_semestre, carga_horaria, ementa)
        
        cursor.execute(sql, dados)
        connection.commit()
        
        return "Disciplina cadastrada com sucesso!"
    except Error as e:
        return f"Erro '{e}' ocorreu ao cadastrar disciplina"
    finally:
        if connection and connection.is_connected():
            cursor.close()
            connection.close()
            

def editar_disciplina(id_disciplina, nome, sigla, aulas_semanais, aulas_totais_semestre, carga_horaria, ementa):
    try:
        connection = connect_to_database()
        if connection is None:
            return "Não foi possível conectar ao banco de dados."

        cursor = connection.cursor()
        sql = """
        UPDATE disciplinas
        SET nome = %s, sigla = %s, aulas_semanais = %s, aulas_totais_semestre = %s, carga_horaria = %s, ementa = %s
        WHERE id = %s
        """
        dados = (nome, sigla, aulas_semanais, aulas_totais_semestre, carga_horaria, ementa, id_disciplina)
        
        cursor.execute(sql, dados)
        connection.commit()
        
        return "Disciplina atualizada com sucesso!"
    except Error as e:
        return f"Erro '{e}' ocorreu ao atualizar disciplina"
    finally:
        if connection and connection.is_connected():
            cursor.close()
            connection.close()