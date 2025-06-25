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

def buscar_eventos():
    conn = conecta_banco()
    cursor = conn.cursor(dictionary=True)
    try:
        cursor.execute("""
            SELECT evento_id, evento_nome
            FROM evento
            WHERE evento_status = 'ativo'
            ORDER BY evento_data DESC
        """)
        return cursor.fetchall()
    finally:
        cursor.close()
        conn.close()


