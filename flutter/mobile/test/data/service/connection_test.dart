import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/data/service/connection.dart';
import 'package:dio/dio.dart';
import 'package:mobile/domain/entities/question_model.dart';
import 'package:mobile/domain/entities/question_with_responses_model.dart';

void main() {
  late PerguntaService service;

  setUp(() {
    service = PerguntaService();
  });

  group('PerguntaService Real API Tests', () {
    test('getPerguntas should fetch and parse real data', () async {
      final perguntas = await service.getPerguntas();
      expect(perguntas, isA<List<Pergunta>>());
      expect(perguntas.isNotEmpty, true);
      for (var pergunta in perguntas) {}
    });

    test(
      'postPergunta should successfully create a new question (expect 201)',
      () async {
        const testTitle = 'Integration Test Question';
        const testDescription =
            'This question was created by the Flutter test.';

        await expectLater(
          service.postPergunta(title: testTitle, description: testDescription),
          completes,
          reason:
              'The POST request should return a 201 status code (Created) and complete.',
        );
      },
    );

    test(
      'getPerguntaWithResponses deve buscar detalhes e respostas de um ID existente',
      () async {
          final result = await service.getPerguntaWithResponses(1);
          print(result);
          expect(result, isA<PerguntasWithRespostas>());
          expect(result.pergunta.id,1);
        
      },
    );

    test(
      'postResposta deve criar uma nova resposta com sucesso (esperado 201)',
      () async {
        const testBody =
            'Esta é uma resposta de teste criada pelo Flutter test.';
        const testQuestionId = 1;

        await expectLater(
          service.postResposta(
            description: testBody,
            perguntaId: testQuestionId,
          ),
          completes,
          reason:
              'A requisição POST para /responder deve retornar 201 e finalizar.',
        );
      },
    );
  });
}
