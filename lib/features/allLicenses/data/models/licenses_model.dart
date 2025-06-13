class LicenseModel {
  final int id;
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

  const LicenseModel({
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

  factory LicenseModel.fromJson(Map<String, dynamic> json) {
    return LicenseModel(
      id: json['id'] as int,
      name: json['name'] as String,
      mp3: bool.parse(json['mp3'].toString()),
      wav: bool.parse(json['wav'].toString()),
      zip: bool.parse(json['zip'].toString()),
      description: json['description'] as String,
      musicRecording: bool.parse(json['musicRecording'].toString()),
      liveProfit: bool.parse(json['liveProfit'].toString()),
      distributeCopies: int.parse(json['distributeCopies'].toString()),
      audioStreams: int.parse(json['audioStreams'].toString()),
      radioBroadcasting: int.parse(json['radioBroadcasting'].toString()),
      musicVideos: int.parse(json['musicVideos'].toString()),
    );
  }
}
