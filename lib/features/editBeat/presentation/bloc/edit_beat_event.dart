part of 'edit_beat_bloc.dart';

abstract class EditBeatEvent extends Equatable {
  const EditBeatEvent();

  @override
  List<Object> get props => [];
}

class AddMp3FileEvent extends EditBeatEvent {
  final String beatId;
  final PlatformFile file;

  const AddMp3FileEvent({required this.beatId, required this.file});
}

class AddWavFileEvent extends EditBeatEvent {
  final String beatId;
  final PlatformFile file;

  const AddWavFileEvent({required this.beatId, required this.file});
}

class AddZipFileEvent extends EditBeatEvent {
  final String beatId;
  final PlatformFile file;

  const AddZipFileEvent({required this.beatId, required this.file});
}

class AddCoverFileEvent extends EditBeatEvent {
  final String beatId;
  final PlatformFile file;

  const AddCoverFileEvent({required this.beatId, required this.file});
}

class ChangeName extends EditBeatEvent {
  final String name;

  const ChangeName({required this.name});
}

class ChangeDescription extends EditBeatEvent {
  final String description;

  const ChangeDescription({required this.description});
}

class ChangeTags extends EditBeatEvent {
  final List<TagEntity> tags;

  const ChangeTags({required this.tags});
}

class ChangeGenres extends EditBeatEvent {
  final List<GenreEntity> genres;

  const ChangeGenres({required this.genres});
}

class ChangeMoods extends EditBeatEvent {
  final List<MoodEntity> moods;

  const ChangeMoods({required this.moods});
}

class ChangeKey extends EditBeatEvent {
  final KeyEntity key;

  const ChangeKey({required this.key});
}

class ChangeBpm extends EditBeatEvent {
  final int bpm;

  const ChangeBpm({required this.bpm});
}

class SaveDraft extends EditBeatEvent {
  const SaveDraft();
}

class PublishBeatEvent extends EditBeatEvent {
  final String beatId;

  const PublishBeatEvent({required this.beatId});
}

class PublishBeatSuccess extends EditBeatEvent {
  const PublishBeatSuccess();
}
