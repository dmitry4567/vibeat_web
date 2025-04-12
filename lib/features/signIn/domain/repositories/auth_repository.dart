import 'package:tuple/tuple.dart';
import 'package:vibeat_web/features/signIn/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Stream<Tuple2<UserEntity?, bool>> get jwtStream;
  Future<Tuple2<UserEntity?, String?>> signInWithEmailAndPassword(
    String email,
    String password,
  );
  Future<Tuple2<UserEntity?, String?>> signUpWithEmailAndPassword(
    String email,
    String password,
  );

  // Future<Tuple2<UserEntity?, bool>> signInWithGoogle();
  Future<void> signOut();
  Future<UserEntity?> getCurrentUser();
  Future<void> cacheUser(UserEntity user, AuthType authType);
  Future<void> clearCache();
}
