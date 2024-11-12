class Relatorio {
  final int? id;
  final String? sentimentos;
  final int? nivel;
  final String? descricaoRelatorio;
  final String? audio;
  final int? sentimentosId;
  final int? usuarioId;

  Relatorio({
    this.id,
    this.sentimentos,
    this.nivel,
    this.descricaoRelatorio,
    this.audio,
    this.sentimentosId,
    this.usuarioId,
  });

  factory Relatorio.fromJson(Map<String, dynamic> json) {
    return Relatorio(
      id: json['id'],
      sentimentos: json['sentimentos'],
      nivel: json['nivel'],
      descricaoRelatorio: json['descricao_relatorio'],
      audio: json['audio'],
      sentimentosId: json['sentimentos_id'],
      usuarioId: json['Usuario_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sentimentos': sentimentos,
      'nivel': nivel,
      'descricao_relatorio': descricaoRelatorio,
      'audio': audio,
      'sentimentos_id': sentimentosId,
      'Usuario_id': usuarioId,
    };
  }
}
