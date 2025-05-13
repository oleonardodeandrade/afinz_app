import 'package:dio/dio.dart';
import 'api_config.dart';

class HttpClient {
  static Dio get dio {
    final dio = Dio(BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      headers: ApiConfig.headers,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    ));

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        options.headers.addAll(ApiConfig.authHeaders);
        return handler.next(options);
      },
    ));

    return dio;
  }
} 