import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class ApiClient {
  final Dio dio;
  final Logger logger;

  ApiClient({
    required this.dio,
    required this.logger,
  });

  Future<void> initialize(String baseUrl) async {
    dio.options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // logger.i('Request: ${options.method} ${options.uri}');
        // logger.v('Request data: ${options.data}');
        // logger.v('Request headers: ${options.headers}');
        return handler.next(options);
      },
      onResponse: (response, handler) {
        // logger.i(
        //     'Response: ${response.statusCode} ${response.requestOptions.uri}');
        // logger.v('Response data: ${response.data}');
        return handler.next(response);
      },
      onError: (DioException error, handler) {
        // logger.e('Error: ${error.type} ${error.requestOptions.uri}');
        // logger.e('Error message: ${error.message}');
        // logger.e('Error response: ${error.response?.data}');
        return handler.next(error);
      },
    ));

    dio.interceptors.add(LogInterceptor(
      request: false,
      requestHeader: false,
      requestBody: false,
      responseHeader: false,
      responseBody: false,
      error: false,
    ));
  }

  Future<Response> get(String path,
      {Map<String, dynamic>? queryParameters, required Options options}) async {
    return dio.get(path, queryParameters: queryParameters);
  }

  Future<Response> post(String path,
      {dynamic data, required Options options}) async {
    return dio.post(path, data: data);
  }

  Future<Response> put(
    String path,
    Options options, {
    dynamic data,
    ProgressCallback? onSendProgress,
  }) async {
    return dio.put(
      path,
      data: data,
      options: options,
      onSendProgress: onSendProgress,
    );
  }

  Future<Response> patch(String path, {dynamic data}) async {
    return dio.patch(path, data: data);
  }

  Future<Response> delete(String path, {dynamic data}) async {
    return dio.delete(path, data: data);
  }
}
