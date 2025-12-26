// test/view/controllers/cubits/service/question_cubit_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/app/view/controllers/cubits/details/details_cubit.dart';
import 'package:mobile/app/view/controllers/cubits/details/details_states.dart';
import 'package:mobile/app/view/controllers/cubits/service/question_cubit.dart';
import 'package:mobile/app/view/controllers/cubits/service/question_state.dart';

void main() {
  late PerguntasCubit controller;
  late DetailsCubit cubit;

  setUp(() {
    controller = PerguntasCubit();
    cubit = DetailsCubit();
  });
  group('testing controller functions', () {
    test('fetchQuestions should update state to PerguntasLoaded', () async {
      await controller.fetchQuestions();
      expect(controller.state, isA<PerguntasLoaded>());
      expect(controller.perguntas, isNotNull);
    });

    test(
      'fetchQuestionWithResponses should update state to PerguntasWithRespostasLoaded',
      () async {
        const testQuestionId = 1;

        await cubit.fetchQuestionWithResponses(testQuestionId);

        expect(cubit.state, isA<DetailsLoaded>());
        expect(cubit.perguntasWithRespostas, isNotNull);
        expect(
          cubit.perguntasWithRespostas!.pergunta.id,
          testQuestionId,
        );
      },
    );
    test(
      'postQuestion should add a new question and update state to PerguntasLoaded',
      () async {
        const testTitle = 'Test Question from Cubit';
        const testDescription =
            'This question was created by the PerguntasCubit test.';

        await controller.postQuestion(
          title: testTitle,
          description: testDescription,
        );

        expect(controller.state, isA<PerguntasLoaded>());
        expect(controller.perguntas, isNotNull);
        expect(
          controller.perguntas!.any(
              (q) => q.title == testTitle && q.description == testDescription),
          true,
        );
      },
    );

    test(
      'postAnswer should add a new answer and update state to PerguntasWithRespostasLoaded',
      () async {
        const testBody = 'This is a test answer from the Cubit test.';
        const testQuestionId = 1;

        await cubit.postAnswer(
          description: testBody,
          perguntaId: testQuestionId,
        );

        expect(cubit.state, isA<DetailsLoaded>());
        expect(cubit.perguntasWithRespostas, isNotNull);
        expect(
          cubit.perguntasWithRespostas!.respostas
              ?.any((a) => a.description == testBody),
          true,
        );
      },
    );
  });

  group('testing error handling', () {
    test(
        'fetchQuestionWithResponses deve emitir DetailsError para ID inexistente',
        () async {
      const invalidId = 999999;

      await cubit.fetchQuestionWithResponses(invalidId);

      expect(cubit.state, isA<DetailsError>());
      final state = cubit.state as DetailsError;
      expect(state.message, contains('Failed to fetch question detail'));
    });

    test(
        'postAnswer deve emitir DetailsError ao enviar resposta vazia ou ID inválido',
        () async {
      await cubit.postAnswer(
        description: '', // Descrição vazia
        perguntaId: -1, // ID negativo
      );

      expect(cubit.state, isA<DetailsError>());
      final state = cubit.state as DetailsError;
      expect(state.message, contains('Failed to post answer'));
      expect(state.message, contains('vazio'));
    });

    test('postQuestions deve emitir erro em caso de parametros invalidos', () {
      controller.postQuestion(title: '', description: '').then((_) {
        expect(controller.state, isA<PerguntasError>());
        final state = controller.state as PerguntasError;
        expect(state.message, contains('Failed to post question'));
      });
    });
  });
}
