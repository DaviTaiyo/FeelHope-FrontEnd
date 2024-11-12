class Recomendacao {
  final int? id;
  final String? titulo;
  final String? subtitulo;
  final String? descricao;
  final String? imagem;
  final int? usuarioId;

  Recomendacao({
    this.id,
    this.titulo,
    this.subtitulo,
    this.descricao,
    this.imagem,
    this.usuarioId,
  });

  factory Recomendacao.fromJson(Map<String, dynamic> json) {
    return Recomendacao(
      id: json['id'],
      titulo: json['titulo'],
      subtitulo: json['subtitulo'],
      descricao: json['descricao'],
      imagem: json['imagem'],
      usuarioId: json['Usuario_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'subtitulo': subtitulo,
      'descricao': descricao,
      'imagem': imagem,
      'Usuario_id': usuarioId,
    };
  }
}
