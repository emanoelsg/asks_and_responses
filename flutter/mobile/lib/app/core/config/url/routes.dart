class Routes {
  late final getAllURL = 'http://localhost:6147/';
  late final postQuestionURL = 'http://localhost:6147/salvarpergunta';
  late final postAnswerURL = 'http://localhost:6147/responder';
  String getByIdURL(int id) {
    return 'http://localhost:6147/perguntar/$id';
  }
}