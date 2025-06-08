import 'package:dartz/dartz.dart';
import '../entities/beat_entity.dart';
import '../../../../core/error/failures.dart';

abstract class AllBeatRepository {
  Future<Either<Failure, List<BeatEntity>>> getAllBeats();
  Future<Either<Failure, BeatEntity>> makeEmptyBeat();
  Future<Either<Failure, bool>> deleteBeat(String beatId);
}
