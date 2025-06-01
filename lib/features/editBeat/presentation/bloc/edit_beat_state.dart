// part of 'edit_beat_bloc.dart';

// enum EditBeatsStatus { initial, loading, success, error }

// class EditBeatState extends Equatable {
//   final EditBeatsStatus? status;
//   final String? errorMessage;
//   final BeatEntity? beat;

//   const EditBeatState({
//     this.status,
//     this.errorMessage,
//     this.beat,
//   });

//   EditBeatState copyWith({
//     EditBeatsStatus? status,
//     String? errorMessage,
//     BeatEntity? beat,
//   }) {
//     return EditBeatState(
//       status: status ?? this.status,
//       errorMessage: errorMessage ?? this.errorMessage,
//       beat: beat ?? this.beat,
//     );
//   }

//   @override
//   List<Object?> get props => [
//         status,
//         errorMessage,
//         beat,
//       ];
// }

part of 'edit_beat_bloc.dart';

enum IsMp3Loading { initial, loading, success, error }

enum IsWavLoading { initial, loading, success, error }

enum IsZipLoading { initial, loading, success, error }

enum IsCoverLoading { initial, loading, success, error }

sealed class BeatState extends Equatable {
  @override
  List<Object?> get props => [];
}

class BeatViewState extends BeatState {
  final BeatEntity beat;

  BeatViewState(this.beat);
}

class BeatEditState extends BeatState {
  final BeatEntity beat;

  final IsMp3Loading isMp3Loading;
  final double progressMp3;

  final IsWavLoading isWavLoading;
  final double progressWav;

  final IsZipLoading isZipLoading;
  final double progressZip;

  final IsCoverLoading isCoverLoading;
  final double progressCover;

  final bool isSavedSuccess;
  final bool isBeatPublish;

  BeatEditState({
    required this.beat,
    required this.isMp3Loading,
    required this.progressMp3,
    required this.isWavLoading,
    required this.progressWav,
    required this.isZipLoading,
    required this.progressZip,
    required this.isCoverLoading,
    required this.progressCover,
    required this.isSavedSuccess,
    required this.isBeatPublish
  });

  BeatEditState copyWith({
    BeatEntity? beat,
    IsMp3Loading? isMp3Loading,
    double? progressMp3,
    IsWavLoading? isWavLoading,
    double? progressWav,
    IsZipLoading? isZipLoading,
    double? progressZip,
    IsCoverLoading? isCoverLoading,
    double? progressCover,
    bool? isSavedSuccess,
    bool? isBeatPublish,
  }) {
    return BeatEditState(
      beat: beat ?? this.beat,
      isMp3Loading: isMp3Loading ?? this.isMp3Loading,
      progressMp3: progressMp3 ?? this.progressMp3,
      isWavLoading: isWavLoading ?? this.isWavLoading,
      progressWav: progressWav ?? this.progressWav,
      isZipLoading: isZipLoading ?? this.isZipLoading,
      progressZip: progressZip ?? this.progressZip,
      isCoverLoading: isCoverLoading ?? this.isCoverLoading,
      progressCover: progressCover ?? this.progressCover,
      isSavedSuccess: isSavedSuccess ?? this.isSavedSuccess,
      isBeatPublish: isBeatPublish ?? this.isBeatPublish
    );
  }

  @override
  List<Object?> get props => [
        beat,
        isMp3Loading,
        progressMp3,
        isWavLoading,
        progressWav,
        isZipLoading,
        progressZip,
        isCoverLoading,
        progressCover,
        isSavedSuccess,
        isBeatPublish
      ];
}

class BeatLoadingState extends BeatState {}

class BeatErrorState extends BeatState {
  final String message;

  BeatErrorState(this.message);
}
