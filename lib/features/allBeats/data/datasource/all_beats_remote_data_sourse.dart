import 'dart:developer';
import 'package:dio/dio.dart' as d;
import 'package:vibeat_web/core/api_client.dart';
import 'package:vibeat_web/features/allBeats/data/models/beat_model.dart';
import 'package:vibeat_web/features/allBeats/domain/entities/beat_entity.dart';

abstract class AllBeatRemoteDataSource {
  Future<List<BeatModel>> getAllBeats();
  Future<BeatEntity> makeEmptyBeat();
  Future<bool> deleteBeat(String beatId);
}

class AllBeatRemoteDataSourceImpl implements AllBeatRemoteDataSource {
  final ApiClient _apiClient;

  AllBeatRemoteDataSourceImpl({
    required ApiClient apiClient,
  }) : _apiClient = apiClient;

  @override
  Future<List<BeatModel>> getAllBeats() async {
    try {
      final data = await _apiClient.get(
        'unpbeats/unpublishedBeatsByBeatmakerJWT',
        options: d.Options(),
      );

      if (data.statusCode != 200) {
        throw Exception(
            'Failed to load anketa. Status code: ${data.statusCode}');
      }

      if (data.data == null || data.data['data'] == null) {
        throw Exception('Invalid response data format');
      }

      final List<BeatModel> beats = (data.data['data'] as List)
          .map(
            (e) => BeatModel(
              id: e['id'],
              name: e['name'],
              description: e['description'],
              urlPicture: e['picture'],
              tags: (e['tags'] as List<dynamic>)
                  .map((tag) => Tag.fromJson(tag))
                  .toList(),
              genres: (e['genres'] as List<dynamic>)
                  .map((genre) => Genre.fromJson(genre))
                  .toList(),
              moods: (e['moods'] as List<dynamic>)
                  .map((mood) => Mood.fromJson(mood))
                  .toList(),
              // key: KeyModel(
              //   id: e['ID'] ?? 1,
              //   name: e['Name'] ?? "name",
              // ),
              key: KeyModel(
                id: e['keynote']['id'],
                name: e['keynote']['name'],
              ),
              status: StatusBeat.values.firstWhere(
                  (status) => status.toString() == 'StatusBeat.${e['status']}'),
              availableFiles: AvailableFiles(
                id: e['AvailableFiles']['ID'],
                mp3Url: e['AvailableFiles']['MP3Url'],
                wavUrl: e['AvailableFiles']['WAVUrl'],
                zipUrl: e['AvailableFiles']['ZIPUrl'],
              ),
              bpm: e['bpm'],
              // beatmakerId: e['beatmakerId'],
              createdAt: e['created_at'],
            ),
          )
          .toList();

      beats.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      return beats;
    } on d.DioException catch (e) {
      log('DioException in getAnketa: $e');
      throw Exception('Failed to load anketa: $e');
    } on Exception catch (e) {
      log('Error in getAnketa: $e');
      throw Exception('Failed to load anketa: $e');
    }
  }

  @override
  Future<BeatEntity> makeEmptyBeat() async {
    final data = await _apiClient.post(
      'unpbeats/makeEmptyBeat',
      options: d.Options(),
    );

    if (data.statusCode != 200) {
      throw Exception('Failed to create beat');
    }
    final responseData = data.data;

    if (responseData['status'] == true) {
      return BeatEntity.fromJson(responseData['data']);
    }

    throw Exception('Failed to create beat');
  }

  @override
  Future<bool> deleteBeat(String beatId) async {
    final data = await _apiClient.delete(
      'unpbeats/deleteUnpublishedBeatById/$beatId',
    );

    if (data.statusCode != 200) {
      throw Exception('Failed to delete beat');
    }

    if (data.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
