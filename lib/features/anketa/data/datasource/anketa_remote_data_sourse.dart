import 'dart:developer';
import 'package:dio/dio.dart' as d;
import 'package:vibeat_web/core/api_client.dart';
import 'package:vibeat_web/features/anketa/data/models/anketa_model.dart';

abstract class AnketaRemoteDataSource {
  Future<List<AnketaModel>> getAnketa();
  Future<String> sendAnketaResponse(String genres);
}

class AnketaRemoteDataSourceImpl implements AnketaRemoteDataSource {
  final ApiClient _apiClient;

  AnketaRemoteDataSourceImpl({
    required ApiClient apiClient,
  }) : _apiClient = apiClient;

  @override
  Future<List<AnketaModel>> getAnketa() async {
    try {
      final data = await _apiClient.get(
        '/allGenres',
        options: d.Options(),
      );

      if (data.statusCode != 200) {
        throw Exception(
            'Failed to load anketa. Status code: ${data.statusCode}');
      }

      if (data.data == null || data.data['genres'] == null) {
        throw Exception('Invalid response data format');
      }

      final List<AnketaModel> genres = (data.data['genres'] as List)
          .map((e) => AnketaModel(text: e?.toString() ?? ''))
          .toList();

      return genres;
    } on d.DioException catch (e) {
      log('DioException in getAnketa: $e');
      throw Exception('Failed to load anketa: $e');
    } on Exception 
    catch (e) {
      log('Error in getAnketa: $e');
      throw Exception('Failed to load anketa: $e');
    }
  }

  @override
  Future<String> sendAnketaResponse(String genres) async {
    final data = await _apiClient.post(
      '/saveAnketa',
      options: d.Options(),
      data: {
        'genres': genres,
      },
    );

    if (data.statusCode != 200) {
      throw Exception('Failed to load anketa');
    }
    final responseData = data.data;
    log(responseData['message']);

    return responseData['message'];
  }
}
