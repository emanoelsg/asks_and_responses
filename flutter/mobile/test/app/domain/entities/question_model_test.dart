
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/app/domain/entities/question_model.dart';

void main() {
  group('Pergunta Model Test', () {
    final Map<String, dynamic> json = {
      'id': 1,
      'title': 'Flutter Test',
      'description': 'Description text',
      'createdAt': '2023-01-01',
      'updatedAt': '2023-01-02',
    };

    test('deve converter de JSON para Pergunta corretamente', () {
      final model = Pergunta.fromJson(json);

      expect(model.id, 1);
      expect(model.title, 'Flutter Test');
      expect(model.description, 'Description text');
    });

    test('deve converter de Pergunta para JSON corretamente', () {
      final model = Pergunta.fromJson(json);
      final resultJson = model.toJson();

      expect(resultJson, json);
    });
  });

 
}
