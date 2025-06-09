import 'package:dartz/dartz.dart';
import 'package:vibeat_web/features/allLicenses/domain/entities/license_entity.dart';
import '../../../../core/error/failures.dart';

abstract class AllLicensesRepository {
  Future<Either<Failure, List<LicenseEntity>>> getAllLicenses();
  Future<Either<Failure, LicenseEntity>> makeEmptyLicense();
}
