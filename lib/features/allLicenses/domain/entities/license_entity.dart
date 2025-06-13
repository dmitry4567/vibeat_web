import 'package:equatable/equatable.dart';

class LicenseEntity extends Equatable {
  final int id;
  final String name;
  final bool mp3;
  final bool wav;
  final bool zip;
  final String description;
  final bool musicRecording;
  final bool liveProfit;
  final int distributeCopies;
  final bool unlimDistributeCopies;
  final int audioStreams;
  final bool unlimAudioStreams;
  final int radioBroadcasting;
  final bool unlimRadioBroadcasting;
  final int musicVideos;
  final bool unlimMusicVideos;

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
    required this.unlimDistributeCopies,
    required this.audioStreams,
    required this.unlimAudioStreams,
    required this.radioBroadcasting,
    required this.unlimRadioBroadcasting,
    required this.musicVideos,
    required this.unlimMusicVideos,
  });

  factory LicenseEntity.fromJson(Map<String, dynamic> json) {
    final distributeCopies = int.parse(json['distributeCopies'].toString());
    final audioStreams = int.parse(json['audioStreams'].toString());
    final radioBroadcasting = int.parse(json['radioBroadcasting'].toString());
    final musicVideos = int.parse(json['musicVideos'].toString());

    return LicenseEntity(
      id: json['id'],
      name: json['name'] as String,
      mp3: bool.parse(json['mp3'].toString()),
      wav: bool.parse(json['wav'].toString()),
      zip: bool.parse(json['zip'].toString()),
      description: json['description'] as String,
      musicRecording: bool.parse(json['musicRecording'].toString()),
      liveProfit: bool.parse(json['liveProfit'].toString()),
      distributeCopies: distributeCopies,
      unlimDistributeCopies: distributeCopies == -1 ? true : false,
      audioStreams: audioStreams,
      unlimAudioStreams: audioStreams == -1 ? true : false,
      radioBroadcasting: radioBroadcasting,
      unlimRadioBroadcasting: radioBroadcasting == -1 ? true : false,
      musicVideos: musicVideos,
      unlimMusicVideos: musicVideos == -1 ? true : false,
    );
  }

  LicenseEntity copyWith({
    int? id,
    String? name,
    bool? mp3,
    bool? wav,
    bool? zip,
    String? description,
    bool? musicRecording,
    bool? liveProfit,
    int? distributeCopies,
    bool? unlimDistributeCopies,
    int? audioStreams,
    bool? unlimAudioStreams,
    int? radioBroadcasting,
    bool? unlimRadioBroadcasting,
    int? musicVideos,
    bool? unlimMusicVideos,
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
      unlimDistributeCopies:
          unlimDistributeCopies ?? this.unlimDistributeCopies,
      audioStreams: audioStreams ?? this.audioStreams,
      unlimAudioStreams: unlimAudioStreams ?? this.unlimAudioStreams,
      radioBroadcasting: radioBroadcasting ?? this.radioBroadcasting,
      unlimRadioBroadcasting:
          unlimRadioBroadcasting ?? this.unlimRadioBroadcasting,
      musicVideos: musicVideos ?? this.musicVideos,
      unlimMusicVideos: unlimMusicVideos ?? this.unlimMusicVideos,
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
        unlimDistributeCopies,
        audioStreams,
        unlimAudioStreams,
        radioBroadcasting,
        unlimRadioBroadcasting,
        musicVideos,
        unlimMusicVideos,
      ];
}
