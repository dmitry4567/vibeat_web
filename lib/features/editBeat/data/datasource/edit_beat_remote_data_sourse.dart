import 'dart:developer';
import 'package:dio/dio.dart' as d;
import 'package:vibeat_web/core/api_client.dart';
import 'package:vibeat_web/features/editBeat/presentation/bloc/edit_beat_bloc.dart';

abstract class EditBeatRemoteDataSource {
  Future<bool> addMp3File(
    AddMp3FileEvent event,
    String v4, {
    void Function(double progress)? onProgress,
  });
  Future<bool> addWavFile(
    AddWavFileEvent event,
    String v4, {
    void Function(double progress)? onProgress,
  });
  Future<bool> addZipFile(
    AddZipFileEvent event,
    String v4, {
    void Function(double progress)? onProgress,
  });
}

class EditBeatRemoteDataSourceImpl implements EditBeatRemoteDataSource {
  final ApiClient _apiClient;

  EditBeatRemoteDataSourceImpl({
    required ApiClient apiClient,
  }) : _apiClient = apiClient;

  @override
  Future<bool> addMp3File(
    AddMp3FileEvent event,
    String v4, {
    void Function(double progress)? onProgress,
  }) async {
    try {
      final response = await _apiClient.post(
        "beatsupload/presigned/PresignedPostRequest/mp3beats",
        data: {
          "uuidFileName": v4,
          "file": event.file.name,
        },
        options: d.Options(),
      );

      final url = response.data['data']['URL'];

      final uploadResponse = await _apiClient.put(
        url,
        d.Options(
          headers: {
            // 'Content-Type': 'multipart/form-data',
            'Content-Type': 'audio/mpeg',
            'Access-Control-Allow-Origin': '*',
          },
        ),
        data: event.file.bytes,
        onSendProgress: (int sent, int total) {
          if (onProgress != null && total > 0) {
            onProgress(sent / total);
          }
        },
      );

      if (uploadResponse.statusCode == 200) {
        print('File uploaded successfully to Yandex Cloud S3');

        final response = await _apiClient.post(
          "beatsupload/updateURL/beat/mp3",
          options: d.Options(),
          data: {
            "id": event.beatId,
            "objectKey": v4,
          },
        );

        if (response.statusCode == 200) {
          return true;
        }
      }
      return false;
    } on d.DioException catch (e) {
      log('DioException in getAnketa: $e');
      throw Exception('Failed to load anketa: $e');
    } on Exception catch (e) {
      log('Error in getAnketa: $e');
      throw Exception('Failed to load anketa: $e');
    }
  }

  @override
  Future<bool> addWavFile(
    AddWavFileEvent event,
    String v4, {
    void Function(double progress)? onProgress,
  }) async {
    try {
      final response = await _apiClient.post(
        "beatsupload/presigned/PresignedPostRequest/wavbeats",
        data: {
          "uuidFileName": v4,
          "file": event.file.name,
        },
        options: d.Options(),
      );

      final url = response.data['data']['URL'];

      final uploadResponse = await _apiClient.put(
        url,
        d.Options(
          headers: {
            // 'Content-Type': 'multipart/form-data',
            'Content-Type': 'audio/wave',
            'Access-Control-Allow-Origin': '*',
          },
        ),
        data: event.file.bytes,
        onSendProgress: (int sent, int total) {
          if (onProgress != null && total > 0) {
            onProgress(sent / total);
          }
        },
      );

      if (uploadResponse.statusCode == 200) {
        print('File uploaded successfully to Yandex Cloud S3');

        final response = await _apiClient.post(
          "beatsupload/updateURL/beat/wav",
          options: d.Options(),
          data: {
            "id": event.beatId,
            "objectKey": v4,
          },
        );

        if (response.statusCode == 200) {
          return true;
        }
      }
      return false;
    } on d.DioException catch (e) {
      log('DioException in getAnketa: $e');
      throw Exception('Failed to load anketa: $e');
    } on Exception catch (e) {
      log('Error in getAnketa: $e');
      throw Exception('Failed to load anketa: $e');
    }
  }

  @override
  Future<bool> addZipFile(
    AddZipFileEvent event,
    String v4, {
    void Function(double progress)? onProgress,
  }) async {
    try {
      final response = await _apiClient.post(
        "beatsupload/presigned/PresignedPostRequest/zipbeats",
        data: {
          "uuidFileName": v4,
          "file": event.file.name,
        },
        options: d.Options(),
      );

      final url = response.data['data']['URL'];

      final uploadResponse = await _apiClient.put(
        url,
        d.Options(
          headers: {
            // 'Content-Type': 'multipart/form-data',
            'Content-Type': 'application/zip',
            'Access-Control-Allow-Origin': '*',
          },
        ),
        data: event.file.bytes,
        onSendProgress: (int sent, int total) {
          if (onProgress != null && total > 0) {
            onProgress(sent / total);
          }
        },
      );

      if (uploadResponse.statusCode == 200) {
        print('File uploaded successfully to Yandex Cloud S3');

        final response = await _apiClient.post(
          "beatsupload/updateURL/beat/zip",
          options: d.Options(),
          data: {
            "id": event.beatId,
            "objectKey": v4,
          },
        );

        if (response.statusCode == 200) {
          return true;
        }
      }
      return false;
    } on d.DioException catch (e) {
      log('DioException in getAnketa: $e');
      throw Exception('Failed to load anketa: $e');
    } on Exception catch (e) {
      log('Error in getAnketa: $e');
      throw Exception('Failed to load anketa: $e');
    }
  }
}
