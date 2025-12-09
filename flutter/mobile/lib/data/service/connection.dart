import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../core/config/url/routes.dart';
import '../../domain/entities/question_model.dart';
import '../../domain/entities/question_with_responses_model.dart';

class PerguntaService {
  final Dio _dio = Dio();
  final Routes _routes = Routes();
  Future<List<Pergunta>> getPerguntas() async {
    try {
      final response = await _dio.get(_routes.getAllURL);

      if (response.statusCode == 200) {
        final List<dynamic> perguntasJson =
            response.data['perguntas'] as List<dynamic>;
        return perguntasJson
            .map((json) => Pergunta.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception(
          'Failed to load perguntas. Status: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw Exception('Dio Error fetching perguntas: ${e.message}');
    } catch (e) {
      throw Exception('Error fetching perguntas: $e');
    }
  }

  Future<dynamic> getPerguntaWithResponses(int id) async {
    try {
      final response = await _dio.get(_routes.getByIdURL(id));

      if (response.statusCode == 200) {
        final data = response.data;
        if (data is Map<String, dynamic>) {
          PerguntasWithRespostas perguntaComRespostas =
              PerguntasWithRespostas.fromJson(data);
          return perguntaComRespostas;
        }
      } else if (response.statusCode == 404) {
        throw Exception('Question ID $id not found.');
      } else {
        throw Exception(
          'Failed to load question details. Status: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw Exception('Dio Error fetching question detail: ${e.message}');
    }
  }

  Future<void> postPergunta({
    required String title,
    required String description,
  }) async {
    try {
      final response = await _dio.post(
        _routes.postPerguntaURL,
        data: {'title': title, 'description': description},
        options: Options(
          contentType: Headers
              .formUrlEncodedContentType, // Matches Express bodyParser setup
        ),
      );

      if (response.statusCode != 201) {
        throw Exception(
          'Failed to create question. Status: ${response.statusCode}. Response: ${response.data}',
        );
      }
    } on DioException catch (e) {
      throw Exception('Dio Error posting question: ${e.message}');
    }
  }

  // 4. POST /responder (Create new answer)
  Future<void> postResposta({
    required String description,
    required int perguntaId,
  }) async {
    try {
      final response = await _dio.post(
        _routes.postRespostaURL,
        data: {'description': description, 'perguntaId': perguntaId},
        options: Options(
          contentType: Headers
              .formUrlEncodedContentType, // Matches Express bodyParser setup
        ),
      );

      if (response.statusCode != 201) {
        throw Exception(
          'Failed to create answer. Status: ${response.statusCode}. Response: ${response.data}',
        );
      }
      // Status 201 is "Created" - success
    } on DioException catch (e) {
      throw Exception('Dio Error posting answer: ${e.message}');
    }
  }
}
