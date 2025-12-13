// app/view/controllers/cubits/service/question_cubit.dart
import 'package:bloc/bloc.dart';
import '../../../../data/service/connection.dart';
import '../../../../domain/entities/question_model.dart';
import '../../../../domain/entities/question_with_responses_model.dart';
import 'question_state.dart';

class PerguntasCubit extends Cubit<PerguntasState> {
  final PerguntaService _service = PerguntaService();
  List<Pergunta>? _perguntas;
  PerguntasWithRespostas? _perguntaWithRespostas;

  List<Pergunta>? get perguntas => _perguntas;
  PerguntasWithRespostas? get perguntasWithRespostas => _perguntaWithRespostas;

  PerguntasCubit() : super(PerguntasInitial());

  Future<void> fetchQuestions() async {
    emit(PerguntasLoading());
    try {
      final listOfQuestions = await _service.getQuestions();
      _perguntas = listOfQuestions;
      emit(PerguntasLoaded(listOfQuestions));
    } catch (e) {
      emit(PerguntasError('Failed to fetch questions: $e'));
    }
  }

  Future<void> fetchQuestionWithResponses(int questionId) async {
    emit(PerguntasLoading());
    try {
      final questionDetail = await _service.getQuestionsWithResponses(
        questionId,
      );
      _perguntaWithRespostas = questionDetail;
      emit(PerguntasWithRespostasLoaded(questionDetail));
    } catch (e) {
      emit(PerguntasError('Failed to fetch question detail: $e'));
    }
  }

  Future<void> postQuestion({
    required String title,
    required String description,
  }) async {
    try {
      await _service.postQuestion(title: title, description: description);
      final listOfQuestions = await _service.getQuestions();
      _perguntas = listOfQuestions;
      emit(PerguntasLoaded(listOfQuestions));
    } catch (e) {
      emit(PerguntasError('Failed to post question: $e'));
    }
  }

  Future<void> postAnswer({
    required String description,
    required int perguntaId,
  }) async {
    try {
      await _service.postAnswer(
        perguntaId: perguntaId,
        description: description,
      );
      final questionDetail = await _service.getQuestionsWithResponses(
        perguntaId,
      );
      _perguntaWithRespostas = questionDetail;
      emit(PerguntasWithRespostasLoaded(questionDetail));
    } catch (e) {
      emit(PerguntasError('Failed to post answer: $e'));
    }
  }
}
