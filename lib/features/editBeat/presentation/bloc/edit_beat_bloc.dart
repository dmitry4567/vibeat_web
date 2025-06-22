import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:vibeat_web/app/injection_container.dart';
import 'package:vibeat_web/core/api_client.dart';
import 'package:vibeat_web/features/allBeats/domain/entities/beat_entity.dart';
import 'package:vibeat_web/features/editBeat/domain/usecases/add_cover.dart';
import 'package:vibeat_web/features/editBeat/domain/usecases/add_mp3.dart';
import 'package:vibeat_web/features/editBeat/domain/usecases/add_wav.dart';
import 'package:vibeat_web/features/editBeat/domain/usecases/add_zip.dart';
import 'package:vibeat_web/features/editBeat/domain/usecases/publish_beat.dart';
import 'package:vibeat_web/features/editLicense/data/models/license_template_entity.dart';

part 'edit_beat_event.dart';
part 'edit_beat_state.dart';

class EditBeatBloc extends Bloc<EditBeatEvent, BeatState> {
  final AddMp3File addMp3File;
  final AddWavFile addWavFile;
  final AddZipFile addZipFile;
  final AddCoverFile addCoverFile;
  final PublishBeat publishBeat;
  Dio dio = Dio();

  EditBeatBloc({
    required BeatEntity beat,
    required bool isEditMode,
    required this.addMp3File,
    required this.addWavFile,
    required this.addZipFile,
    required this.addCoverFile,
    required this.publishBeat,
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
                isBeatPublish: false,
                templateLicense: const [],
              )
            : BeatViewState(beat)) {
    on<AddMp3FileEvent>(_addMp3File);
    on<AddWavFileEvent>(_addWavFile);
    on<AddZipFileEvent>(_addZipFile);
    on<AddCoverFileEvent>(_addCoverFile);
    on<ChangeName>(_changeName);
    on<ChangeDescription>(_changeDescription);
    on<ChangeTags>(_changeTags);
    on<ChangeGenres>(_changeGenres);
    on<ChangeMoods>(_changeMoods);
    on<ChangeKey>(_changeKey);
    on<ChangeBpm>(_changeBpm);
    on<SaveDraft>(_saveDraft);
    on<PublishBeatEvent>(_publishBeat);
    on<PublishBeatSuccess>(_publishBeatSuccess);
    on<GetDataTemplateLicense>(_getDataTemplateLicense);
  }

  Future<void> _addMp3File(
      AddMp3FileEvent event, Emitter<BeatState> emit) async {
    final currentState = state as BeatEditState;

    emit(currentState.copyWith(
      isMp3Loading: IsMp3Loading.loading,
      progressMp3: 0.0,
    ));

    var uuid = const Uuid();
    String v4 = uuid.v1();

    final result = await addMp3File.call(
      event,
      v4,
      (progress) {
        emit(currentState.copyWith(
          isMp3Loading: IsMp3Loading.loading,
          progressMp3: progress,
        ));
      },
    );

    result.fold(
      (failure) => emit(currentState.copyWith(
        isMp3Loading: IsMp3Loading.error,
        progressMp3: 0.0,
      )),
      (result) => emit(currentState.copyWith(
        beat: currentState.beat.copyWith(
          availableFiles: currentState.beat.availableFiles.copyWith(
            mp3Url: v4,
          ),
        ),
        isMp3Loading: IsMp3Loading.success,
        progressMp3: 1.0,
      )),
    );
  }

  Future<void> _addWavFile(
      AddWavFileEvent event, Emitter<BeatState> emit) async {
    final currentState = state as BeatEditState;

    emit(currentState.copyWith(
      isWavLoading: IsWavLoading.loading,
      progressWav: 0.0,
    ));

    var uuid = const Uuid();
    String v4 = uuid.v1();

    final result = await addWavFile.call(
      event,
      v4,
      (progress) {
        emit(currentState.copyWith(
          isWavLoading: IsWavLoading.loading,
          progressWav: progress,
        ));
      },
    );

    result.fold(
      (failure) => emit(currentState.copyWith(
        isWavLoading: IsWavLoading.error,
        progressWav: 0.0,
      )),
      (result) => emit(currentState.copyWith(
        beat: currentState.beat.copyWith(
          availableFiles: currentState.beat.availableFiles.copyWith(
            wavUrl: v4,
          ),
        ),
        isWavLoading: IsWavLoading.success,
        progressWav: 1.0,
      )),
    );
  }

