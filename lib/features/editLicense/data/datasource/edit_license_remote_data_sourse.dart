import 'dart:developer';
import 'package:dio/dio.dart' as d;
import 'package:vibeat_web/core/api_client.dart';
import 'package:vibeat_web/features/allLicenses/domain/entities/license_entity.dart';
import 'package:vibeat_web/features/editLicense/presentation/bloc/edit_license_template_bloc.dart';

abstract class EditLicenseRemoteDataSource {
  Future<bool> saveDraftLicense(
    LicenseEntity event,
  );
}

class EditLicenseRemoteDataSourceImpl implements EditLicenseRemoteDataSource {
  final ApiClient _apiClient;

  EditLicenseRemoteDataSourceImpl({
    required ApiClient apiClient,
  }) : _apiClient = apiClient;

  @override
  Future<bool> saveDraftLicense(LicenseEntity templateLicense) async {
    final Map<String, dynamic> requestData = {"id": templateLicense.id};

    requestData["name"] = templateLicense.name;

    requestData["description"] = templateLicense.description;

    requestData["mp3"] = templateLicense.mp3;
    requestData["wav"] = templateLicense.wav;
    requestData["zip"] = templateLicense.zip;

    requestData["liveProfit"] = templateLicense.liveProfit;
    requestData["musicRecording"] = templateLicense.musicRecording;

    if (templateLicense.unlimDistributeCopies == true) {
      requestData["distributeCopies"] = -1;
    } else {
      requestData["distributeCopies"] = templateLicense.distributeCopies;
    }

    if (templateLicense.unlimAudioStreams == true) {
      requestData["audioStreams"] = -1;
    } else {
      requestData["audioStreams"] = templateLicense.audioStreams;
    }

    if (templateLicense.unlimRadioBroadcasting == true) {
      requestData["radioBroadcasting"] = -1;
    } else {
      requestData["radioBroadcasting"] = templateLicense.radioBroadcasting;
    }

    if (templateLicense.unlimMusicVideos == true) {
      requestData["musicVideos"] = -1;
    } else {
      requestData["musicVideos"] = templateLicense.musicVideos;
    }

    try {
      final response = await _apiClient.patch(
        "license/licenseTemplate",
        data: requestData,
      );

      if (response.statusCode == 200) {
        return true;
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
