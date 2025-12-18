import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/app/data/service/connection.dart';
import 'package:mobile/app/domain/entities/question_with_responses_model.dart';
import 'package:mobile/app/view/controllers/cubits/details/details_states.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit() : super(DetailsInitial(null));
  final PerguntaService _service = PerguntaService();
  PerguntasWithRespostas? _perguntaWithRespostas;
  PerguntasWithRespostas? get perguntasWithRespostas => _perguntaWithRespostas;

  Future<void> fetchQuestionWithResponses(int questionId) async {
    emit(DetailsLoading());
    try {
      final questionDetail = await _service.getQuestionsWithResponses(
        questionId,
      );
      _perguntaWithRespostas = questionDetail;
      emit(DetailsLoaded(questionDetail));
    } catch (e) {
      emit(DetailsError('Failed to fetch question detail: $e'));
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
      emit(DetailsLoaded(questionDetail));
    } catch (e) {
      emit(DetailsError('Failed to post answer: $e'));
    }
  }
}
