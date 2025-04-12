import 'package:dartz/dartz.dart';
import 'package:vibeat_web/core/error/failures.dart';
import 'package:vibeat_web/features/anketa/domain/repositories/anketa_repositories.dart';

class SendAnketaResponse {
  final AnketaRepository repository;

  SendAnketaResponse(this.repository);

  Future<Either<Failure, String>> call(String genres) async {
    return await repository.sendAnketaResponse(genres);
  }
}