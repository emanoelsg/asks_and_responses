import '../../../../domain/entities/question_model.dart';
import '../../../../domain/entities/question_with_responses_model.dart';

abstract class PerguntasState {}

class PerguntasInitial extends PerguntasState {}

class PerguntasLoading extends PerguntasState {}

class PerguntasLoaded extends PerguntasState {
  final List<Pergunta> perguntas;

  PerguntasLoaded(this.perguntas);
}

class PerguntasRequestWithId extends PerguntasState {
  final String id;

  PerguntasRequestWithId(this.id);
} 


class PerguntasWithRespostasLoaded extends PerguntasState {
  final PerguntasWithRespostas perguntaWithRespostas;

  PerguntasWithRespostasLoaded(this.perguntaWithRespostas);
}

class PerguntasError extends PerguntasState {
  final String message;

  PerguntasError(this.message);
}