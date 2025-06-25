from flask import Flask, render_template, request, redirect, url_for, flash, jsonify
from flask_login import LoginManager, login_user, login_required, logout_user, current_user, UserMixin
from werkzeug.security import generate_password_hash, check_password_hash
from database.conexao import conecta_banco
from models.models import Usuario
from models.evento import Evento , buscar_evento_por_id
from models.participacao import Participacao, enviar_email_participacao
import base64

app = Flask(__name__)
app.secret_key = "Xupeta"  # (Deixe uma chave mais segura depois)

# Configuração do Flask-Login
lm = LoginManager(app)
lm.login_view = 'mostrar_formulario_login'  # Nome da função da rota de login
lm.login_message = "Você precisa estar logado para acessar esta página."

# Carregar usuário pelo ID
@lm.user_loader
def user_loader(user_id):
    conn = conecta_banco()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM usuario WHERE id_usuario = %s", (user_id,))
    usuario = cursor.fetchone()
    cursor.close()
    conn.close()

    if usuario:
        return Usuario(
            id=usuario["id_usuario"],
            nome_completo=usuario["nome_completo"],
            nome_usuario=usuario["nome_usuario"],
            email=usuario["email_usuario"],
            tipo=usuario["tipo"]
        )
    return None

# ----------------- Rotas -----------------

@app.route("/")
def index():
    return render_template("index.html")



from flask import render_template, redirect, url_for, flash
from flask_login import login_required, current_user


@app.route('/cadastro_evento',methods = ["GET"])
@login_required
def mostrar_formulario_cadastro_evento():
    if current_user.tipo != 'organizador':
        flash('Acesso negado! Esta página é exclusiva para organizadores.', 'error_cadastro')
        return redirect(url_for('index'))
    return render_template('cadastro_evento.html')

@app.route('/cadastro_evento',methods = ["POST"])
@login_required
def cadastro_evento():
    if current_user.tipo == 'organizador':
        try:
            nome = request.form['evento_nome']
            descricao = request.form['evento_descricao']
            data = request.form['evento_data']
            local = request.form['evento_local']
            status = "Ativo"  
            organizador_id = current_user.id  

            
            imagem_file = request.files['evento_imagem']
            imagem_blob = imagem_file.read() if imagem_file else None

            conn = conecta_banco()
            cursor = conn.cursor()

            sql = """
                INSERT INTO evento (
                    evento_nome,
                    evento_organizador_id,
                    evento_descricao,
                    evento_imagem,
                    evento_data,
                    evento_local,
                    evento_status
                ) VALUES (%s, %s, %s, %s, %s, %s, %s)
            """
            cursor.execute(sql, (
                nome,
                organizador_id,
                descricao,
                imagem_blob,
                data,
                local,
                status
            ))

            conn.commit()
            cursor.close()
            conn.close()

            flash("Evento cadastrado com sucesso!", "success")
            return redirect(url_for('eventos'))

        except Exception as e:
            flash(f"Erro ao cadastrar evento: {str(e)}", "error")
            #print("Ta dando Exception no cadastro evento")
            print("Erro :", e) 
            return redirect(url_for('cadastro_evento'))

    else:
        flash("Conta não autorizada a realizar o processo","erro_cadastro")
        return render_template('index.html')



@app.route("/cadastro", methods=["GET"])
def mostrar_formulario_cadastro():
    return render_template("cadastro.html")

@app.route("/cadastro", methods=["POST"])
def cadastro():
    nome_completo = request.form.get("nome")
    nome_usuario = request.form.get("usuario")
    data_nascimento = request.form.get("data-nascimento")
    email = request.form.get("email")
    senha = request.form.get("senha")
    confirmar_senha = request.form.get("confirmar-senha")
    tipo = request.form.get("tipo")
    termos = request.form.get("termos")

    if not all([nome_completo, nome_usuario, data_nascimento, email, senha, confirmar_senha, tipo, termos]):
        flash("Por favor, preencha todos os campos e aceite os termos.", "error")
        return redirect(url_for("mostrar_formulario_cadastro"))

    if senha != confirmar_senha:
        flash("As senhas não coincidem.", "error")
        return redirect(url_for("mostrar_formulario_cadastro"))

    senha_hash = generate_password_hash(senha)

    conn = conecta_banco()
    cursor = conn.cursor(dictionary=True)

    try:
        cursor.execute("""
            INSERT INTO usuario (
                nome_completo, nome_usuario, data_nascimento, email_usuario, senha, tipo
            ) VALUES (%s, %s, %s, %s, %s, %s)
        """, (nome_completo, nome_usuario, data_nascimento, email, senha_hash, tipo))
        conn.commit()
        flash("Usuário cadastrado com sucesso!", "success")
        
        # Obtém o ID do novo usuário
        novo_usuario_id = cursor.lastrowid
        
        novo_usuario = Usuario(
            id=novo_usuario_id,
            nome_completo=nome_completo,
            nome_usuario=nome_usuario,
            email=email,
            tipo=tipo
        )
        login_user(novo_usuario)
        return redirect(url_for("index"))
    except Exception as e:
        print(f"Erro: {e}")
        flash("Usuário ou email já cadastrado.", "error")
        return redirect(url_for("mostrar_formulario_cadastro"))
    finally:
        cursor.close()
        conn.close()

@app.route("/login", methods=["GET"])
def mostrar_formulario_login():
    return render_template("login.html")

