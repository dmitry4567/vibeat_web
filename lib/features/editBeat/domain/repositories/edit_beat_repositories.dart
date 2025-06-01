import 'package:dartz/dartz.dart';
import 'package:vibeat_web/core/error/failures.dart';
import 'package:vibeat_web/features/editBeat/presentation/bloc/edit_beat_bloc.dart';

abstract class EditBeatRepository {
  Future<Either<Failure, bool>> addMp3File(
    AddMp3FileEvent event,
    String v4,
    void Function(double progress)? onProgress,
  );
  Future<Either<Failure, bool>> addWavFile(
    AddWavFileEvent event,
    String v4,
    void Function(double progress)? onProgress,
  );
  Future<Either<Failure, bool>> addZipFile(
    AddZipFileEvent event,
    String v4,
    void Function(double progress)? onProgress,
  );
  Future<Either<Failure, bool>> addCoverFile(
    AddCoverFileEvent event,
    String v4,
    void Function(double progress)? onProgress,
  );
}