  Future<void> _addZipFile(
      AddZipFileEvent event, Emitter<BeatState> emit) async {
    final currentState = state as BeatEditState;

    emit(currentState.copyWith(
      isZipLoading: IsZipLoading.loading,
      progressZip: 0.0,
    ));

    var uuid = const Uuid();
    String v4 = uuid.v1();

    final result = await addZipFile.call(
      event,
      v4,
      (progress) {
        emit(currentState.copyWith(
          isZipLoading: IsZipLoading.loading,
          progressZip: progress,
        ));
      },
    );

    result.fold(
      (failure) => emit(currentState.copyWith(
        isZipLoading: IsZipLoading.error,
        progressZip: 0.0,
      )),
      (result) => emit(currentState.copyWith(
        beat: currentState.beat.copyWith(
          availableFiles: currentState.beat.availableFiles.copyWith(
            zipUrl: v4,
          ),
        ),
        isZipLoading: IsZipLoading.success,
        progressZip: 1.0,
      )),
    );
  }

  Future<void> _addCoverFile(
      AddCoverFileEvent event, Emitter<BeatState> emit) async {
    final currentState = state as BeatEditState;

    emit(currentState.copyWith(
      isCoverLoading: IsCoverLoading.loading,
      progressCover: 0.0,
    ));

    var uuid = const Uuid();
    String v4 = uuid.v1();

    final result = await addCoverFile.call(
      event,
      v4,
      (progress) {
        emit(currentState.copyWith(
          isCoverLoading: IsCoverLoading.loading,
          progressCover: progress,
        ));
      },
    );

    result.fold(
      (failure) => emit(currentState.copyWith(
        isCoverLoading: IsCoverLoading.error,
        progressCover: 0.0,
      )),
      (result) => emit(currentState.copyWith(
        beat: currentState.beat.copyWith(urlPicture: v4),
        isCoverLoading: IsCoverLoading.success,
        progressCover: 1.0,
      )),
    );
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

    emit(currentState.copyWith(
        beat: currentState.beat.copyWith(key: event.key)));
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

    final Map<String, dynamic> requestData = {"id": beat.id, "status": "draft"};

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

    if (beat.key.name != "") {
      requestData["keynoteId"] = beat.key.id;
    }

    if (beat.bpm != 0) {
      requestData["bpm"] = beat.bpm;
    }


    try {
      final response = await dio.patch(
        "http://$url:7772/api/unpbeats/saveDraft",
        options: Options(headers: {
          'Content-Type': 'application/json',
        }),
        data: requestData,
      );

      if (response.statusCode == 200) {
        final currentState = state as BeatEditState;


        emit(currentState.copyWith(
          isSavedSuccess: true,
        ));
      }
    } catch (e) {
    }
  }

  Future<void> _publishBeat(
      PublishBeatEvent event, Emitter<BeatState> emit) async {
    final currentState = state as BeatEditState;

    final result = await publishBeat.call(event, currentState.templateLicense);

    result.fold(
      (failure) => emit(currentState.copyWith(
        isBeatPublish: false,
      )),
      (result) => emit(currentState.copyWith(
        isBeatPublish: true,
      )),
    );
  }

  void _publishBeatSuccess(
    PublishBeatSuccess event,
    Emitter<BeatState> emit,
  ) {
    final currentState = state as BeatEditState;

    emit(currentState.copyWith(isBeatPublish: false));
  }

  Future<void> _getDataTemplateLicense(
      GetDataTemplateLicense event, Emitter<BeatState> emit) async {
    final currentState = state as BeatEditState;

    List<LicenseTemplateEntity> license = [];

    final response = await sl<ApiClient>().get(
      "license/allLicenseTemplatesByBeatmakerJWT",
      options: Options(),
    );

    if (response.statusCode == 200) {
      final data = response.data['data'];
      license = (data as List).map<LicenseTemplateEntity>((e) {
        final distributeCopies = int.parse(e['distributeCopies'].toString());
        final audioStreams = int.parse(e['audioStreams'].toString());
        final radioBroadcasting = int.parse(e['radioBroadcasting'].toString());
        final musicVideos = int.parse(e['musicVideos'].toString());

        return LicenseTemplateEntity(
          id: e['id'] as int,
          name: e['name'] as String,
          mp3: bool.parse(e['mp3'].toString()),
          wav: bool.parse(e['wav'].toString()),
          zip: bool.parse(e['zip'].toString()),
          price: 0,
          description: e['description'] as String,
          musicRecording: bool.parse(e['musicRecording'].toString()),
          liveProfit: bool.parse(e['liveProfit'].toString()),
          distributeCopies: distributeCopies,
          unlimDistributeCopies: distributeCopies == -1 ? true : false,
          audioStreams: audioStreams,
          unlimAudioStreams: audioStreams == -1 ? true : false,
          radioBroadcasting: radioBroadcasting,
          unlimRadioBroadcasting: radioBroadcasting == -1 ? true : false,
          musicVideos: musicVideos,
          unlimMusicVideos: musicVideos == -1 ? true : false,
          isActive: false,
        );
      }).toList();

      emit(currentState.copyWith(templateLicense: license));
    }
  }
}
