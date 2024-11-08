import 'package:feelhope/domain/entities/user.dart';
import 'package:intl/intl.dart';

class UsuarioModel extends Usuario {
  UsuarioModel({
    String? email,
    //required String token,
    int? id,
    String? nome,
    String? sobrenome,
    DateTime? dataNascimento,
    String? telefone,
    String? cpf,
    String? nomeClinica,
    String? crm,
    String? foto,
    String? senha,
  }) : super(
          email: email,
          //token: token,
          nome: nome,
          sobrenome: sobrenome,
          dataNascimento: dataNascimento,
          telefone: telefone,
          cpf: cpf,
          nomeClinica: nomeClinica,
          crm: crm,
          foto: foto,
          senha: senha,
        );

  factory UsuarioModel.fromJson(Map<String, dynamic> json) {
    return UsuarioModel(
      email: json['email'],
      //token: json['token'],
      nome: json["nome"],
      sobrenome: json["sobrenome"],
      dataNascimento: json["dataNascimento"] != null
          ? DateTime.parse(json["dataNascimento"])
          : null,
      telefone: json["telefone"],
      cpf: json["cpf"],
      nomeClinica: json["nomeClinica"],
      crm: json["crm"],
      foto: json["foto"],
      senha: json["senha"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      //'token': token,
      'nome': nome,
      'sobrenome': sobrenome,
      'dataNascimento': dataNascimento != null
          ? DateFormat('yyyy-MM-dd').format(dataNascimento!) // Converte para string
          : null,
      'telefone': telefone,
      'cpf': cpf,
      'nomeClinica': nomeClinica,
      'crm': crm,
      'foto': foto,
      'senha': senha,
    };
  }
}
