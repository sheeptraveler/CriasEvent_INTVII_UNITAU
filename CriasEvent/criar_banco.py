import sqlite3
import os

# Pega o diretório atual do criar_banco.py (que está dentro de 'back-end')
BASE_DIR = os.path.abspath(os.path.dirname(__file__))

# Define o caminho para o diretório do banco de dados dentro de 'back-end'
DB_DIR = os.path.join(BASE_DIR, 'database')
DB_PATH = os.path.join(DB_DIR, 'banco.sqlite')

# Garante que o diretório 'database' exista dentro de 'back-end'
if not os.path.exists(DB_DIR):
    os.makedirs(DB_DIR)

conn = sqlite3.connect(DB_PATH)
cursor = conn.cursor()

cursor.execute("""
CREATE TABLE IF NOT EXISTS usuarios (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome_completo TEXT NOT NULL,
    nome_usuario TEXT NOT NULL UNIQUE,
    data_nascimento TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    senha TEXT NOT NULL
);
""")

conn.commit()
conn.close()

print(f"Banco de dados criado ou já existente em: {DB_PATH}")