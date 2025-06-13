import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:vibeat_web/app/injection_container.dart';
import 'package:vibeat_web/features/allLicenses/domain/entities/license_entity.dart';
import 'package:vibeat_web/features/editLicense/data/models/license_template_entity.dart';
import 'package:vibeat_web/features/editLicense/domain/usecases/save_draft_license.dart';

part 'edit_license_template_event.dart';
part 'edit_license_template_state.dart';

class EditLicenseTemplateBloc
    extends Bloc<EditLicenseTemplateEvent, LicenseTemplateState> {
  final dio = Dio();
  final SaveDraftLicense saveDraftLicense;

  EditLicenseTemplateBloc({
    required this.saveDraftLicense,
    required LicenseEntity templateLicense,
  }) : super(EditLicenseTemplateState(
          templateLicense: templateLicense,
          isSavedSuccess: false,
        )) {
    on<ChangeName>(_changeName);
    on<ChangeDescription>(_changeDescription);

    on<UpdateMp3Event>(_updateMp3Event);
    on<UpdateWavEvent>(_updateWavEvent);
    on<UpdateZipEvent>(_updateZipEvent);

    on<UpdateMusicRecordingEvent>(_updateMusicRecordingEvent);
    on<UpdateLiveProfitEvent>(_updateLiveProfitEvent);

    on<UpdateDistributeCopiesEvent>(_updateDistributeCopiesEvent);
    on<UpdateUnlimDistributeCopiesEvent>(_updateUnlimDistributeCopiesEvent);

    on<UpdateAudioStreamsEvent>(_updateAudioStreamsEvent);
    on<UpdateUnlimAudioStreamsEvent>(_updateUnlimAudioStreamsEvent);

    on<UpdateRadioBroadcastingEvent>(_updateRadioBroadcastingEvent);
    on<UpdateUnlimRadioBroadcastingEvent>(_updateUnlimRadioBroadcastingEvent);

    on<UpdateMusicVideosEvent>(_updateMusicVideosEvent);
    on<UpdateUnlimMusicVideosEvent>(_updateUnlimMusicVideosEvent);

    on<SaveDraftLicenseEvent>(_saveDraftLicenseEvent);
  }
  Future<void> _changeName(
      ChangeName event, Emitter<LicenseTemplateState> emit) async {
    final currentState = state as EditLicenseTemplateState;

    emit(currentState.copyWith(
        templateLicense:
            currentState.templateLicense.copyWith(name: event.name)));
  }

  Future<void> _changeDescription(
      ChangeDescription event, Emitter<LicenseTemplateState> emit) async {
    final currentState = state as EditLicenseTemplateState;

    emit(currentState.copyWith(
        templateLicense: currentState.templateLicense
            .copyWith(description: event.description)));
  }

  Future<void> _updateMp3Event(
      UpdateMp3Event event, Emitter<LicenseTemplateState> emit) async {
    final currentState = state as EditLicenseTemplateState;

    emit(
      currentState.copyWith(
        templateLicense:
            currentState.templateLicense.copyWith(mp3: event.value),
      ),
    );
  }

  Future<void> _updateWavEvent(
      UpdateWavEvent event, Emitter<LicenseTemplateState> emit) async {
    final currentState = state as EditLicenseTemplateState;

    emit(
      currentState.copyWith(
        templateLicense:
            currentState.templateLicense.copyWith(wav: event.value),
      ),
    );
  }

  Future<void> _updateZipEvent(
      UpdateZipEvent event, Emitter<LicenseTemplateState> emit) async {
    final currentState = state as EditLicenseTemplateState;

    emit(
      currentState.copyWith(
        templateLicense:
            currentState.templateLicense.copyWith(zip: event.value),
      ),
    );
  }

  Future<void> _updateMusicRecordingEvent(UpdateMusicRecordingEvent event,
      Emitter<LicenseTemplateState> emit) async {
    final currentState = state as EditLicenseTemplateState;

    emit(currentState.copyWith(
      templateLicense: currentState.templateLicense.copyWith(
        musicRecording: event.value,
      ),
    ));
  }

  Future<void> _updateLiveProfitEvent(
      UpdateLiveProfitEvent event, Emitter<LicenseTemplateState> emit) async {
    final currentState = state as EditLicenseTemplateState;

    emit(currentState.copyWith(
      templateLicense: currentState.templateLicense.copyWith(
        liveProfit: event.value,
      ),
    ));
  }

  Future<void> _updateDistributeCopiesEvent(UpdateDistributeCopiesEvent event,
      Emitter<LicenseTemplateState> emit) async {
    final currentState = state as EditLicenseTemplateState;

    emit(currentState.copyWith(
      templateLicense: currentState.templateLicense.copyWith(
        distributeCopies: event.value,
      ),
    ));
  }

  Future<void> _updateUnlimDistributeCopiesEvent(
      UpdateUnlimDistributeCopiesEvent event,
      Emitter<LicenseTemplateState> emit) async {
    final currentState = state as EditLicenseTemplateState;

    emit(currentState.copyWith(
      templateLicense: currentState.templateLicense.copyWith(
        unlimDistributeCopies: event.value,
      ),
    ));
  }

  Future<void> _updateAudioStreamsEvent(
      UpdateAudioStreamsEvent event, Emitter<LicenseTemplateState> emit) async {
    final currentState = state as EditLicenseTemplateState;

    emit(currentState.copyWith(
      templateLicense: currentState.templateLicense.copyWith(
        audioStreams: event.value,
      ),
    ));
  }

  Future<void> _updateUnlimAudioStreamsEvent(UpdateUnlimAudioStreamsEvent event,
      Emitter<LicenseTemplateState> emit) async {
    final currentState = state as EditLicenseTemplateState;

    emit(currentState.copyWith(
      templateLicense: currentState.templateLicense.copyWith(
        unlimAudioStreams: event.value,
      ),
    ));
  }

  Future<void> _updateRadioBroadcastingEvent(UpdateRadioBroadcastingEvent event,
      Emitter<LicenseTemplateState> emit) async {
    final currentState = state as EditLicenseTemplateState;

    emit(currentState.copyWith(
      templateLicense: currentState.templateLicense.copyWith(
        radioBroadcasting: event.value,
      ),
    ));
  }

  Future<void> _updateUnlimRadioBroadcastingEvent(
      UpdateUnlimRadioBroadcastingEvent event,
      Emitter<LicenseTemplateState> emit) async {
    final currentState = state as EditLicenseTemplateState;

    emit(currentState.copyWith(
      templateLicense: currentState.templateLicense.copyWith(
        unlimRadioBroadcasting: event.value,
      ),
    ));
  }

  Future<void> _updateMusicVideosEvent(
      UpdateMusicVideosEvent event, Emitter<LicenseTemplateState> emit) async {
    final currentState = state as EditLicenseTemplateState;

    emit(currentState.copyWith(
      templateLicense: currentState.templateLicense.copyWith(
        musicVideos: event.value,
      ),
    ));
  }

  Future<void> _updateUnlimMusicVideosEvent(UpdateUnlimMusicVideosEvent event,
      Emitter<LicenseTemplateState> emit) async {
    final currentState = state as EditLicenseTemplateState;

    emit(currentState.copyWith(
      templateLicense: currentState.templateLicense.copyWith(
        unlimMusicVideos: event.value,
      ),
    ));
  }

  Future<void> _saveDraftLicenseEvent(
      SaveDraftLicenseEvent event, Emitter<LicenseTemplateState> emit) async {
    final currentState = state as EditLicenseTemplateState;

    final result = await saveDraftLicense.call(currentState.templateLicense);

    result.fold(
      (failure) => emit(currentState.copyWith(
        isSavedSuccess: false,
      )),
      (result) => emit(currentState.copyWith(
        isSavedSuccess: true,
      )),
    );

    // final templateLicense = currentState.templateLicense;

    // final Map<String, dynamic> requestData = {"id": templateLicense.id};

    // requestData["name"] = templateLicense.name;

    // requestData["description"] = templateLicense.description;

    // requestData["mp3"] = templateLicense.mp3;
    // requestData["wav"] = templateLicense.wav;
    // requestData["zip"] = templateLicense.zip;

    // requestData["liveProfit"] = templateLicense.liveProfit;
    // requestData["musicRecording"] = templateLicense.musicRecording;

    // if (templateLicense.unlimDistributeCopies == true) {
    //   requestData["distributeCopies"] = -1;
    // } else {
    //   requestData["distributeCopies"] = templateLicense.distributeCopies;
    // }

    // if (templateLicense.unlimAudioStreams == true) {
    //   requestData["audioStreams"] = -1;
    // } else {
    //   requestData["audioStreams"] = templateLicense.audioStreams;
    // }

    // if (templateLicense.unlimRadioBroadcasting == true) {
    //   requestData["radioBroadcasting"] = -1;
    // } else {
    //   requestData["radioBroadcasting"] = templateLicense.radioBroadcasting;
    // }

    // if (templateLicense.unlimMusicVideos == true) {
    //   requestData["musicVideos"] = -1;
    // } else {
    //   requestData["musicVideos"] = templateLicense.musicVideos;
    // }

    // try {
    //   final response = await dio.patch(
    //     "http://$url:7775/api/license/licenseTemplate",
    //     options: Options(headers: {
    //       'Content-Type': 'application/json',
    //       'Authorization':
    //           'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3NTAwNjk1NzksImlhdCI6MTc0OTgxMDM3OSwiaWQiOiIwMTk2ZGUzOC1iODJlLTc0YWYtOWRkOC1lZDU2YzkxZjFlMWYiLCJyb2xlIjoyLCJ1c2VybmFtZSI6IiJ9.6j76FpxRSu1Z7hvCKzbp_Es42spd9YJlKrt4o_FppWM'
    //     }),
    //     data: requestData,
    //   );

    //   if (response.statusCode == 200) {
    //     final currentState = state as EditLicenseTemplateState;

    //     log("update license");

    //     emit(currentState.copyWith(
    //       isSavedSuccess: true,
    //     ));
    //   }
    // } catch (e) {
    //   log(e.toString());
    // }
  }
}
