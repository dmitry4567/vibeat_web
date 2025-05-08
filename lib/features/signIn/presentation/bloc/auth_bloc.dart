
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tuple/tuple.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<GoogleJwtStream>(_onGoogleJwtStream);
    on<SignInEmailPasswordRequested>(_onEmailPasswordRequested);
    on<SignUpEmailPasswordRequested>(_onSignUpEmailPasswordRequested);
    // on<GoogleSignInRequested>(_onGoogleSignInRequested);
    on<SignOutRequested>(_onSignOutRequested);
    on<AuthCheckRequested>(_onAuthCheckRequested);
  }

  Future<void> _onGoogleJwtStream(
    GoogleJwtStream event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await emit.forEach<Tuple2<UserEntity?, bool>>(
        authRepository.jwtStream,
        onData: (data) {
          if (data.item2 == true) {
            return RegisteredNewUser(user: data.item1!);
          } else if (data.item1 != null) {
            return Authenticated(user: data.item1!);
          }
          emit(const AuthError(message: "Error"));
          return Unauthenticated();
        },
        onError: (error, stackTrace) {
          return const AuthError(message: "Error");
        },
      );
    } catch (_) {
      emit(const AuthError(message: 'Sign in failed'));
      emit(Unauthenticated());
    }
  }

  Future<void> _onEmailPasswordRequested(
    SignInEmailPasswordRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    Tuple2<UserEntity?, String?> data =
        await authRepository.signInWithEmailAndPassword(
      event.email,
      event.password,
    );

    if (data.item2 != null) {
      emit(AuthError(message: data.item2!));
      emit(Unauthenticated());
    } else if (data.item1 != null) {
      emit(Authenticated(user: data.item1!));
    }
  }

  Future<void> _onSignUpEmailPasswordRequested(
    SignUpEmailPasswordRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    Tuple2<UserEntity?, String?> data =
        await authRepository.signUpWithEmailAndPassword(
      event.email,
      event.password,
    );

    if (data.item2 != null) {
      emit(AuthError(message: data.item2!));
      emit(Unauthenticated());
    } else if (data.item1 != null) {
      emit(RegisteredNewUser(user: data.item1!));
    }
  }

  // Future<void> _onGoogleSignInRequested(
  //   GoogleSignInRequested event,
  //   Emitter<AuthState> emit,
  // ) async {
  //   emit(AuthLoading());
  //   try {
  //     Tuple2<UserEntity?, bool> data = await authRepository.signInWithGoogle();

  //     if (data.item2 == true) {
  //       emit(RegisteredNewUser(user: data.item1!));
  //     } else if (data.item1 != null) {
  //       emit(Authenticated(user: data.item1!));
  //     } else {
  //       emit(const AuthError(message: "Error"));
  //       emit(Unauthenticated());
  //     }
  //   } catch (_) {
  //     emit(const AuthError(message: 'Sign in failed'));
  //     emit(Unauthenticated());
  //   }
  // }

  Future<void> _onSignOutRequested(
    SignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    await authRepository.signOut();
    emit(SignOut());
  }

  Future<void> _onAuthCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.getCurrentUser();

      if (user != null) {
        emit(Authenticated(user: user));
      } else {
        emit(Unauthenticated());
      }
    } catch (_) {
      emit(Unauthenticated());
    }
  }
}
