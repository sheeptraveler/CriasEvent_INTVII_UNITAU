import base64
from database.conexao import conecta_banco

class Evento:
    def __init__(self, id, nome, organizador_id, descricao, data, local, status, imagem=None):
        self.id = id
        self.nome = nome
        self.organizador_id = organizador_id
        self.descricao = descricao
        self.data = data
        self.local = local
        self.status = status
        self.imagem = imagem

    def salvar(self):
        conn = conecta_banco()
        cursor = conn.cursor()
        sql = """
            INSERT INTO evento (evento_nome, evento_organizador_id, evento_descricao, evento_data, evento_local, evento_status, evento_imagem)
            VALUES (%s, %s, %s, %s, %s, %s, %s)
        """
        cursor.execute(sql, (self.nome, self.organizador_id, self.descricao, self.data, self.local, self.status, self.imagem))
        conn.commit()
        conn.close()

def buscar_evento_por_id(evento_id):
    conn = conecta_banco()
    cursor = conn.cursor(dictionary=True)
    try:
        cursor.execute("""
            SELECT e.evento_id, e.evento_nome, e.evento_organizador_id, e.evento_descricao,
                   e.evento_data, e.evento_local, e.evento_status, e.evento_imagem,
                   u.nome_usuario AS organizador_nome
            FROM evento e
            JOIN usuario u ON e.evento_organizador_id = u.id_usuario
            WHERE e.evento_id = %s
        """, (evento_id,))
        linha = cursor.fetchone()
        if not linha:
            return None

        imagem_base64 = (
            base64.b64encode(linha['evento_imagem']).decode('utf-8')
            if linha['evento_imagem'] else None
        )

        return Evento(
            id=linha['evento_id'],
            nome=linha['evento_nome'],
            organizador_id=linha['organizador_nome'],
            descricao=linha['evento_descricao'],
            data=linha['evento_data'],
            local=linha['evento_local'],
            status=linha['evento_status'],
            imagem=imagem_base64
        )
    finally:
        cursor.close()
        conn.close()

