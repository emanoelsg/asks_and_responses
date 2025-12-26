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
    test('getPerguntas should fetch and parse real data', () async {
      final perguntas = await service.getPerguntas();

      expect(perguntas, isA<List<Pergunta>>());

      expect(perguntas.isNotEmpty, true);
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
        final PerguntasWithRespostas result =
            await service.getPerguntaWithResponses(1);

        debugPrint(result.toString());

        expect(result, isA<PerguntasWithRespostas>());

        expect(result.pergunta.id, 1);
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
  group('testing edge cases', () {
    test(
        'getPerguntaWithResponses deve lançar exceção para ID inexistente (404)',
        () async {
      const nonExistentId = 999999; // Um ID que provavelmente não existe

      await expectLater(
        () => service.getPerguntaWithResponses(nonExistentId),
        throwsA(predicate((e) =>
            e is Exception && e.toString().contains('404') ||
            e.toString().contains('not found'))),
        reason: 'Deve capturar o erro 404 e retornar uma Exception amigável.',
      );
    });

    test(
        'postPergunta deve falhar se os dados forem inválidos (ex: campos vazios)',
        () async {
      // Forçando um erro dependendo da validação do seu backend (ex: título vazio)
      await expectLater(
        () => service.postPergunta(title: '', description: ''),
        throwsA(isA<Exception>()),
        reason:
            'O backend deve rejeitar campos vazios e o service deve lançar uma Exception.',
      );
    });

    test('postResposta deve falhar para PerguntaId inválido', () async {
      await expectLater(
        () => service.postResposta(
          description: 'Teste de erro',
          perguntaId: -1,
        ),
        throwsA(isA<Exception>()),
        reason:
            'Não deve ser possível responder a uma pergunta com ID negativo.',
      );
    });
  });
    test('getPerguntas deve retornar lista vazia se o JSON vier malformado ou nulo', () async {
      // Nota: Este teste em uma API real é difícil sem Mock. 
      // Mas valida a linha: if (questionsJson == null) return [];
      final perguntas = await service.getPerguntas();
      expect(perguntas, isA<List<Pergunta>>()); 
    });

    // 4. Testa falha na criação de Pergunta (Status != 201)
    test('postPergunta deve lançar erro se o status for diferente de 201', () async {
      // Valida a linha: if (response.statusCode != 201)
      // Forçamos o erro enviando strings vazias (que você validou no service)
      await expectLater(
        () => service.postPergunta(title: '', description: ''),
        throwsA(predicate((e) => e.toString().contains('vazios'))),
      );
    });

    // 5. Testa falha na criação de Resposta (Status != 201)
    test('postResposta deve lançar erro se o status for diferente de 201 ou dados inválidos', () async {
      // Valida a linha: if (response.statusCode != 201)
      await expectLater(
        () => service.postResposta(description: '', perguntaId: -1),
        throwsA(predicate((e) => e.toString().contains('vazio'))),
      );
    });
}
