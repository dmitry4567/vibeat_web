import 'package:dartz/dartz.dart';
import 'package:vibeat_web/core/error/exceptions.dart';
import 'package:vibeat_web/core/error/failures.dart';
import 'package:vibeat_web/core/network/network_info.dart';
import 'package:vibeat_web/features/allBeats/domain/entities/beat_entity.dart';
import 'package:vibeat_web/features/editBeat/data/datasource/edit_beat_remote_data_sourse.dart';
import 'package:vibeat_web/features/editBeat/domain/repositories/edit_beat_repositories.dart';
import 'package:vibeat_web/features/editBeat/presentation/bloc/edit_beat_bloc.dart';

class EditBeatRepositoryImpl implements EditBeatRepository {
  final EditBeatRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  EditBeatRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, bool>> addMp3File(
    AddMp3FileEvent event,
    String v4,
    void Function(double progress)? onProgress,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.addMp3File(
          event,
          v4,
          onProgress: onProgress,
        );
        return Right(result);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return Left(ServerFailure('No Internet Connection'));
    }
  }

  @override
  Future<Either<Failure, bool>> addWavFile(
    AddWavFileEvent event,
    String v4,
    void Function(double progress)? onProgress,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.addWavFile(
          event,
          v4,
          onProgress: onProgress,
        );
        return Right(result);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return Left(ServerFailure('No Internet Connection'));
    }
  }

  @override
  Future<Either<Failure, bool>> addZipFile(
    AddZipFileEvent event,
    String v4,
    void Function(double progress)? onProgress,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.addZipFile(
          event,
          v4,
          onProgress: onProgress,
        );
        return Right(result);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return Left(ServerFailure('No Internet Connection'));
    }
  }

  @override
  Future<Either<Failure, bool>> addCoverFile(
    AddCoverFileEvent event,
    String v4,
    void Function(double progress)? onProgress,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.addCoverFile(
          event,
          v4,
          onProgress: onProgress,
        );
        return Right(result);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return Left(ServerFailure('No Internet Connection'));
    }
  }
}
