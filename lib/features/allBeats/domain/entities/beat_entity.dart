import 'package:equatable/equatable.dart';
import 'package:vibeat_web/features/allBeats/data/models/beat_model.dart';

class BeatEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final String urlPicture;
  final List<TagEntity> tags;
  final List<GenreEntity> genres;
  final List<MoodEntity> moods;
  final KeyEntity key;
  final StatusBeat status;
  final AvailableFilesEntity availableFiles;
  final int bpm;
  final int createdAt;

  const BeatEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.urlPicture,
    required this.tags,
    required this.genres,
    required this.key,
    required this.moods,
    required this.status,
    required this.availableFiles,
    required this.bpm,
    required this.createdAt,
  });

  factory BeatEntity.fromJson(Map<String, dynamic> json) {
    return BeatEntity(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      urlPicture: json['picture'] as String,
      tags: (json['tags'] as List<dynamic>?)
              ?.map((tag) => TagEntity.fromJson(tag as Map<String, dynamic>))
              .toList() ??
          [],
      genres: (json['genres'] as List<dynamic>?)
              ?.map((genre) =>
                  GenreEntity.fromJson(genre as Map<String, dynamic>))
              .toList() ??
          [],
      moods: (json['moods'] as List<dynamic>?)
              ?.map((mood) => MoodEntity.fromJson(mood as Map<String, dynamic>))
              .toList() ??
          [],
      key: KeyEntity.fromJson(
        json['key'] as Map<String, dynamic>,
      ),
      status: StatusBeat.values
          .firstWhere((e) => e.toString() == 'StatusBeat.${json['status']}'),
      availableFiles: AvailableFilesEntity.fromJson(
        json['AvailableFiles'] as Map<String, dynamic>,
      ),
      bpm: json['bpm'] as int,
      createdAt: json['createdAt'] as int,
    );
  }
  BeatEntity copyWith({
    String? id,
    String? name,
    String? description,
    String? urlPicture,
    List<TagEntity>? tags,
    List<GenreEntity>? genres,
    List<MoodEntity>? moods,
    KeyEntity? key,
    StatusBeat? status,
    AvailableFilesEntity? availableFiles,
    int? bpm,
    int? createdAt,
  }) {
    return BeatEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      urlPicture: urlPicture ?? this.urlPicture,
      tags: tags ?? this.tags,
      genres: genres ?? this.genres,
      moods: moods ?? this.moods,
      key: key ?? this.key,
      status: status ?? this.status,
      availableFiles: availableFiles ?? this.availableFiles,
      bpm: bpm ?? this.bpm,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        urlPicture,
        tags,
        genres,
        moods,
        key,
        status,
        availableFiles,
        bpm,
        createdAt,
      ];
}

class AvailableFilesEntity extends Equatable {
  final String id;
  final String mp3Url;
  final String wavUrl;
  final String zipUrl;

  const AvailableFilesEntity({
    required this.id,
    required this.mp3Url,
    required this.wavUrl,
    required this.zipUrl,
  });

  static AvailableFilesEntity fromJson(Map<String, dynamic> json) {
    return AvailableFilesEntity(
      id: json['ID'] as String,
      mp3Url: json['MP3Url'] as String,
      wavUrl: json['WAVUrl'] as String,
      zipUrl: json['ZIPUrl'] as String,
    );
  }

  AvailableFilesEntity copyWith({
    String? id,
    String? mp3Url,
    String? wavUrl,
    String? zipUrl,
  }) {
    return AvailableFilesEntity(
      id: id ?? this.id,
      mp3Url: mp3Url ?? this.mp3Url,
      wavUrl: wavUrl ?? this.wavUrl,
      zipUrl: zipUrl ?? this.zipUrl,
    );
  }

  @override
  List<Object?> get props => [
        id,
        mp3Url,
        wavUrl,
        zipUrl,
      ];
}

class TagEntity {
  final int id;
  final String name;

  const TagEntity({required this.id, required this.name});

  static TagEntity fromJson(Map<String, dynamic> json) {
    return TagEntity(
      id: json['ID'] as int,
      name: json['Name'] as String,
    );
  }
}

class GenreEntity {
  final int id;
  final String name;

  const GenreEntity({required this.id, required this.name});

  static GenreEntity fromJson(Map<String, dynamic> json) {
    return GenreEntity(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }
}

class MoodEntity {
  final int id;
  final String name;

  const MoodEntity({required this.id, required this.name});

  static MoodEntity fromJson(Map<String, dynamic> json) {
    return MoodEntity(
      id: json['ID'] as int,
      name: json['Name'] as String,
    );
  }
}

class KeyEntity {
  final int id;
  final String name;

  const KeyEntity({required this.id, required this.name});

  static KeyEntity fromJson(Map<String, dynamic> json) {
    return KeyEntity(
      id: json['ID'] as int,
      name: json['Name'] as String,
    );
  }
}

class TimeStampEntity {
  final String name;
  final String from;
  final String to;

  const TimeStampEntity(
      {required this.name, required this.from, required this.to});

  static TimeStampEntity fromJson(Map<String, dynamic> json) {
    return TimeStampEntity(
      name: json['name'] as String,
      from: json['from'] as String,
      to: json['to'] as String,
    );
  }
}

class InstrumentEntity {
  final String id;
  final String name;

  const InstrumentEntity({required this.id, required this.name});

  static InstrumentEntity fromJson(Map<String, dynamic> json) {
    return InstrumentEntity(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }
}
