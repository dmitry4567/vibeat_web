import 'dart:developer';
import 'package:dio/dio.dart' as d;
import 'package:vibeat_web/core/api_client.dart';
import 'package:vibeat_web/features/allBeats/data/models/beat_model.dart';
import 'package:vibeat_web/features/allBeats/domain/entities/beat_entity.dart';

abstract class EditBeatRemoteDataSource {
  // Future<List<BeatModel>> getAllBeats();
  // Future<BeatEntity> makeEmptyBeat();
}

class EditBeatRemoteDataSourceImpl implements EditBeatRemoteDataSource {
  final ApiClient _apiClient;

  EditBeatRemoteDataSourceImpl({
    required ApiClient apiClient,
  }) : _apiClient = apiClient;

  // @override
  // Future<List<BeatModel>> getAllBeats() async {
  //   try {
  //     final data = await _apiClient.get(
  //       'unpbeats/unpublishedBeatsByBeatmakerJWT',
  //       options: d.Options(),
  //     );

  //     if (data.statusCode != 200) {
  //       throw Exception(
  //           'Failed to load anketa. Status code: ${data.statusCode}');
  //     }

  //     if (data.data == null || data.data['data'] == null) {
  //       throw Exception('Invalid response data format');
  //     }

  //     final List<BeatModel> beats = (data.data['data'] as List)
  //         .map(
  //           (e) => BeatModel(
  //               id: e['id'],
  //               name: e['name'],
  //               urlPicture: e['picture'],
  //               tags: (e['tags'] as List<dynamic>)
  //                   .map((tag) => Tag.fromJson(tag))
  //                   .toList(),
  //               status: StatusBeat.values.firstWhere((status) =>
  //                   status.toString() == 'StatusBeat.${e['status']}')
  //               // beatmakerId: e['beatmakerId'],
  //               ),
  //         )
  //         .toList();

  //     return beats;
  //   } on d.DioException catch (e) {
  //     log('DioException in getAnketa: $e');
  //     throw Exception('Failed to load anketa: $e');
  //   } on Exception catch (e) {
  //     log('Error in getAnketa: $e');
  //     throw Exception('Failed to load anketa: $e');
  //   }
  // }

  // @override
  // Future<BeatEntity> makeEmptyBeat() async {
  //   final data = await _apiClient.post(
  //     'unpbeats/makeEmptyBeat',
  //     options: d.Options(),
  //   );

  //   if (data.statusCode != 200) {
  //     throw Exception('Failed to create beat');
  //   }
  //   final responseData = data.data;

  //   if (responseData['status'] == true) {
  //     return BeatEntity.fromJson(responseData['data']);
  //   }
    
  //   throw Exception('Failed to create beat');
  // }
}
