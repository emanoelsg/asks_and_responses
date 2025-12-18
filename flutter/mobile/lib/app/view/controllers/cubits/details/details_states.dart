import 'package:mobile/app/domain/entities/question_with_responses_model.dart';

abstract class DetailsState {
}

class DetailsInitial extends DetailsState {
  final int? id;
  DetailsInitial(this.id);
}

class DetailsLoading extends DetailsState {
}

class DetailsLoaded extends DetailsState {
  final PerguntasWithRespostas perguntaWithRespostas;

  DetailsLoaded(this.perguntaWithRespostas);
}
class DetailsError extends DetailsState {
  final String message;

  DetailsError(this.message);
}