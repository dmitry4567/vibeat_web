class BeatModel {
  final String id;
  final String name;
  final String description;
  final String urlPicture;
  // final String beatmakerId;
  final AvailableFiles availableFiles;
  // final String urlBeat;
  // final int price;
  final List<Tag> tags;
  final int bpm;
  // final String description;
  final List<Genre> genres;
  final List<Mood> moods;
  final KeyModel key;
  // final int keynoteId;
  // final List<TimeStamp> timestamps;
  // final List<Instrument> instruments;
  final StatusBeat status;
  final int createdAt;

  const BeatModel({
    required this.id,
    required this.name,
    required this.description,
    required this.urlPicture,
    // required this.beatmakerId,
    required this.availableFiles,
    // required this.urlBeat,
    // required this.price,
    required this.tags,
    required this.bpm,
    // required this.description,
    required this.genres,
    required this.moods,
    required this.key,
    // required this.keynoteId,
    // required this.timestamps,
    // required this.instruments,
    required this.status,
    required this.createdAt
  });

  factory BeatModel.fromJson(Map<String, dynamic> json) {
    return BeatModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      urlPicture: json['picture'] as String,
      // name: "cfb",
      // urlPicture: "fsefsef",
      // beatmakerId: json['beatmakerId'] as String,
      availableFiles: AvailableFiles.fromJson(
          json['AvailableFiles'] as Map<String, dynamic>),
      // urlBeat: json['url'] as String,
      // price: json['price'] as int,
      tags: (json['tags'] as List<dynamic>)
          .map((tag) => Tag.fromJson(tag))
          .toList(),
      bpm: json['bpm'] as int,
      // description: json['description'] as String,
      genres: (json['genres'] as List<dynamic>)
          .map((genre) => Genre.fromJson(genre as Map<String, dynamic>))
          .toList(),
      moods: (json['moods'] as List<dynamic>)
          .map((mood) => Mood.fromJson(mood as Map<String, dynamic>))
          .toList(),
      key: KeyModel.fromJson(
          json['key'] as Map<String, dynamic>),
      // keynoteId: json['keynoteId'] as int,
      // timestamps: (json['timestamps'] as List<dynamic>)
      //     .map((ts) => TimeStamp.fromJson(ts as Map<String, dynamic>))
      //     .toList(),
      // instruments: (json['instruments'] as List<dynamic>)
      //     .map((instrument) =>
      //         Instrument.fromJson(instrument as Map<String, dynamic>))
      //     .toList(),
      status: StatusBeat.values
          .firstWhere((e) => e.toString() == 'StatusBeat.${json['status']}'),
      createdAt: json['created_at'] as int,
    );
  }
}

class AvailableFiles {
  final String id;
  final String mp3Url;
  final String wavUrl;
  final String zipUrl;

  const AvailableFiles({
    required this.id,
    required this.mp3Url,
    required this.wavUrl,
    required this.zipUrl,
  });

  static AvailableFiles fromJson(Map<String, dynamic> json) {
    return AvailableFiles(
      id: json['id'] as String,
      mp3Url: json['mp3Url'] as String,
      wavUrl: json['wavUrl'] as String,
      zipUrl: json['zipUrl'] as String,
    );
  }
}

class Tag {
  final int id;
  final String name;

  const Tag({required this.id, required this.name});

  static Tag fromJson(Map<String, dynamic> json) {
    return Tag(
      id: json['ID'] as int,
      name: json['Name'] as String,
    );
  }
}

class Genre {
  final int id;
  final String name;

  const Genre({required this.id, required this.name});

  static Genre fromJson(Map<String, dynamic> json) {
    return Genre(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }
}

class Mood {
  final int id;
  final String name;

  const Mood({required this.id, required this.name});

  static Mood fromJson(Map<String, dynamic> json) {
    return Mood(
      id: json['ID'] as int,
      name: json['Name'] as String,
    );
  }
}

class KeyModel {
  final int id;
  final String name;

  const KeyModel({required this.id, required this.name});

  static KeyModel fromJson(Map<String, dynamic> json) {
    return KeyModel(
      id: json['ID'] as int,
      name: json['Name'] as String,
    );
  }
}

class TimeStamp {
  final String from;
  final String to;

  const TimeStamp({required this.from, required this.to});

  static TimeStamp fromJson(Map<String, dynamic> json) {
    return TimeStamp(
      from: json['from'] as String,
      to: json['to'] as String,
    );
  }
}

class Instrument {
  final String id;
  final String name;

  const Instrument({required this.id, required this.name});

  static Instrument fromJson(Map<String, dynamic> json) {
    return Instrument(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }
}

enum StatusBeat { draft, published }
