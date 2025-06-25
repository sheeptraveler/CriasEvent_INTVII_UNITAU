from database.conexao import conecta_banco
import base64

class Publicacao:
    def __init__(self, texto, data, nome_usuario, imagem=None):
        self.texto = texto
        self.data = data
        self.nome_usuario = nome_usuario
        self.imagem = imagem

def buscar_publicacoes_recentes():
    conn = conecta_banco()
    cursor = conn.cursor(dictionary=True)

    cursor.execute("""
        SELECT p.texto, p.data, p.imagem, u.nome_usuario
        FROM publicacoes p
        JOIN usuario u ON p.usuario_id = u.id_usuario
        ORDER BY p.data DESC
        LIMIT 10
    """)

    publicacoes = []
    for row in cursor.fetchall():
        imagem_base64 = (
            base64.b64encode(row["imagem"]).decode("utf-8")
            if row["imagem"] else None
        )
        publicacoes.append(Publicacao(
            texto=row["texto"],
            data=row["data"].strftime('%d/%m/%Y %H:%M'),
            nome_usuario=row["nome_usuario"],
            imagem=imagem_base64
        ))

    cursor.close()
    conn.close()
    return publicacoes
