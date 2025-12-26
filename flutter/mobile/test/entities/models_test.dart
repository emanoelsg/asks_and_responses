
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/app/domain/entities/question_model.dart';
import 'package:mobile/app/domain/entities/answer_model.dart';
import 'package:mobile/app/domain/entities/question_with_responses_model.dart';

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

  group('PerguntasWithRespostas Model Test', () {
    final Map<String, dynamic> jsonComplex = {
      'pergunta': {
        'id': 1,
        'title': 'Pergunta Pai',
        'description': 'Desc',
      },
      'respostas': [
        {
          'id': 100,
          'description': 'Resposta 1',
          'perguntaId': 1,
        },
        {
          'id': 101,
          'description': 'Resposta 2',
          'perguntaId': 1,
        }
      ]
    };

    test('deve converter JSON complexo para PerguntasWithRespostas corretamente', () {
      final model = PerguntasWithRespostas.fromJson(jsonComplex);

      expect(model.pergunta.id, 1);
      expect(model.respostas?.length, 2);
      expect(model.respostas?[0].description, 'Resposta 1');
      expect(model.respostas?[1].id, 101);
    });

    test('deve lidar com lista de respostas nula sem quebrar', () {
      final jsonSemRespostas = {
        'pergunta': {'id': 1, 'title': 'T'},
        'respostas': null
      };

      final model = PerguntasWithRespostas.fromJson(jsonSemRespostas);

      expect(model.pergunta.id, 1);
      expect(model.respostas, isNull);
    });

    test('deve falhar se a chave pergunta estiver faltando (pela regra do ! no código)', () {
      final jsonInvalido = {'respostas': []};

      expect(
        () => PerguntasWithRespostas.fromJson(jsonInvalido),
        throwsA(isA<TypeError>()),
      );
    });
  });
}
