class Sentimento {
  final int? id;
  final String? titulo;
  final int? nivel;
  final String? descricao;
  final int? numero;
  final int? usuarioId;

  Sentimento({
    this.id,
    this.titulo,
    this.nivel,
    this.descricao,
    this.numero,
    this.usuarioId,
  });

  factory Sentimento.fromJson(Map<String, dynamic> json) {
    return Sentimento(
      id: json['id'],
      titulo: json['titulo'],
      nivel: json['nivel'],
      descricao: json['descricao'],
      numero: json['numero'],
      usuarioId: json['Usuario_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'nivel': nivel,
      'descricao': descricao,
      'numero': numero,
      'Usuario_id': usuarioId,
    };
  }
}
