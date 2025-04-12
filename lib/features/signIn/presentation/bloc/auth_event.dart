part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignInEmailPasswordRequested extends AuthEvent {
  final String email;
  final String password;

  const SignInEmailPasswordRequested({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

class SignUpEmailPasswordRequested extends AuthEvent {
  final String email;
  final String password;

  const SignUpEmailPasswordRequested({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

class GoogleJwtStream extends AuthEvent {}
// class GoogleSignInRequested extends AuthEvent {}

class SignOutRequested extends AuthEvent {}

class AuthCheckRequested extends AuthEvent {}

class AnketaDataRequested extends AuthEvent {}
