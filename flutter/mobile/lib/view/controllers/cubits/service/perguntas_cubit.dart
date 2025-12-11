import 'package:bloc/bloc.dart';

import '../../../../domain/entities/question_model.dart';
import '../../../../domain/entities/question_with_responses_model.dart';
import 'perguntas_state.dart';

class PerguntasCubit extends Cubit<PerguntasState> {
  final List<Pergunta>? perguntas;
  final PerguntasWithRespostas? perguntaWithRespostas;

  PerguntasCubit(this.perguntas, this.perguntaWithRespostas) : super(PerguntasInitial());


  
}

