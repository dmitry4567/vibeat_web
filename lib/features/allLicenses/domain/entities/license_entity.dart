import 'package:equatable/equatable.dart';

class LicenseEntity extends Equatable {
  final String id;
  final String name;
  final bool mp3;
  final bool wav;
  final bool zip;
  final String description;
  final bool musicRecording;
  final bool liveProfit;
  final int distributeCopies;
  final int audioStreams;
  final int radioBroadcasting;
  final int musicVideos;

  const LicenseEntity({
    required this.id,
    required this.name,
    required this.mp3,
    required this.wav,
    required this.zip,
    required this.description,
    required this.musicRecording,
    required this.liveProfit,
    required this.distributeCopies,
    required this.audioStreams,
    required this.radioBroadcasting,
    required this.musicVideos,
  });

  factory LicenseEntity.fromJson(Map<String, dynamic> json) {
    return LicenseEntity(
      id: json['id'] as String,
      name: json['name'] as String,
      mp3: bool.parse(json['mp3']),
      wav: bool.parse(json['wav']),
      zip: bool.parse(json['zip']),
      description: json['description'] as String,
      musicRecording: bool.parse(json['musicRecording']),
      liveProfit: bool.parse(json['liveProfit']),
      distributeCopies: int.parse(json['distributeCopies']),
      audioStreams: int.parse(json['audioStreams']),
      radioBroadcasting: int.parse(json['radioBroadcasting']),
      musicVideos: int.parse(json['musicVideos']),
    );
  }
  LicenseEntity copyWith({
    String? id,
    String? name,
    bool? mp3,
    bool? wav,
    bool? zip,
    String? description,
    bool? musicRecording,
    bool? liveProfit,
    int? distributeCopies,
    int? audioStreams,
    int? radioBroadcasting,
    int? musicVideos,
  }) {
    return LicenseEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      mp3: mp3 ?? this.mp3,
      wav: wav ?? this.wav,
      zip: zip ?? this.zip,
      description: description ?? this.description,
      musicRecording: musicRecording ?? this.musicRecording,
      liveProfit: liveProfit ?? this.liveProfit,
      distributeCopies: distributeCopies ?? this.distributeCopies,
      audioStreams: audioStreams ?? this.audioStreams,
      radioBroadcasting: radioBroadcasting ?? this.radioBroadcasting,
      musicVideos: musicVideos ?? this.musicVideos,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        mp3,
        wav,
        zip,
        description,
        musicRecording,
        liveProfit,
        distributeCopies,
        audioStreams,
        radioBroadcasting,
        musicVideos,
      ];
}
