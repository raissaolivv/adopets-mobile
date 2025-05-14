class CadastroDados {
  String? nome;
  DateTime? dataNasc;
  String? sexo;  
  String? endereco;  
  String? tipoMoradia;
  String? email;
  String? telefone;
  String? login;
  String? senha;

  // ID do usuário (retornado após o cadastro)
  int? usuarioId;

  Map<String, dynamic> toJsonUsuario() {
    return {
      "nome": nome,
      "data_nasc": dataNasc?.toIso8601String(),
      "sexo": sexo,
      "endereco": endereco,
      "tipo_moradia": tipoMoradia,    
      "email": email,
      "telefone": telefone,
      "login": login,
      "senha": senha,
    };
  }

  Map<String, dynamic> toJsonPerfil() {
    return {
      'usuario': {'id': usuarioId}
    };
  }
}



