import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:vibeat_web/features/allBeats/data/models/beat_model.dart';
import 'package:vibeat_web/features/allBeats/domain/entities/beat_entity.dart';

part 'edit_beat_event.dart';
part 'edit_beat_state.dart';

class EditBeatBloc extends Bloc<EditBeatEvent, BeatState> {
  // final GetEditBeats getEditBeats;
  // final MakeEmptyBeat makeEmptyBeat;
  Dio dio = Dio();

  EditBeatBloc({
    required BeatEntity beat,
    required bool isEditMode,
    // required this.getEditBeats,
    // required this.makeEmptyBeat,
  }) : super(isEditMode
            ? BeatEditState(
                beat: beat,
                isMp3Loading: IsMp3Loading.initial,
                progressMp3: 0,
                isWavLoading: IsWavLoading.initial,
                progressWav: 0,
                isZipLoading: IsZipLoading.initial,
                progressZip: 0,
                isCoverLoading: IsCoverLoading.initial,
                progressCover: 0,
                isSavedSuccess: false,
              )
            : BeatViewState(beat)) {
    on<AddMp3File>(_addMp3File);
    on<AddWavFile>(_addWavFile);
    on<AddZipFile>(_addZipFile);
    on<AddCoverFile>(_addCoverFile);
    on<ChangeName>(_changeName);
    on<ChangeDescription>(_changeDescription);
    on<ChangeTags>(_changeTags);
    on<ChangeGenres>(_changeGenres);
    on<ChangeMoods>(_changeMoods);
    on<ChangeKey>(_changeKey);
    on<ChangeBpm>(_changeBpm);
    on<SaveDraft>(_saveDraft);
  }

  Future<void> _addMp3File(AddMp3File event, Emitter<BeatState> emit) async {
    final currentState = state as BeatEditState;

    emit(currentState.copyWith(
      isMp3Loading: IsMp3Loading.loading,
      progressMp3: 0.0,
    ));

    var uuid = const Uuid();
    String v4 = uuid.v1();

    final response = await dio.post(
      "http://192.168.0.135:7774/api/presigned/PresignedPostRequest/mp3beats",
      data: {
        "uuidFileName": v4,
        "file": event.file.name,
      },
      options: Options(headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*',
      }),
    );

    final url = response.data['data']['URL'];

    // Загружаем файл на S3
    final uploadResponse = await dio.put(
      url,
      // 'https://cors-anywhere.herokuapp.com/' + url,
      data: event.file.bytes,
      options: Options(
        headers: {
          // 'Content-Type': 'multipart/form-data',
          'Content-Type': 'audio/mpeg',
          'Access-Control-Allow-Origin': '*',
        },
      ),
      onSendProgress: (int sent, int total) {
        final progress = sent / total;
        emit(currentState.copyWith(
          isMp3Loading: IsMp3Loading.loading,
          progressMp3: progress,
        ));
      },
    );

