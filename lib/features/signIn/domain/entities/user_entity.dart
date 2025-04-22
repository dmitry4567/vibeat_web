import 'package:equatable/equatable.dart';

enum AuthType { email, google }

class UserEntity extends Equatable {
  final String jwtToken;
  final AuthType authType;

  const UserEntity({
    required this.jwtToken,
    required this.authType,
  });

  @override
  List<Object?> get props => [jwtToken, authType];
}
