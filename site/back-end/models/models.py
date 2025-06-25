from flask_login import UserMixin

class Usuario(UserMixin):
    def __init__(self, id, nome_completo, nome_usuario, email, tipo):
        self.id = id
        self.nome_completo = nome_completo
        self.nome_usuario = nome_usuario
        self.email = email
        self.tipo = tipo

    def get_id(self):
        return str(self.id)
