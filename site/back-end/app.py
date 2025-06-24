from flask import Flask, render_template, request, redirect, url_for, flash
from flask_login import LoginManager, login_user, login_required, logout_user, current_user, UserMixin
from werkzeug.security import generate_password_hash, check_password_hash
from database.conexao import conecta_banco
from models.models import Usuario

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

@app.route("/eventos")
def eventos():
    return render_template("eventos.html")

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
