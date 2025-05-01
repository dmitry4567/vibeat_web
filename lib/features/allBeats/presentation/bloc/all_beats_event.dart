part of 'all_beats_bloc.dart';

abstract class AllBeatEvent extends Equatable {
  const AllBeatEvent();

  @override
  List<Object> get props => [];
}

class GetAllBeatEvent extends AllBeatEvent {}

class MakeEmptyBeatEvent extends AllBeatEvent {}

class ResetMakeEmptyBeatSuccessEvent extends AllBeatEvent {}