import 'package:dartz/dartz.dart';
import 'package:vibeat_web/core/error/failures.dart';
import 'package:vibeat_web/core/usercases/usecase.dart';
import 'package:vibeat_web/features/editBeat/domain/repositories/edit_beat_repositories.dart';
import 'package:vibeat_web/features/editBeat/presentation/bloc/edit_beat_bloc.dart';

class AddZipFile {
  final EditBeatRepository repository;

  AddZipFile(this.repository);

  Future<Either<Failure, bool>> call(
    AddZipFileEvent event,
    String v4,
    void Function(double progress)? onProgress,
  ) async {
    return await repository.addZipFile(event, v4, onProgress);
  }
}
