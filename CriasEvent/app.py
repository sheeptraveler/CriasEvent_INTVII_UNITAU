from flask import Flask, render_template, request, redirect, url_for, flash
import mysql.connector 
import os

BASE_DIR = os.path.abspath(__file__) 
TEMPLATE_FOLDER = os.path.join(BASE_DIR, '..')
STATIC_FOLDER = os.path.join(BASE_DIR, '..', 'static')
DATABASE_PATH = os.path.join(BASE_DIR, 'database')

app = Flask(__name__)

db_config = {
    'host': '127.0.0.1',
    'port': 3306,
    'user': 'root',
    'password': '123',
    'database': 'criasEvent'
}

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/<URL_Address>.html')
def template(URL_Address):
    if URL_Address == 'login':
        return render_template('login.html', FlagCadastroRealizado = "")
    return render_template(URL_Address + '.html')

@app.route('/cadastro', methods=['POST'])
def cadastro():
    try:
        nome = request.form['nome']
        usuario = request.form['usuário']
        data_nascimento = request.form['data-nascimento']
        email = request.form['email']
        senha = request.form['senha']
        
        connection = mysql.connector.connect(**db_config)
        cursor = connection.cursor()
        
        query = "INSERT INTO Usuario(NomeUsuario, NickUsuario, EmailUsuario, DataNascimento, SenhaUsuario) VALUES (%s, %s, %s, %s, %s)"
        values = (nome, usuario, email, data_nascimento, senha)
        
        cursor.execute(query, values)
        connection.commit()

        return render_template('login.html', FlagCadastroRealizado = "Cadastro realizado com sucesso. " ) 
    except mysql.connector.Error as err:
        return (f'Erro ao cadastrar: {err}', 'danger')
    finally:
        if cursor:
            cursor.close()
        if connection:
            connection.close()


if __name__ == '__main__':
    app.run(debug=True)
