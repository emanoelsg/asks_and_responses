// test/view/controllers/cubits/service/question_cubit_test.dart
import 'package:flutter_test/flutter_test.dart';

import 'package:mobile/app/view/controllers/cubits/service/question_cubit.dart';
import 'package:mobile/app/view/controllers/cubits/service/question_state.dart';


void main() {
  late PerguntasCubit controller;


  setUp(() {
    controller = PerguntasCubit();
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

        await controller.fetchQuestionWithResponses(testQuestionId);

        expect(controller.state, isA<PerguntasWithRespostasLoaded>());
        expect(controller.perguntasWithRespostas, isNotNull);
        expect(
          controller.perguntasWithRespostas!.pergunta.id,
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
          controller.perguntas!
              .any((q) => q.title == testTitle && q.description == testDescription),
          true,
        );
      },
    );


    test(
      'postAnswer should add a new answer and update state to PerguntasWithRespostasLoaded',
      () async {
        const testBody = 'This is a test answer from the Cubit test.';
        const testQuestionId = 1;

        await controller.postAnswer(
          description: testBody,
          perguntaId: testQuestionId,
        );

        expect(controller.state, isA<PerguntasWithRespostasLoaded>());
        expect(controller.perguntasWithRespostas, isNotNull);
        expect(
          controller.perguntasWithRespostas!.respostas
              ?.any((a) => a.description == testBody),
          true,
        );
      },
    );
  }); 
}