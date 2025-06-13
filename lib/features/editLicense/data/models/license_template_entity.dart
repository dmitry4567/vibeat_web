import 'package:vibeat_web/features/allLicenses/domain/entities/license_entity.dart';

class LicenseTemplateEntity extends LicenseEntity {
  int price = 0;
  bool isActive = false;

  LicenseTemplateEntity({
    required super.id,
    required super.name,
    required super.mp3,
    required super.wav,
    required super.zip,
    required this.price,
    required super.description,
    required super.musicRecording,
    required super.liveProfit,
    required super.distributeCopies,
    required super.unlimDistributeCopies,
    required super.audioStreams,
    required super.unlimAudioStreams,
    required super.radioBroadcasting,
    required super.unlimRadioBroadcasting,
    required super.musicVideos,
    required super.unlimMusicVideos,
    required this.isActive,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        mp3,
        wav,
        zip,
        price,
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
        isActive,
      ];
}
