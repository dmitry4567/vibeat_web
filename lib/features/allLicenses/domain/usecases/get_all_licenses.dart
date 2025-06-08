import 'package:dartz/dartz.dart';
import 'package:vibeat_web/core/error/failures.dart';
import 'package:vibeat_web/core/usercases/usecase.dart';
import 'package:vibeat_web/features/allLicenses/domain/entities/license_entity.dart';
import 'package:vibeat_web/features/allLicenses/domain/repositories/all_licenses_repositories.dart';

class GetAllLicenses {
  final AllLicensesRepository repository;

  GetAllLicenses(this.repository);

  Future<Either<Failure, List<LicenseEntity>>> call(NoParams params) async {
    return await repository.getAllLicenses();
  }
}
