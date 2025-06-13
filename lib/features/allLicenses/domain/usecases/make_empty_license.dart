import 'package:dartz/dartz.dart';
import 'package:vibeat_web/core/error/failures.dart';
import 'package:vibeat_web/core/usercases/usecase.dart';
import 'package:vibeat_web/features/allLicenses/domain/entities/license_entity.dart';
import 'package:vibeat_web/features/allLicenses/domain/repositories/all_licenses_repositories.dart';

class MakeEmptyLicense {
  final AllLicensesRepository repository;

  MakeEmptyLicense(this.repository);

  Future<Either<Failure, LicenseEntity>> call(NoParams params) async {
    return await repository.makeEmptyLicense();
  }
}
