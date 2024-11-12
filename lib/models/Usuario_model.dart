class Usuario {
  final int? id;
  final String? nome;
  final String? sobrenome;
  final String? email;
  final DateTime? dataNascimento;
  final String? telefone;
  final String? cpf;
  final String? nomeClinica;
  final String? crm;
  final String? senha;
  final String? foto;
  final String? token;

  Usuario({
    this.id,
    this.nome,
    this.sobrenome,
    this.email,
    this.dataNascimento,
    this.telefone,
    this.cpf,
    this.nomeClinica,
    this.crm,
    this.senha,
    this.foto,
    this.token
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      nome: json['nome'],
      sobrenome: json['sobrenome'],
      email: json['email'],
      dataNascimento: DateTime.tryParse(json['data_nascimento'] ?? ''),
      telefone: json['telefone'],
      cpf: json['cpf'],
      nomeClinica: json['nome_clinica'],
      crm: json['crm'],
      foto: json['foto'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic> {
      'nome': nome,
      'sobrenome': sobrenome,
      'email': email,
      'data_nascimento': dataNascimento?.toIso8601String(),
      'telefone': telefone,
      'cpf': cpf,
      'nome_clinica': nomeClinica,
      'crm': crm,
      'senha': senha,
      'foto': foto,
    };
    if (id != null) {
      data['id'] = id;
    }
    return data;
  }
}
