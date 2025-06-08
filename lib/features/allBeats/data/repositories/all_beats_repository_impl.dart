import 'package:dartz/dartz.dart';
import 'package:vibeat_web/core/error/exceptions.dart';
import 'package:vibeat_web/core/error/failures.dart';
import 'package:vibeat_web/core/network/network_info.dart';
import 'package:vibeat_web/features/allBeats/data/datasource/all_beats_remote_data_sourse.dart';
import 'package:vibeat_web/features/allBeats/domain/entities/beat_entity.dart';
import 'package:vibeat_web/features/allBeats/domain/repositories/all_beats_repositories.dart';

class AllBeatRepositoryImpl implements AllBeatRepository {
  final AllBeatRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AllBeatRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<BeatEntity>>> getAllBeats() async {
    if (await networkInfo.isConnected) {
      try {
        final beats = await remoteDataSource.getAllBeats();

        return Right(beats
            .map(
              (e) => BeatEntity(
                id: e.id,
                name: e.name,
                description: e.description,
                urlPicture: e.urlPicture,
                tags: e.tags
                    .map(
                      (t) => TagEntity(id: t.id, name: t.name),
                    )
                    .toList(),
                genres: e.genres
                    .map(
                      (g) => GenreEntity(id: g.id, name: g.name),
                    )
                    .toList(),
                moods: e.moods
                    .map(
                      (m) => MoodEntity(id: m.id, name: m.name),
                    )
                    .toList(),
                key: KeyEntity(
                  id: e.key.id,
                  name: e.key.name,
                ),
                status: e.status,
                availableFiles: AvailableFilesEntity(
                  id: e.availableFiles.id,
                  mp3Url: e.availableFiles.mp3Url,
                  wavUrl: e.availableFiles.wavUrl,
                  zipUrl: e.availableFiles.zipUrl,
                ),
                bpm: e.bpm,
                createdAt: e.createdAt,
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
  Future<Either<Failure, BeatEntity>> makeEmptyBeat() async {
    if (await networkInfo.isConnected) {
      try {
        final data = await remoteDataSource.makeEmptyBeat();

        return Right(data);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return Left(ServerFailure('No Internet Connection'));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteBeat(String beatId) async {
    if (await networkInfo.isConnected) {
      try {
        final data = await remoteDataSource.deleteBeat(beatId);

        return Right(data);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return Left(ServerFailure('No Internet Connection'));
    }
  }
}
