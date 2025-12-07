import 'answer_model.dart';
import 'question_model.dart';

class PerguntasWithRespostas {
  Pergunta? pergunta;
  List<Respostas>? respostas;

  PerguntasWithRespostas({this.pergunta, this.respostas});

  PerguntasWithRespostas.fromJson(Map<String, dynamic> json) {
    pergunta = json['pergunta'] != null
        ? Pergunta.fromJson(json['pergunta'])
        : null;
    if (json['respostas'] != null) {
      respostas = <Respostas>[];
      json['respostas'].forEach((v) {
        respostas!.add(Respostas.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (pergunta != null) {
      data['pergunta'] = pergunta!.toJson();
    }
    if (respostas != null) {
      data['respostas'] = respostas!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}