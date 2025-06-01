import 'dart:developer';
import 'package:vibeat_web/core/api_client.dart';
import 'package:vibeat_web/core/constants/strings.dart';
import 'package:vibeat_web/features/signIn/domain/entities/user_entity.dart';
import 'package:vibeat_web/features/signIn/domain/repositories/auth_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in_platform_interface/google_sign_in_platform_interface.dart';

import 'package:dio/dio.dart' as d;
import 'package:tuple/tuple.dart';

class AuthRepositoryImpl implements AuthRepository {
  final GoogleSignInPlatform _googleSignInPlatform;
  final FlutterSecureStorage _storage;
  final ApiClient _apiClient;

  AuthRepositoryImpl({
    required GoogleSignInPlatform googleSignInPlatform,
    required FlutterSecureStorage storage,
    required ApiClient apiClient,
  })  : _googleSignInPlatform = googleSignInPlatform,
        _storage = storage,
        _apiClient = apiClient;

  @override
  Stream<Tuple2<UserEntity?, bool>> get jwtStream {
    return _googleSignInPlatform.userDataEvents!.asyncMap((event) async {
      final response = await _apiClient.post(
        'user/auth/google/getjwt',
        options: d.Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
        data: {
          'token': event!.idToken,
        },
      );

      if (response.statusCode != 200) return const Tuple2(null, false);

      final responseData = response.data;

      final user = UserEntity(
        jwtToken: responseData['token'],
        authType: AuthType.google,
      );

      await cacheUser(user, AuthType.google);

      // Проверяем наличие параметра 'message' в responseData
      final bool hasMessage = responseData.containsKey('new_user');

      return Tuple2(user, hasMessage);
    });
  }

  @override
  Future<Tuple2<UserEntity?, String?>> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final response = await _apiClient.post(
        'user/login',
        options: d.Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
        data: {
          'email': email,
          'password': password,
        },
      );

      final responseData = response.data;

      final user =
          UserEntity(jwtToken: responseData['token'], authType: AuthType.email);

      await cacheUser(user, AuthType.email);

      return Tuple2(user, null);
    } on d.DioException catch (e) {
      final responseData = e.response!.data;

      return Tuple2(null, responseData['message']);
    } catch (e) {
      log('Error in signInWithEmailAndPassword: $e');
      return const Tuple2(null, 'Server error');
    }
  }

  @override
  Future<Tuple2<UserEntity?, String?>> signUpWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final response = await _apiClient.post(
        'user/register',
        options: d.Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
        data: {
          'email': email,
          'password': password,
        },
      );

      final responseData = response.data;

      final user =
          UserEntity(jwtToken: responseData['token'], authType: AuthType.email);

      await cacheUser(user, AuthType.email);

      return Tuple2(user, null);
    } on d.DioException catch (e) {
      final responseData = e.response!.data;

      return Tuple2(null, responseData['message']);
    } catch (e) {
      log('Error in signUpWithEmailAndPassword: $e');
      return const Tuple2(null, 'Server error');
    }
  }


  @override
  Future<void> signOut() async {
    // await _googleSignIn.signOut();
    // await clearCache();
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    final authType = await _storage.read(key: AppStrings.authType);

    if (authType == AuthType.email.name) {
      final jwtToken = await _storage.read(key: AppStrings.jwtTokenKey);
      if (jwtToken == null) return null;

      return UserEntity(
        jwtToken: jwtToken,
        authType: AuthType.email,
      );
    } else if (authType == AuthType.google.name) {
      try {
        // final account = await _googleSignIn.signInSilently();
        // if (account == null) return null;

        final jwtToken = await _storage.read(key: AppStrings.jwtTokenKey);
        if (jwtToken == null) return null;

        return UserEntity(
          jwtToken: jwtToken,
          authType: AuthType.google,
        );
      } catch (e) {
        print('Error in _getCurrentUserFromGoogle: $e');
        return null;
      }
    }

    return null;
  }

  @override
  Future<void> cacheUser(UserEntity user, AuthType authType) async {
    await _storage.write(
      key: "jwt_token",
      value: user.jwtToken,
    );
    await _storage.write(
      key: "auth_type",
      value: authType.name,
    );
  }

  @override
  Future<void> clearCache() async {
    await _storage.delete(key: AppStrings.jwtTokenKey);
    await _storage.delete(key: AppStrings.authType);
  }
}
