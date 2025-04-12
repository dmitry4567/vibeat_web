import 'package:dartz/dartz.dart';
import 'package:vibeat_web/core/error/failures.dart';
import 'package:vibeat_web/core/usercases/usecase.dart';
import 'package:vibeat_web/features/anketa/domain/entities/anketa_entity.dart';
import 'package:vibeat_web/features/anketa/domain/repositories/anketa_repositories.dart';

class GetAnketa {
  final AnketaRepository repository;

  GetAnketa(this.repository);

  Future<Either<Failure, List<AnketaEntity>>> call(NoParams params) async {
    return await repository.getAnketa();
  }
}
