class Usuario {
  //final String token;
  final int? id;
  final String? nome;
  final String? sobrenome;
  final String? email;
  final DateTime? dataNascimento;
  final String? telefone;
  final String? cpf;
  final String? nomeClinica;
  final String? crm;
  final String? foto;
  final String? senha;

  Usuario({
    //required this.token,
    this.id,
    this.nome,
    this.sobrenome,
    this.email,
    this.dataNascimento,
    this.telefone,
    this.cpf,
    this.nomeClinica,
    this.crm,
    this.foto,
    this.senha,
  });
}
