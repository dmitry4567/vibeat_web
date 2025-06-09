import 'package:dartz/dartz.dart';
import 'package:vibeat_web/core/error/exceptions.dart';
import 'package:vibeat_web/core/error/failures.dart';
import 'package:vibeat_web/core/network/network_info.dart';
import 'package:vibeat_web/features/allLicenses/data/datasource/all_licenses_remote_data_sourse.dart';
import 'package:vibeat_web/features/allLicenses/domain/entities/license_entity.dart';
import 'package:vibeat_web/features/allLicenses/domain/repositories/all_licenses_repositories.dart';

class AllLicensesRepositoryImpl implements AllLicensesRepository {
  final AllLicensesRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AllLicensesRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<LicenseEntity>>> getAllLicenses() async {
    if (await networkInfo.isConnected) {
      try {
        final beats = await remoteDataSource.getAllLicenses();

        return Right(beats
            .map(
              (e) => LicenseEntity(
                id: e.id,
                name: e.name,
                mp3: e.mp3,
                wav: e.wav,
                zip: e.zip,
                description: e.description,
                musicRecording: e.musicRecording,
                liveProfit: e.liveProfit,
                distributeCopies: e.distributeCopies,
                audioStreams: e.audioStreams,
                radioBroadcasting: e.radioBroadcasting,
                musicVideos: e.musicVideos,
              ),
            )
            .toList());
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return Left(ServerFailure('No Internet Connection'));
    }
  }

  @override
  Future<Either<Failure, LicenseEntity>> makeEmptyLicense() async {
    if (await networkInfo.isConnected) {
      try {
        final data = await remoteDataSource.makeEmptyLicense();

        return Right(data);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return Left(ServerFailure('No Internet Connection'));
    }
  }
}
