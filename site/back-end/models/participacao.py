from email.mime.text import MIMEText
import smtplib
from email.message import EmailMessage
from database.conexao import conecta_banco

class Participacao:
    def __init__(self, id_usuario, id_evento):
        self.id_usuario = id_usuario
        self.id_evento = id_evento

    def salvar(self):
        conn = conecta_banco()
        cursor = conn.cursor()
        try:
            cursor.execute("""
                INSERT INTO participacao (id_usuario, id_evento)
                VALUES (%s, %s)
            """, (self.id_usuario, self.id_evento))
            conn.commit()
        except Exception as e:
            print("Erro ao inserir participação:", e)
        finally:
            conn.close()


def enviar_email_participacao(nome_usuario,destinatario, evento_id):
    remetente = 'criasevent@gmail.com'
    senha = 'sczu yvbd opry pkxp'

    assunto = 'Confirmação de Inscrição - CriasEvent'
    corpo = f"""
    Olá {nome_usuario} !

    Sua inscrição no evento ID: #{evento_id} foi recebida com sucesso.

    Agradecemos sua participação!
    """

    msg = MIMEText(corpo)
    msg['Subject'] = assunto
    msg['From'] = remetente
    msg['To'] = destinatario

    try:
        with smtplib.SMTP_SSL('smtp.gmail.com', 465) as server:
            server.login(remetente, senha)
            server.send_message(msg)
        print("E-mail enviado com sucesso")
    except Exception as e:
        print("Erro ao enviar e-mail:", e)

