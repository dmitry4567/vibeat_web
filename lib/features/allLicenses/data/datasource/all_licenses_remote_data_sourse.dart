import 'dart:developer';
import 'package:dio/dio.dart' as d;
import 'package:vibeat_web/core/api_client.dart';
import 'package:vibeat_web/features/allLicenses/data/models/licenses_model.dart';
import 'package:vibeat_web/features/allLicenses/domain/entities/license_entity.dart';

abstract class AllLicensesRemoteDataSource {
  Future<List<LicenseModel>> getAllLicenses();
  Future<LicenseEntity> makeEmptyLicense();
}

class AllLicensesRemoteDataSourceImpl implements AllLicensesRemoteDataSource {
  final ApiClient _apiClient;

  AllLicensesRemoteDataSourceImpl({
    required ApiClient apiClient,
  }) : _apiClient = apiClient;

  @override
  Future<List<LicenseModel>> getAllLicenses() async {
    try {
      final response = await _apiClient.get(
        'license/allLicenseTemplatesByBeatmakerJWT',
        options: d.Options(),
      );

      if (response.statusCode != 200) {
        throw Exception(
            'Failed to load data. Status code: ${response.statusCode}');
      }
      if (response.data == null || response.data['data'] == null) {
        throw Exception('Invalid response data format');
      }

      final data = response.data['data'];

      if (data.isNotEmpty) {
        final List<LicenseModel> licenses = (data as List)
            .map<LicenseModel>((e) => LicenseModel(
                  id: e['id'] as int,
                  name: e['name'] as String,
                  mp3: bool.parse(e['mp3'].toString()),
                  wav: bool.parse(e['wav'].toString()),
                  zip: bool.parse(e['zip'].toString()),
                  description: e['description'] as String,
                  musicRecording: bool.parse(e['musicRecording'].toString()),
                  liveProfit: bool.parse(e['liveProfit'].toString()),
                  distributeCopies: int.parse(e['distributeCopies'].toString()),
                  audioStreams: int.parse(e['audioStreams'].toString()),
                  radioBroadcasting:
                      int.parse(e['radioBroadcasting'].toString()),
                  musicVideos: int.parse(e['musicVideos'].toString()),
                ))
            .toList();

        // beats.sort((a, b) => b.createdAt.compareTo(a.createdAt));

        return licenses;
      } else {
        return [];
      }
    } on d.DioException catch (e) {
      log('DioException in getAnketa: $e');
      throw Exception('Failed to load anketa: $e');
    } on Exception catch (e) {
      log('Error in getAnketa: $e');
      throw Exception('Failed to load anketa: $e');
    }
  }

  @override
  Future<LicenseEntity> makeEmptyLicense() async {
    final data = await _apiClient.post(
      'license/newLicenseTemplate',
      options: d.Options(),
      data: {}
    );

    if (data.statusCode == 201) {
      final responseData = data.data;

      return LicenseEntity.fromJson(responseData);
    }

    throw Exception('Failed to create beat');
  }
}
