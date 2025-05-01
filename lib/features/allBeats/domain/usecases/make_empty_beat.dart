import 'package:dartz/dartz.dart';
import 'package:vibeat_web/core/error/failures.dart';
import 'package:vibeat_web/core/usercases/usecase.dart';
import 'package:vibeat_web/features/allBeats/domain/entities/beat_entity.dart';
import 'package:vibeat_web/features/allBeats/domain/repositories/all_beats_repositories.dart';

class MakeEmptyBeat {
  final AllBeatRepository repository;

  MakeEmptyBeat(this.repository);

  Future<Either<Failure, BeatEntity>> call(NoParams params) async {
    return await repository.makeEmptyBeat();
  }
}
