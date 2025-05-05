import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:vibeat_web/core/usercases/usecase.dart';
import 'package:vibeat_web/features/allBeats/domain/entities/beat_entity.dart';
import 'package:vibeat_web/features/allBeats/domain/usecases/delete_beat.dart';
import 'package:vibeat_web/features/allBeats/domain/usecases/get_all_beats.dart';
import 'package:vibeat_web/features/allBeats/domain/usecases/make_empty_beat.dart';

part 'all_beats_event.dart';
part 'all_beats_state.dart';

class AllBeatBloc extends Bloc<AllBeatEvent, AllBeatState> {
  final GetAllBeats getAllBeats;
  final MakeEmptyBeat makeEmptyBeat;
  final DeleteBeat deleteBeat;

  AllBeatBloc({
    required this.getAllBeats,
    required this.makeEmptyBeat,
    required this.deleteBeat,
  }) : super(const AllBeatState()) {
    on<AllBeatEvent>(_onGetBeta);
    on<MakeEmptyBeatEvent>(_onMakeEmptyBeat);
    on<ResetMakeEmptyBeatSuccessEvent>(_onResetMakeEmptyBeatSuccess);
    on<DeleteBeatEvent>(_deleteBeat);
    on<ResetDeleteBeatSuccessEvent>(_onResetDeleteBeatSuccess);
  }

  Future<void> _onGetBeta(
      AllBeatEvent event, Emitter<AllBeatState> emit) async {
    final result = await getAllBeats(NoParams());

    result.fold(
      (failure) => emit(state.copyWith(
        status: AllBeatsStatus.error,
        errorMessage: failure.message,
      )),
      (beats) => emit(state.copyWith(
        status: AllBeatsStatus.success,
        beats: beats,
      )),
    );
  }

  Future<void> _onMakeEmptyBeat(
      AllBeatEvent event, Emitter<AllBeatState> emit) async {
    final result = await makeEmptyBeat(NoParams());

    result.fold(
      (failure) => emit(state.copyWith(
        status: AllBeatsStatus.error,
        errorMessage: failure.message,
      )),
      (result) => emit(state.copyWith(
        status: AllBeatsStatus.success,
        makeEmptyBeatSuccess: true,
        newBeat: result,
      )),
    );
  }

  void _onResetMakeEmptyBeatSuccess(
    ResetMakeEmptyBeatSuccessEvent event,
    Emitter<AllBeatState> emit,
  ) {
    emit(state.copyWith(
      makeEmptyBeatSuccess: false,
      newBeat: null,
    ));
  }

  void _deleteBeat(
    DeleteBeatEvent event,
    Emitter<AllBeatState> emit,
  ) async {
    final result = await deleteBeat(event.beatId);

    result.fold(
      (failure) => emit(state.copyWith(
        status: AllBeatsStatus.error,
        errorMessage: failure.message,
      )),
      (result) => emit(state.copyWith(
        status: AllBeatsStatus.success,
        deleteBeatSuccess: true,
      )),
    );
  }

  void _onResetDeleteBeatSuccess(
    ResetDeleteBeatSuccessEvent event,
    Emitter<AllBeatState> emit,
  ) {
    emit(state.copyWith(
      deleteBeatSuccess: false,
    ));
  }
}
