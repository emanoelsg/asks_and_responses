// app/view/controllers/cubits/service/question_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:mobile/app/data/service/connection.dart';
import 'package:mobile/app/domain/entities/question_model.dart';
import 'question_state.dart';

class PerguntasCubit extends Cubit<PerguntasState> {
  final PerguntaService _service = PerguntaService();
  List<Pergunta>? _perguntas;


  List<Pergunta>? get perguntas => _perguntas;
  PerguntasCubit() : super(PerguntasInitial());

  Future<void> fetchQuestions() async {
    emit(PerguntasLoading());
    try {
      final listOfQuestions = await _service.getPerguntas();
      _perguntas = listOfQuestions;
      emit(PerguntasLoaded(listOfQuestions));
    } catch (e) {
      emit(PerguntasError('Failed to fetch questions: $e'));
    }
  }

  

  Future<void> postQuestion({
    required String title,
    required String description,
  }) async {
    try {
      await _service.postPergunta(title: title, description: description);
      final listOfQuestions = await _service.getPerguntas();
      _perguntas = listOfQuestions;
      emit(PerguntasLoaded(listOfQuestions));
    } catch (e) {
      emit(PerguntasError('Failed to post question: $e'));
    }
  }


}
