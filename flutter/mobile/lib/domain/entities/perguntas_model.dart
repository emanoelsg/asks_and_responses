// domain/entities/perguntas_model.dart

import 'respostas_model.dart';


class PerguntasModel {
  final int id;
  final String title;
  final String description;
  final List<Resposta> answers; 

  PerguntasModel({
    required this.id,
    required this.title,
    required this.description,
    required this.answers,
  });

  factory PerguntasModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> answersJson = json['answers'] ?? [];
    final List<Resposta> answers = answersJson
        .map((e) => Resposta.fromJson(e as Map<String, dynamic>))
        .toList();

    return PerguntasModel(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      answers: answers,
    );
  }
}
