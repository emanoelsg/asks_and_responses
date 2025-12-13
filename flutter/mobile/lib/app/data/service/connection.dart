// app/data/service/connection.dart
import 'package:dio/dio.dart';
import '../../core/config/url/routes.dart';
import '../../domain/entities/question_model.dart';
import '../../domain/entities/question_with_responses_model.dart';

// Serviço responsável pela comunicação com a API para operações CRUD de Perguntas e Respostas.
class PerguntaService {
  final Dio _httpClient = Dio();
  final Routes _routes = Routes();

  // Método privado para tratar e relançar exceções padronizadas.
  Exception _handleError(Object e, String operation) {
    if (e is DioException) {
      return Exception('Dio Error during $operation: ${e.message}');
    }
    return Exception('General Error during $operation: $e');
  }

  // Método auxiliar para verificar se o status code da resposta indica sucesso (2xx).
  bool _isSuccess(int? statusCode) {
    return statusCode != null && statusCode >= 200 && statusCode < 300;
  }

  /// Busca e retorna uma lista de todas as [Pergunta]s disponíveis na API.
  Future<List<Pergunta>> getQuestions() async {
    const String operation = 'fetching all questions';
    try {
      final response = await _httpClient.get(_routes.getAllURL);

      if (_isSuccess(response.statusCode)) {
        // Garantindo que 'perguntas' é uma lista e tratando a ausência
        final List<dynamic>? questionsJson =
            response.data['perguntas'] as List<dynamic>?;

        if (questionsJson == null) {
          return []; // Retorna lista vazia se a chave 'perguntas' estiver faltando ou não for lista
        }
        return questionsJson
            .map((json) => Pergunta.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception(
          'Failed to load questions. Status: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw _handleError(e, operation);
    }
  }

  /// Busca uma Pergunta específica pelo seu [questionId], incluindo todas as suas Respostas.
  ///
  /// O retorno é tipado como [PerguntasWithRespostas], garantindo segurança.
  Future<PerguntasWithRespostas> getQuestionsWithResponses(
      int questionId) async {
    const String operation = 'fetching question detail';
    try {
      final response = await _httpClient.get(_routes.getByIdURL(questionId));

      if (_isSuccess(response.statusCode)) {
        final responseData = response.data;
        if (responseData is Map<String, dynamic>) {
          return PerguntasWithRespostas.fromJson(responseData);
        } else {
          throw Exception('Invalid data format received for question detail.');
        }
      } else if (response.statusCode == 404) {
        throw Exception('Question ID $questionId not found.');
      } else {
        throw Exception(
          'Failed to load question details. Status: ${response.statusCode}',
        );
      }
    } catch (e) {
      // Usando o método auxiliar para tratar erros
      throw _handleError(e, operation);
    }
  }

  /// Cria e envia uma nova Pergunta com [title] e [description] para a API.
  Future<void> postQuestion({
    required String title,
    required String description,
  }) async {
    const String operation = 'creating new question';
    try {
      final response = await _httpClient.post(
        _routes.postQuestionURL,
        data: {'title': title, 'description': description},
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );
      if (response.statusCode != 201) {
        throw Exception(
          'Failed to create question. Status: ${response.statusCode}. Response: ${response.data}',
        );
      }
    } catch (e) {
      throw _handleError(e, operation);
    }
  }

  /// Cria e envia uma nova Resposta, associada à [perguntaId].
  Future<void> postAnswer({
    required String description,
    required int perguntaId,
  }) async {
    const String operation = 'creating new answer';
    try {
      final response = await _httpClient.post(
        _routes.postAnswerURL,
        data: {'description': description, 'perguntaId': perguntaId},
        // Configuração necessária para envio de dados como formulário.
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );

      // O backend espera o status 201 (Created) para sucesso.
      if (response.statusCode != 201) {
        throw Exception(
          'Failed to create answer. Status: ${response.statusCode}. Response: ${response.data}',
        );
      }
    } catch (e) {
      throw _handleError(e, operation);
    }
  }
}
