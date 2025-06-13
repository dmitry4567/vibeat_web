import 'package:dartz/dartz.dart';
import 'package:vibeat_web/core/error/failures.dart';
import 'package:vibeat_web/features/allLicenses/domain/entities/license_entity.dart';

abstract class EditLicenseRepository {
  Future<Either<Failure, bool>> saveDraftLicense(
    LicenseEntity event,
  );
}
