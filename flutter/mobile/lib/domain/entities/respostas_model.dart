// domain/entities/respostas_model.dart
class Resposta {
  final int id;
  final String body; // Renomeado de 'corpo' para 'body' para seguir o padrão REST/JSON
  final int perguntaId;

  Resposta({
    required this.id,
    required this.body,
    required this.perguntaId,
  });

  factory Resposta.fromJson(Map<String, dynamic> json) {
    return Resposta(
      id: json['id'] as int,
      body: json['description'] as String, // Assumindo que sua API Node.js usa 'description'
      perguntaId: json['perguntaId'] as int,
    );
  }
}