class Routes {
  late final getAllURL = 'http://localhost:6147/';
  late final postPerguntaURL = 'http://localhost:6147/salvarpergunta';
  late final postRespostaURL = 'http://localhost:6147/responder';
  String getByIdURL(int id) {
    return 'http://localhost:6147/perguntar/$id';
  }
}