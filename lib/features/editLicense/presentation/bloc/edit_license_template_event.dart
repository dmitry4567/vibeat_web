part of 'edit_license_template_bloc.dart';

sealed class EditLicenseTemplateEvent extends Equatable {
  const EditLicenseTemplateEvent();

  @override
  List<Object> get props => [];
}

class ChangeName extends EditLicenseTemplateEvent {
  final String name;

  const ChangeName({required this.name});
}

class ChangeDescription extends EditLicenseTemplateEvent {
  final String description;

  const ChangeDescription({required this.description});
}

class UpdateMp3Event extends EditLicenseTemplateEvent {
  final bool value;
  const UpdateMp3Event(this.value);

  @override
  List<Object> get props => [value];
}

class UpdateWavEvent extends EditLicenseTemplateEvent {
  final bool value;
  const UpdateWavEvent(this.value);

  @override
  List<Object> get props => [value];
}

class UpdateZipEvent extends EditLicenseTemplateEvent {
  final bool value;
  const UpdateZipEvent(this.value);

  @override
  List<Object> get props => [value];
}

class UpdateMusicRecordingEvent extends EditLicenseTemplateEvent {
  final bool value;
  const UpdateMusicRecordingEvent(this.value);

  @override
  List<Object> get props => [value];
}

class UpdateLiveProfitEvent extends EditLicenseTemplateEvent {
  final bool value;
  const UpdateLiveProfitEvent(this.value);

  @override
  List<Object> get props => [value];
}

class UpdateDistributeCopiesEvent extends EditLicenseTemplateEvent {
  final int value;
  const UpdateDistributeCopiesEvent(this.value);

  @override
  List<Object> get props => [value];
}

class UpdateUnlimDistributeCopiesEvent extends EditLicenseTemplateEvent {
  final bool value;
  const UpdateUnlimDistributeCopiesEvent(this.value);

  @override
  List<Object> get props => [value];
}

class UpdateAudioStreamsEvent extends EditLicenseTemplateEvent {
  final int value;
  const UpdateAudioStreamsEvent(this.value);

  @override
  List<Object> get props => [value];
}

class UpdateUnlimAudioStreamsEvent extends EditLicenseTemplateEvent {
  final bool value;
  const UpdateUnlimAudioStreamsEvent(this.value);

  @override
  List<Object> get props => [value];
}

class UpdateRadioBroadcastingEvent extends EditLicenseTemplateEvent {
  final int value;
  const UpdateRadioBroadcastingEvent(this.value);

  @override
  List<Object> get props => [value];
}

class UpdateUnlimRadioBroadcastingEvent extends EditLicenseTemplateEvent {
  final bool value;
  const UpdateUnlimRadioBroadcastingEvent(this.value);

  @override
  List<Object> get props => [value];
}

class UpdateMusicVideosEvent extends EditLicenseTemplateEvent {
  final int value;
  const UpdateMusicVideosEvent(this.value);

  @override
  List<Object> get props => [value];
}

class UpdateUnlimMusicVideosEvent extends EditLicenseTemplateEvent {
  final bool value;
  const UpdateUnlimMusicVideosEvent(this.value);

  @override
  List<Object> get props => [value];
}

class SaveDraftLicenseEvent extends EditLicenseTemplateEvent {
  const SaveDraftLicenseEvent();

  @override
  List<Object> get props => [];
}
