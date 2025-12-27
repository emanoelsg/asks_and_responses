// test/app/domain/entities/answer_model_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/app/domain/entities/answer_model.dart';

void main() {
  group('Respostas Model Test', () {
    final Map<String, dynamic> json = {
      'id': 10,
      'description': 'Minha resposta',
      'perguntaId': 1,
      'createdAt': '2023-05-01',
      'updatedAt': '2023-05-01',
    };

    test('deve converter de JSON para Respostas corretamente', () {
      final model = Respostas.fromJson(json);

      expect(model.id, 10);
      expect(model.description, 'Minha resposta');
      expect(model.perguntaId, 1);
    });

    test('deve converter de Respostas para JSON corretamente', () {
      final model = Respostas.fromJson(json);
      final resultJson = model.toJson();

      expect(resultJson, json);
    });
  });
}
