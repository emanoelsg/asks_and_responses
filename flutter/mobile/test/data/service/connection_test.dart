// test/data/service/connection_test.dart
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/app/data/service/connection.dart';
import 'package:mobile/app/domain/entities/question_model.dart';
import 'package:mobile/app/domain/entities/question_with_responses_model.dart';

void main() {
  late PerguntaService service;

  setUp(() {
    service = PerguntaService();
  });

  group('PerguntaService Real API Tests', () {
    test('getQuestions should fetch and parse real data', () async {
      final perguntas = await service.getQuestions();
      expect(perguntas, isA<List<Pergunta>>());
      expect(perguntas.isNotEmpty, true);
    });

    test(
      'postQuestion should successfully create a new question (expect 201)',
      () async {
        const testTitle = 'Integration Test Question';
        const testDescription =
            'This question was created by the Flutter test.';

        await expectLater(
          service.postQuestion(title: testTitle, description: testDescription),
          completes,
          reason:
              'The POST request should return a 201 status code (Created) and complete.',
        );
      },
    );

    test(
      'getPerguntaWithResponses deve buscar detalhes e respostas de um ID existente',
      () async {
          final PerguntasWithRespostas result = await service.getQuestionsWithResponses(1);
          debugPrint(result.toString());
          expect(result, isA<PerguntasWithRespostas>());
          expect(result.pergunta.id,1);
        
      },
    );

    test(
      'postAnswer deve criar uma nova resposta com sucesso (esperado 201)',
      () async {
        const testBody =
            'Esta é uma resposta de teste criada pelo Flutter test.';
        const testQuestionId = 1;

        await expectLater(
          service.postAnswer(
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
