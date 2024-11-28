import 'package:intl/intl.dart';

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
    this.token,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      nome: json['nome'],
      sobrenome: json['sobrenome'],
      email: json['email'],
      dataNascimento: DateTime.tryParse(json['dataNascimento'] ?? ''),
      telefone: json['telefone'],
      cpf: json['cpf'],
      nomeClinica: json['nomeClinica'],
      crm: json['crm'],
      foto: json['foto'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson({bool includeId = false}) {
    final data = <String, dynamic>{
      'nome': nome,
      'sobrenome': sobrenome,
      'email': email,
      'telefone': telefone,
      'cpf': cpf,
      'DataNascimento': dataNascimento != null
          ? DateFormat('yyyy-MM-dd').format(dataNascimento!)
          : null,
      'crm': _formatField(crm),
      'nomeClinica': _formatField(nomeClinica),
      'senha': senha,
      'foto': foto,
    };

    // Só adiciona 'id' se includeId for true e id não for nulo
    if (includeId && id != null) {
      data['id'] = id;
    }
    return data;
  }

  // Função auxiliar para verificar campos vazios ou nulos
  String? _formatField(String? field) {
    if (field == null || field.trim().isEmpty) {
      return null; // Retorna null se o valor for nulo ou vazio
    }
    return field;
  }
}
