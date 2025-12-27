// test/view/controllers/cubits/service/question_cubit_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/app/view/controllers/cubits/details/details_cubit.dart';
import 'package:mobile/app/view/controllers/cubits/details/details_states.dart';





void main() {
  late DetailsCubit cubit;

  setUp(() {

    cubit = DetailsCubit();
  });
  group('testing controller functions', () {

  
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
}