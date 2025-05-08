import 'package:vibeat_web/core/network/network_info.dart';
import 'package:vibeat_web/features/editBeat/data/datasource/edit_beat_remote_data_sourse.dart';
import 'package:vibeat_web/features/editBeat/domain/repositories/edit_beat_repositories.dart';

class EditBeatRepositoryImpl implements EditBeatRepository {
  final EditBeatRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  EditBeatRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  // @override
  // Future<Either<Failure, List<BeatEntity>>> getAllBeats() async {
  //   if (await networkInfo.isConnected) {
  //     try {
  //       final beats = await remoteDataSource.getAllBeats();

  //       return Right(beats
  //           .map(
  //             (e) => BeatEntity(
  //               id: e.id,
  //               name: e.name,
  //               urlPicture: e.urlPicture,
  //               tags: e.tags
  //                   .map(
  //                     (t) => TagEntity(id: t.id, name: t.name),
  //                   )
  //                   .toList(),
  //               status: e.status,
  //             ),
  //           )
  //           .toList());
  //     } on ServerException catch (e) {
  //       return Left(ServerFailure(e.message));
  //     }
  //   } else {
  //     return Left(ServerFailure('No Internet Connection'));
  //   }
  // }

  // @override
  // Future<Either<Failure, BeatEntity>> makeEmptyBeat() async {
  //   if (await networkInfo.isConnected) {
  //     try {
  //       final data = await remoteDataSource.makeEmptyBeat();

  //       return Right(data);
  //     } on ServerException catch (e) {
  //       return Left(ServerFailure(e.message));
  //     }
  //   } else {
  //     return Left(ServerFailure('No Internet Connection'));
  //   }
  // }
}
