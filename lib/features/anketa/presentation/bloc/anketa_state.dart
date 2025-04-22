part of 'anketa_bloc.dart';

enum AnketaStatus { initial, loading, success, error }

class AnketaState extends Equatable {
  final AnketaStatus status;
  final List<AnketaEntity>? anketa;
  final List<AnketaEntity>? selectedGenres;
  final String? errorMessage;
  final bool? isResponseSuccess;

  const AnketaState({
    this.status = AnketaStatus.initial,
    this.anketa,
    this.selectedGenres = const [],
    this.errorMessage,
    this.isResponseSuccess,
  });

  AnketaState copyWith({
    AnketaStatus? status,
    List<AnketaEntity>? anketa,
    List<AnketaEntity>? selectedGenres,
    String? errorMessage,
    bool? isResponseSuccess,
  }) {
    return AnketaState(
      status: status ?? this.status,
      anketa: anketa ?? this.anketa,
      selectedGenres: selectedGenres ?? this.selectedGenres,
      errorMessage: errorMessage ?? this.errorMessage,
      isResponseSuccess: isResponseSuccess ?? this.isResponseSuccess,
    );
  }

  @override
  List<Object?> get props =>
      [status, anketa, selectedGenres, errorMessage, isResponseSuccess];
}
