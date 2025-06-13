import 'package:dartz/dartz.dart';
import 'package:vibeat_web/core/error/exceptions.dart';
import 'package:vibeat_web/core/error/failures.dart';
import 'package:vibeat_web/core/network/network_info.dart';
import 'package:vibeat_web/features/allLicenses/domain/entities/license_entity.dart';
import 'package:vibeat_web/features/editLicense/data/datasource/edit_license_remote_data_sourse.dart';
import 'package:vibeat_web/features/editLicense/domain/repositories/edit_license_repositories.dart';
import 'package:vibeat_web/features/editLicense/presentation/bloc/edit_license_template_bloc.dart';

class EditLicenseRepositoryImpl implements EditLicenseRepository {
  final EditLicenseRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  EditLicenseRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, bool>> saveDraftLicense(LicenseEntity templateLicense) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await remoteDataSource.saveDraftLicense(templateLicense);
        return Right(result);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return Left(ServerFailure('No Internet Connection'));
    }
  }
}
