// data/service/connection.dart

import 'package:dio/dio.dart';

import '../../domain/entities/perguntas_model.dart';

class PerguntaRemoteDataSource {
  final Dio _dio = Dio();
  static const String baseUrl = 'http://10.0.2.2:6147';
  static const String apiEndpoint = '/';

  Future<List<PerguntasModel>> getAllPerguntas() async {
    try {
      final response = await _dio.get('$baseUrl$apiEndpoint');

      if (response.statusCode == 200) {
        // A API Node.js/Express retorna uma lista de JSONs (o body é a lista 'perguntas')
        final List<dynamic> data = response.data;
        return data.map((json) => PerguntasModel.fromJson(json)).toList();
      } else {
        throw Exception(
          'Falha ao carregar perguntas: Status ${response.statusCode}',
        );
      }
    } catch (e) {
      // Exemplo de erro de conexão ou timeout
      throw Exception('Falha na comunicação com o servidor: $e');
    }
  }

  Future<PerguntasModel> getPerguntasModel(int id) async {
    final url = '${PerguntaRemoteDataSource.baseUrl}/perguntas/$id';
    try {
      final response = await _dio.get(url);

      if (response.statusCode == 200) {
        return PerguntasModel.fromJson(response.data);
      } else {
        throw Exception(
          'Falha ao carregar a pergunta: Status ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Falha na comunicação com o servidor ($url): $e');
    }
  }

  // POST /responder
  Future<void> postResposta(int perguntaId, String corpo) async {
    try {
      await _dio.post(
        '${PerguntaRemoteDataSource.baseUrl}/responder',
        data: {
          // Os campos devem corresponder ao que seu Node.js espera no req.body
          'description': corpo,
          'perguntaId': perguntaId,
        },
      );
    } on DioException catch (e) {
      // Trata erros de requisição
      throw Exception(
        'Falha ao enviar resposta: ${e.response?.data ?? e.message}',
      );
    }
  }

  Future<void> postPergunta(String title, String description) async {
    try {
      await _dio.post(
        '${PerguntaRemoteDataSource.baseUrl}/perguntar',
        data: {
          // Os campos devem corresponder ao que seu Node.js espera no req.body
          'title': title,
          'description': description,
        },
      );
    } on DioException catch (e) {
      // Trata erros de requisição
      throw Exception(
        'Falha ao enviar pergunta: ${e.response?.data ?? e.message}',
      );
    }
  }
}
