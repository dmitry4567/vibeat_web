import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:vibeat_web/core/api/auth_interceptor.dart';
import 'package:vibeat_web/core/api_client.dart';
import 'package:vibeat_web/core/network/network_info.dart';
import 'package:vibeat_web/features/allBeats/data/datasource/all_beats_remote_data_sourse.dart';
import 'package:vibeat_web/features/allBeats/data/repositories/all_beats_repository_impl.dart';
import 'package:vibeat_web/features/allBeats/domain/entities/beat_entity.dart';
import 'package:vibeat_web/features/allBeats/domain/repositories/all_beats_repositories.dart';
import 'package:vibeat_web/features/allBeats/domain/usecases/delete_beat.dart';
import 'package:vibeat_web/features/allBeats/domain/usecases/get_all_beats.dart';
import 'package:vibeat_web/features/allBeats/domain/usecases/make_empty_beat.dart';
import 'package:vibeat_web/features/allBeats/presentation/bloc/all_beats_bloc.dart';
import 'package:vibeat_web/features/allLicenses/data/datasource/all_licenses_remote_data_sourse.dart';
import 'package:vibeat_web/features/allLicenses/data/repositories/all_licenses_repository_impl.dart';
import 'package:vibeat_web/features/allLicenses/domain/repositories/all_licenses_repositories.dart';
import 'package:vibeat_web/features/allLicenses/domain/usecases/get_all_licenses.dart';
import 'package:vibeat_web/features/allLicenses/presentation/bloc/bloc/all_licenses_bloc.dart';
import 'package:vibeat_web/features/anketa/data/datasource/anketa_remote_data_sourse.dart';
import 'package:vibeat_web/features/anketa/data/repositories/anketa_repository_impl.dart';
import 'package:vibeat_web/features/anketa/domain/repositories/anketa_repositories.dart';
import 'package:vibeat_web/features/anketa/domain/usecases/get_anketa.dart';
import 'package:vibeat_web/features/anketa/domain/usecases/send_anketa_response.dart';
import 'package:vibeat_web/features/anketa/presentation/bloc/anketa_bloc.dart';
import 'package:vibeat_web/features/editBeat/data/datasource/edit_beat_remote_data_sourse.dart';
import 'package:vibeat_web/features/editBeat/data/repositories/edit_beat_repository_impl.dart';
import 'package:vibeat_web/features/editBeat/domain/repositories/edit_beat_repositories.dart';
import 'package:vibeat_web/features/editBeat/domain/usecases/add_cover.dart';
import 'package:vibeat_web/features/editBeat/domain/usecases/add_mp3.dart';
import 'package:vibeat_web/features/editBeat/domain/usecases/add_wav.dart';
import 'package:vibeat_web/features/editBeat/domain/usecases/add_zip.dart';
import 'package:vibeat_web/features/editBeat/domain/usecases/publish_beat.dart';
import 'package:vibeat_web/features/editBeat/presentation/bloc/edit_beat_bloc.dart';
import 'package:vibeat_web/features/signIn/domain/repositories/auth_repository.dart';
import 'package:vibeat_web/features/signIn/presentation/bloc/auth_bloc.dart';
import '../features/signIn/data/repositories/auth_repository_impl.dart';
import 'package:google_sign_in_platform_interface/google_sign_in_platform_interface.dart';

final sl = GetIt.instance;

// const url = "158.160.27.143";
const url = "192.168.0.135";

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
  // await apiClient.initialize('http://192.168.0.135:8080/');
  await apiClient.initialize('http://$url:8080/');

  // Add auth interceptor
  sl<Dio>().interceptors.add(sl<AuthInterceptor>());

  // BLoCs
  sl.registerFactory(
    () => AuthBloc(
      authRepository: sl(),
    ),
  );
  sl.registerFactory(() => AnketaBloc(
        getAnketa: sl(),
        sendAnketaResponse: sl(),
      ));
  sl.registerFactory(
    () => AllBeatBloc(
      getAllBeats: sl(),
      makeEmptyBeat: sl(),
      deleteBeat: sl(),
    ),
  );
  sl.registerFactoryParam<EditBeatBloc, BeatEntity, bool>(
    (beat, isEditMode) => EditBeatBloc(
      beat: beat,
      isEditMode: isEditMode,
      addMp3File: sl(),
      addWavFile: sl(),
      addZipFile: sl(),
      addCoverFile: sl(),
      publishBeat: sl(),
    ),
  );
  sl.registerFactory(
    () => AllLicensesBloc(
      getAllLicenses: sl(),
    ),
  );

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

  sl.registerLazySingleton<AllBeatRepository>(
    () => AllBeatRepositoryImpl(
      networkInfo: sl(),
      remoteDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<EditBeatRepository>(
    () => EditBeatRepositoryImpl(
      networkInfo: sl(),
      remoteDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<AllLicensesRepository>(
    () => AllLicensesRepositoryImpl(
      networkInfo: sl(),
      remoteDataSource: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetAnketa(sl()));
  sl.registerLazySingleton(() => SendAnketaResponse(sl()));
  sl.registerLazySingleton(() => GetAllBeats(sl()));
  sl.registerLazySingleton(() => MakeEmptyBeat(sl()));
  sl.registerLazySingleton(() => DeleteBeat(sl()));
  sl.registerLazySingleton(() => AddMp3File(sl()));
  sl.registerLazySingleton(() => AddWavFile(sl()));
  sl.registerLazySingleton(() => AddZipFile(sl()));
  sl.registerLazySingleton(() => AddCoverFile(sl()));
  sl.registerLazySingleton(() => PublishBeat(sl()));
  sl.registerLazySingleton(() => GetAllLicenses(sl()));

  // Data sources
  sl.registerLazySingleton<AnketaRemoteDataSource>(
    () => AnketaRemoteDataSourceImpl(apiClient: sl()),
  );

  sl.registerLazySingleton<AllBeatRemoteDataSource>(
    () => AllBeatRemoteDataSourceImpl(apiClient: sl()),
  );

  sl.registerLazySingleton<EditBeatRemoteDataSource>(
    () => EditBeatRemoteDataSourceImpl(apiClient: sl()),
  );

  sl.registerLazySingleton<AllLicensesRemoteDataSource>(
    () => AllLicensesRemoteDataSourceImpl(apiClient: sl()),
  );
}