    if (uploadResponse.statusCode == 200) {
      print('File uploaded successfully to Yandex Cloud S3');

      final response = await dio.post(
        "http://192.168.0.135:7774/api/updateURL/beat/mp3",
        options: Options(headers: {
          'Content-Type': 'application/json',
        }),
        data: {
          "id": event.beatId,
          "objectKey": v4,
        },
      );

      if (response.statusCode == 200) {
        log("file is added");

        final currentState = state as BeatEditState;

        emit(currentState.copyWith(
          beat: currentState.beat.copyWith(
            availableFiles: currentState.beat.availableFiles.copyWith(
              mp3Url: v4,
            ),
          ),
          isMp3Loading: IsMp3Loading.success,
          progressMp3: 1.0,
        ));
      }
    }
  }

  Future<void> _addWavFile(AddWavFile event, Emitter<BeatState> emit) async {
    final currentState = state as BeatEditState;

    emit(currentState.copyWith(
      isWavLoading: IsWavLoading.loading,
      progressWav: 0.0,
    ));

    var uuid = const Uuid();
    String v4 = uuid.v1();

    final response = await dio.post(
      "http://192.168.0.135:7774/api/presigned/PresignedPostRequest/wavbeats",
      data: {
        "uuidFileName": v4,
        "file": event.file.name,
      },
      options: Options(headers: {
        'Content-Type': 'application/json',
      }),
    );

    final url = response.data['data']['URL'];

    // Загружаем файл на S3
    final uploadResponse = await dio.put(
      url,
      // 'https://cors-anywhere.herokuapp.com/' + url,
      data: event.file.bytes,
      options: Options(
        headers: {
          // 'Content-Type': 'multipart/form-data',
          'Content-Type': 'audio/wave',
          'Access-Control-Allow-Origin': '*',
        },
      ),
      onSendProgress: (int sent, int total) {
        final progress = sent / total;
        emit(currentState.copyWith(
          isWavLoading: IsWavLoading.loading,
          progressWav: progress,
        ));
      },
    );

    if (uploadResponse.statusCode == 200) {
      print('File uploaded successfully to Yandex Cloud S3');

      final response = await dio.post(
        "http://192.168.0.135:7774/api/updateURL/beat/wav",
        options: Options(headers: {
          'Content-Type': 'application/json',
        }),
        data: {
          "id": event.beatId,
          "objectKey": v4,
        },
      );

      if (response.statusCode == 200) {
        log("file is added");

        final currentState = state as BeatEditState;

        emit(currentState.copyWith(
          beat: currentState.beat.copyWith(
            availableFiles: currentState.beat.availableFiles.copyWith(
              wavUrl: v4,
            ),
          ),
          isWavLoading: IsWavLoading.success,
          progressWav: 1.0,
        ));
      }
    }
  }

  Future<void> _addZipFile(AddZipFile event, Emitter<BeatState> emit) async {
    final currentState = state as BeatEditState;

    emit(currentState.copyWith(
      isZipLoading: IsZipLoading.loading,
      progressZip: 0.0,
    ));

    var uuid = const Uuid();
    String v4 = uuid.v1();

    final response = await dio.post(
      "http://192.168.0.135:7774/api/presigned/PresignedPostRequest/zipbeats",
      data: {
        "uuidFileName": v4,
        "file": event.file.name,
      },
      options: Options(headers: {
        'Content-Type': 'application/json',
      }),
    );

    final url = response.data['data']['URL'];

    // Загружаем файл на S3
    final uploadResponse = await dio.put(
      url,
      // 'https://cors-anywhere.herokuapp.com/' + url,
      data: event.file.bytes,
      options: Options(
        headers: {
          'Content-Type': 'application/zip',
          'Access-Control-Allow-Origin': '*',
        },
      ),
      onSendProgress: (int sent, int total) {
        final progress = sent / total;
        emit(currentState.copyWith(
          isZipLoading: IsZipLoading.loading,
          progressZip: progress,
        ));
      },
    );

    if (uploadResponse.statusCode == 200) {
      print('File uploaded successfully to Yandex Cloud S3');

      final response = await dio.post(
        "http://192.168.0.135:7774/api/updateURL/beat/zip",
        options: Options(headers: {
          'Content-Type': 'application/json',
        }),
        data: {
          "id": event.beatId,
          "objectKey": v4,
        },
      );

      if (response.statusCode == 200) {
        log("file is added");

        final currentState = state as BeatEditState;

        emit(currentState.copyWith(
          beat: currentState.beat.copyWith(
            availableFiles: currentState.beat.availableFiles.copyWith(
              zipUrl: v4,
            ),
          ),
          isZipLoading: IsZipLoading.success,
          progressZip: 1.0,
        ));
      }
    }
  }

  Future<void> _addCoverFile(
      AddCoverFile event, Emitter<BeatState> emit) async {
    final currentState = state as BeatEditState;

    emit(currentState.copyWith(
      isCoverLoading: IsCoverLoading.loading,
      progressCover: 0.0,
    ));

    var uuid = const Uuid();
    String v4 = uuid.v1();

    final response = await dio.post(
      "http://192.168.0.135:7774/api/presigned/PresignedPostRequest/imagesall",
      data: {
        "uuidFileName": v4,
        "file": event.file.name,
      },
      options: Options(headers: {
        'Content-Type': 'application/json',
      }),
    );

    final url = response.data['data']['URL'];

    // Загружаем файл на S3
    final uploadResponse = await dio.put(
      url,
      // 'https://cors-anywhere.herokuapp.com/' + url,
      data: event.file.bytes,
      options: Options(
        headers: {
          'Content-Type': 'image/jpeg',
          'Access-Control-Allow-Origin': '*',
        },
      ),
      onSendProgress: (int sent, int total) {
        final progress = sent / total;
        emit(currentState.copyWith(
          isCoverLoading: IsCoverLoading.loading,
          progressCover: progress,
        ));
      },
    );

    if (uploadResponse.statusCode == 200) {
      print('File uploaded successfully to Yandex Cloud S3');

      final response = await dio.post(
        "http://192.168.0.135:7774/api/updateURL/beat/cover",
        options: Options(headers: {
          'Content-Type': 'application/json',
        }),
        data: {
          "id": event.beatId,
          "objectKey": v4,
        },
      );

      if (response.statusCode == 200) {
        log("file is added");

        final currentState = state as BeatEditState;

        emit(currentState.copyWith(
          beat: currentState.beat
              .copyWith(urlPicture: "storage.yandexcloud.net/imagesall/" + v4),
          isCoverLoading: IsCoverLoading.success,
          progressCover: 1.0,
        ));
      }
    }
  }

  Future<void> _changeName(ChangeName event, Emitter<BeatState> emit) async {
    final currentState = state as BeatEditState;

    emit(currentState.copyWith(
        beat: currentState.beat.copyWith(name: event.name)));
  }

  Future<void> _changeDescription(
      ChangeDescription event, Emitter<BeatState> emit) async {
    final currentState = state as BeatEditState;

    emit(currentState.copyWith(
        beat: currentState.beat.copyWith(description: event.description)));
  }

  Future<void> _changeTags(ChangeTags event, Emitter<BeatState> emit) async {
    final currentState = state as BeatEditState;

    emit(currentState.copyWith(
        beat: currentState.beat.copyWith(tags: event.tags)));
  }

  Future<void> _changeGenres(
      ChangeGenres event, Emitter<BeatState> emit) async {
    final currentState = state as BeatEditState;

    emit(currentState.copyWith(
        beat: currentState.beat.copyWith(genres: event.genres)));
  }

  Future<void> _changeMoods(ChangeMoods event, Emitter<BeatState> emit) async {
    final currentState = state as BeatEditState;

    emit(currentState.copyWith(
        beat: currentState.beat.copyWith(moods: event.moods)));
  }

  Future<void> _changeKey(ChangeKey event, Emitter<BeatState> emit) async {
    final currentState = state as BeatEditState;

    // emit(currentState.copyWith(
    //     beat: currentState.beat.copyWith(key: event.key)));
  }

  Future<void> _changeBpm(ChangeBpm event, Emitter<BeatState> emit) async {
    final currentState = state as BeatEditState;

    emit(currentState.copyWith(
        beat: currentState.beat.copyWith(bpm: event.bpm)));
  }

  Future<void> _saveDraft(SaveDraft event, Emitter<BeatState> emit) async {
    final currentState = state as BeatEditState;

    emit(currentState.copyWith(
      isSavedSuccess: false,
    ));

    final beat = currentState.beat;

    final Map<String, dynamic> requestData = {
      "id": beat.id,
    };

    if (beat.name != "") {
      requestData["name"] = beat.name;
    }

    if (beat.description != "") {
      requestData["description"] = beat.description;
    }

    if (beat.tags.isNotEmpty) {
      requestData["tags"] = beat.tags.map((e) => {"id": e.id}).toList();
    } else {
      requestData["tags"] = [];
    }

    if (beat.genres.isNotEmpty) {
      requestData["genres"] = beat.genres.map((e) => {"id": e.id}).toList();
    } else {
      requestData["genres"] = [];
    }

    if (beat.moods.isNotEmpty) {
      requestData["moods"] = beat.moods.map((e) => {"id": e.id}).toList();
    } else {
      requestData["moods"] = [];
    }

    // if (beat.key.name != "") {
    //   requestData["keynoteId"] = beat.key.id;
    // }

    if (beat.bpm != 0) {
      requestData["bpm"] = beat.bpm;
    }

    log(requestData.toString());

    try {
      final response = await dio.patch(
        "http://192.168.0.135:7772/api/unpbeats/saveDraft",
        options: Options(headers: {
          'Content-Type': 'application/json',
        }),
        data: requestData,
      );

      if (response.statusCode == 200) {
        final currentState = state as BeatEditState;

        log("update beat");

        emit(currentState.copyWith(
          isSavedSuccess: true,
        ));
        // emit(currentState.copyWith(beat: currentState.beat));
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
