part of 'all_beats_bloc.dart';

enum AllBeatsStatus { initial, loading, success, error }

class AllBeatState extends Equatable {
  final AllBeatsStatus? status;
  final List<BeatEntity>? beats;
  final bool? makeEmptyBeatSuccess;
  final bool? deleteBeatSuccess;
  final String? errorMessage;
  final BeatEntity? newBeat;

  const AllBeatState({
    this.status,
    this.beats,
    this.makeEmptyBeatSuccess,
    this.deleteBeatSuccess,
    this.errorMessage,
    this.newBeat,
  });

  AllBeatState copyWith({
    AllBeatsStatus? status,
    List<BeatEntity>? beats,
    bool? makeEmptyBeatSuccess,
    bool? deleteBeatSuccess,
    String? errorMessage,
    BeatEntity? newBeat,
  }) {
    return AllBeatState(
      status: status ?? this.status,
      beats: beats ?? this.beats,
      makeEmptyBeatSuccess: makeEmptyBeatSuccess ?? this.makeEmptyBeatSuccess,
      deleteBeatSuccess: deleteBeatSuccess ?? this.deleteBeatSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      newBeat: newBeat ?? this.newBeat,
    );
  }

  @override
  List<Object?> get props => [
        status,
        beats,
        makeEmptyBeatSuccess,
        deleteBeatSuccess,
        errorMessage,
        newBeat,
      ];
}
