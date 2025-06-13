import 'package:dartz/dartz.dart';
import 'package:vibeat_web/core/error/failures.dart';
import 'package:vibeat_web/core/usercases/usecase.dart';
import 'package:vibeat_web/features/editBeat/domain/repositories/edit_beat_repositories.dart';
import 'package:vibeat_web/features/editBeat/presentation/bloc/edit_beat_bloc.dart';
import 'package:vibeat_web/features/editBeat/presentation/pages/widgets/license_cart_widget.dart';

class PublishBeat {
  final EditBeatRepository repository;

  PublishBeat(this.repository);

  Future<Either<Failure, bool>> call(
    PublishBeatEvent event,
    List<LicenseTemplateEntity> templateLicense,
  ) async {
    return await repository.publishBeat(event, templateLicense);
  }
}
