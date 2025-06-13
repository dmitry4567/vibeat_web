import 'package:dartz/dartz.dart';
import 'package:vibeat_web/core/error/failures.dart';
import 'package:vibeat_web/features/allLicenses/domain/entities/license_entity.dart';
import 'package:vibeat_web/features/editLicense/domain/repositories/edit_license_repositories.dart';
import 'package:vibeat_web/features/editLicense/presentation/bloc/edit_license_template_bloc.dart';

class SaveDraftLicense {
  final EditLicenseRepository repository;

  SaveDraftLicense(this.repository);

  Future<Either<Failure, bool>> call(LicenseEntity event) async {
    return await repository.saveDraftLicense(event);
  }
}
