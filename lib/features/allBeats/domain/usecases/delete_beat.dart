import 'package:dartz/dartz.dart';
import 'package:vibeat_web/core/error/failures.dart';
import 'package:vibeat_web/features/allBeats/domain/repositories/all_beats_repositories.dart';

class DeleteBeat {
  final AllBeatRepository repository;

  DeleteBeat(this.repository);

  Future<Either<Failure, bool>> call(String beatId) async {
    return await repository.deleteBeat(beatId);
  }
}
