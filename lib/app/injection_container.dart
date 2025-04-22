import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_secure_storage_web/flutter_secure_storage_web.dart';
import 'package:vibeat_web/core/api/auth_interceptor.dart';
import 'package:vibeat_web/core/api_client.dart';
import 'package:vibeat_web/core/network/network_info.dart';
import 'package:vibeat_web/features/anketa/data/datasource/anketa_remote_data_sourse.dart';
import 'package:vibeat_web/features/anketa/data/repositories/anketa_repository_impl.dart';
import 'package:vibeat_web/features/anketa/domain/repositories/anketa_repositories.dart';
import 'package:vibeat_web/features/anketa/domain/usecases/get_anketa.dart';
import 'package:vibeat_web/features/anketa/domain/usecases/send_anketa_response.dart';
import 'package:vibeat_web/features/anketa/presentation/bloc/anketa_bloc.dart';
import 'package:vibeat_web/features/signIn/domain/repositories/auth_repository.dart';
import 'package:vibeat_web/features/signIn/presentation/bloc/auth_bloc.dart';
import '../features/signIn/data/repositories/auth_repository_impl.dart';
import 'package:google_sign_in_platform_interface/google_sign_in_platform_interface.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => Logger());

  sl.registerLazySingleton<GoogleSignInPlatform>(
      () => GoogleSignInPlatform.instance);

  sl.registerLazySingleton<FlutterSecureStorage>(() {
    return const FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
      iOptions: IOSOptions(),
      webOptions: WebOptions(
        dbName: 'secure_storage',
        publicKey: 'vibeat_public_key',
      ),
    );
  });

  await sl<GoogleSignInPlatform>().initWithParams(const SignInInitParameters(
    clientId:
        '81758102489-595rl6k8eiq65p06tipflgjk96llo7go.apps.googleusercontent.com',
  ));

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

  // API Client
  sl.registerLazySingleton(() => ApiClient(
        dio: sl(),
        logger: sl(),
      ));

  // Interceptors
  sl.registerLazySingleton(() => AuthInterceptor(
        storage: sl<FlutterSecureStorage>(),
      ));

  // Initialize API Client
  final apiClient = sl<ApiClient>();
  await apiClient.initialize('http://192.168.0.135:7773/api');
  // await apiClient.initialize('http://172.20.10.4:3000');

  // Add auth interceptor
  sl<Dio>().interceptors.add(sl<AuthInterceptor>());

  // BLoCs
  sl.registerFactory(() => AuthBloc(authRepository: sl()));
  sl.registerFactory(() => AnketaBloc(
        getAnketa: sl(),
        sendAnketaResponse: sl(),
      ));

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      googleSignInPlatform: sl(),
      storage: sl<FlutterSecureStorage>(),
      apiClient: sl(),
    ),
  );

  sl.registerLazySingleton<AnketaRepository>(
    () => AnketaRepositoryImpl(
      networkInfo: sl(),
      remoteDataSource: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetAnketa(sl()));
  sl.registerLazySingleton(() => SendAnketaResponse(sl()));

  // Data sources
  sl.registerLazySingleton<AnketaRemoteDataSource>(
    () => AnketaRemoteDataSourceImpl(apiClient: sl()),
  );
}
