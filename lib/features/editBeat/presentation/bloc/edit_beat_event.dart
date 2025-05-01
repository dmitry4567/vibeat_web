part of 'edit_beat_bloc.dart';

abstract class EditBeatEvent extends Equatable {
  const EditBeatEvent();

  @override
  List<Object> get props => [];
}

class AddMp3File extends EditBeatEvent {
  final String beatId;
  final PlatformFile file;

  const AddMp3File({required this.beatId, required this.file});
}

class AddWavFile extends EditBeatEvent {
  final String beatId;
  final PlatformFile file;

  const AddWavFile({required this.beatId, required this.file});
}

class AddZipFile extends EditBeatEvent {
  final String beatId;
  final PlatformFile file;

  const AddZipFile({required this.beatId, required this.file});
}

class AddCoverFile extends EditBeatEvent {
  final String beatId;
  final PlatformFile file;

  const AddCoverFile({required this.beatId, required this.file});
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
  final int key;

  const ChangeKey({required this.key});
}

class ChangeBpm extends EditBeatEvent {
  final int bpm;

  const ChangeBpm({required this.bpm});
}

class SaveDraft extends EditBeatEvent {
  const SaveDraft();
}
