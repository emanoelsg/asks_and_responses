
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/app/domain/entities/question_with_responses_model.dart';

void main() {

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
