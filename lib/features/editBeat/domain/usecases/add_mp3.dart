import 'package:dartz/dartz.dart';
import 'package:vibeat_web/core/error/failures.dart';
import 'package:vibeat_web/core/usercases/usecase.dart';
import 'package:vibeat_web/features/editBeat/domain/repositories/edit_beat_repositories.dart';
import 'package:vibeat_web/features/editBeat/presentation/bloc/edit_beat_bloc.dart';

class AddMp3File {
  final EditBeatRepository repository;

  AddMp3File(this.repository);

  Future<Either<Failure, bool>> call(
    AddMp3FileEvent event,
    String v4,
    void Function(double progress)? onProgress,
  ) async {
    return await repository.addMp3File(event, v4, onProgress);
  }
}
