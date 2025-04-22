import 'package:dartz/dartz.dart';
import 'package:vibeat_web/core/error/exceptions.dart';
import 'package:vibeat_web/core/error/failures.dart';
import 'package:vibeat_web/core/network/network_info.dart';
import 'package:vibeat_web/features/anketa/data/datasource/anketa_remote_data_sourse.dart';
import 'package:vibeat_web/features/anketa/domain/entities/anketa_entity.dart';
import 'package:vibeat_web/features/anketa/domain/repositories/anketa_repositories.dart';

class AnketaRepositoryImpl implements AnketaRepository {
  final AnketaRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AnketaRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<AnketaEntity>>> getAnketa() async {
    if (await networkInfo.isConnected) {
      try {
        final genres = await remoteDataSource.getAnketa();

        return Right(genres.map((e) => AnketaEntity(text: e.text)).toList());
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return Left(ServerFailure('No Internet Connection'));
    }
  }

  @override
  Future<Either<Failure, String>> sendAnketaResponse(String genres) async {
    if (await networkInfo.isConnected) {
      try {
        final data = await remoteDataSource.sendAnketaResponse(genres);

        return Right(data);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return Left(ServerFailure('No Internet Connection'));
    }
  }
}