@app.route("/login", methods=["POST"])
def login():
    email = request.form.get("email")
    senha = request.form.get("senha")

    if not all([email, senha]):
        flash("Por favor, preencha todos os campos.", "error")
        return redirect(url_for("mostrar_formulario_login"))

    conn = conecta_banco()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM usuario WHERE email_usuario = %s", (email,))
    usuario = cursor.fetchone()
    cursor.close()
    conn.close()

    print("Usuário encontrado:", usuario)  # Debug: Verifica o usuário encontrado

    if usuario:
        print("Hash armazenado:", usuario["senha"])  # Debug: Mostra o hash da senha no banco
        print("Senha fornecida:", senha)  # Debug: Mostra a senha que o usuário digitou
        is_password_correct = check_password_hash(usuario["senha"], senha)
        print("Resultado da comparação:", is_password_correct)  # Debug: Verifica o resultado da comparação

        if is_password_correct:
            user = Usuario(
                id=usuario["id_usuario"],
                nome_completo=usuario["nome_completo"],
                nome_usuario=usuario["nome_usuario"],
                email=usuario["email_usuario"],
                tipo=usuario["tipo"]
            )
            login_user(user)
            flash("Login realizado com sucesso!", "success")
            return redirect(url_for("index"))  # Redireciona para a página anterior ou para a index
        else:
            flash("E-mail ou senha incorretos.", "error")
            return redirect(url_for("eventos"))
    else:
        flash("E-mail ou senha incorretos.", "error")
        return redirect(url_for("eventos"))

@app.route("/logout")
@login_required
def logout():
    logout_user()
    flash("Você saiu da sua conta.", "info")
    return redirect(url_for("index"))


@app.route('/eventos')
def eventos():
    termo_busca = request.args.get("q", "").strip()
    
    conn = conecta_banco()
    cursor = conn.cursor(dictionary=True)
    try:
        if termo_busca:
            query = """
                SELECT e.evento_id, e.evento_nome, e.evento_organizador_id, e.evento_descricao,
                       e.evento_data, e.evento_local, e.evento_status, e.evento_imagem,
                       u.nome_usuario AS organizador_nome
                FROM evento e
                JOIN usuario u ON e.evento_organizador_id = u.id_usuario
                WHERE e.evento_nome LIKE %s
                ORDER BY e.evento_data ASC;
            """
            cursor.execute(query, (f"%{termo_busca}%",))
        else:
            cursor.execute("""
                SELECT e.evento_id, e.evento_nome, e.evento_organizador_id, e.evento_descricao,
                       e.evento_data, e.evento_local, e.evento_status, e.evento_imagem,
                       u.nome_usuario AS organizador_nome
                FROM evento e
                JOIN usuario u ON e.evento_organizador_id = u.id_usuario
                ORDER BY e.evento_data ASC;
            """)
        
        resultados = cursor.fetchall()

        eventos = []
        for linha in resultados:
            imagem_base64 = (
                base64.b64encode(linha['evento_imagem']).decode('utf-8')
                if linha['evento_imagem'] else None
            )
            evento = Evento(
                id=linha['evento_id'],
                nome=linha['evento_nome'],
                organizador_id=linha['organizador_nome'], 
                descricao=linha['evento_descricao'],
                data=linha['evento_data'],
                local=linha['evento_local'],
                status=linha['evento_status'],
                imagem=imagem_base64
            )
            eventos.append(evento)

        return render_template('eventos.html', eventos=eventos)
    finally:
        cursor.close()
        conn.close()


@app.route('/inscrever', methods=['POST'])
@login_required
def inscrever():
    data = request.get_json()
    evento_id = data.get('evento_id')
    user_id = current_user.id  # Pega o usuário logado

    if not evento_id:
        return jsonify({'sucesso': False, 'mensagem': 'ID do evento é obrigatório'})

    # Checar se já está inscrito (opcional)
    conn = conecta_banco()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM participation WHERE usuario_id = %s AND evento_id = %s", (user_id, evento_id))
    if cursor.fetchone():
        cursor.close()
        conn.close()
        return jsonify({'sucesso': False, 'mensagem': 'Você já está inscrito neste evento.'})

    # Insere a participação
    try:
        cursor.execute("INSERT INTO participation (usuario_id, evento_id) VALUES (%s, %s)", (user_id, evento_id))
        conn.commit()
    except Exception as e:
        cursor.close()
        conn.close()
        return jsonify({'sucesso': False, 'mensagem': 'Erro ao inscrever: ' + str(e)})
    
    try:
        enviar_email_participacao(current_user.nome_usuario, current_user.email, evento_id)
    except Exception as e:
        # Aqui só loga o erro, mas não interrompe o fluxo da inscrição
        print("Erro ao enviar e-mail:", e)

    cursor.close()
    conn.close()

    # Opcional: enviar e-mail de confirmação aqui, se quiser

    return jsonify({'sucesso': True, 'mensagem': 'Inscrição realizada com sucesso.'})



@app.route("/midia")
def midia():
    return render_template("midia.html")

@app.route("/sobre")
def sobre():
    return render_template("sobre.html")

# ----------------- Testes -----------------

@app.route("/teste")
def teste():
    conn = conecta_banco()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM usuario")
    usuarios = cursor.fetchall()
    cursor.close()
    conn.close()
    return str(usuarios)

@app.route("/perfil")
@login_required
def perfil():
    if current_user.is_authenticated:
        return f"Usuário logado: {current_user.nome_usuario}"
    else:
        return "Usuário não está logado"

if __name__ == "__main__":
    app.run(debug=True, host="127.0.0.1", port=3000)
