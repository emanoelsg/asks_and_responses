// app/core/config/url/routes.dart
class Routes {
  String base = 'http://192.168.0.106:6147/';
  late final getAllURL = base;
  late final postQuestionURL = '$base/salvarpergunta';
  late final postAnswerURL = '$base/responder';
  String getByIdURL(int id) {
    return '$base/perguntar/$id';
  }
}
