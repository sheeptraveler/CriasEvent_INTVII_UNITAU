import mysql.connector

def conecta_banco():
    conexao = mysql.connector.connect(
        host="localhost",
        user="root",
        password="",  # coloque sua senha se houver
        database="cadastro"  # seu nome do banco
    )
    return conexao