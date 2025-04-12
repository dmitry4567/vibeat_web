part of 'anketa_bloc.dart';

abstract class AnketaEvent extends Equatable {
  const AnketaEvent();

  @override
  List<Object> get props => [];
}

class GetAnketaEvent extends AnketaEvent {}

class AddGenreEvent extends AnketaEvent {
  final AnketaEntity genre;

  const AddGenreEvent({required this.genre});

  @override
  List<Object> get props => [genre];
}

class SendAnketaResponseEvent extends AnketaEvent {
  const SendAnketaResponseEvent();

  @override
  List<Object> get props => [];
}
