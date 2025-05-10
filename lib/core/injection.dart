import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

final getIt = GetIt.instance;
const String apiToken = String.fromEnvironment('API_TOKEN');

Future<void> init() async {
  getIt.registerLazySingleton<Dio>(() => Dio(
        BaseOptions(
          baseUrl: 'https://interview.mattlabz.tech',
          headers: {
            'Authorization': 'Bearer $apiToken',
            'Content-Type': 'application/json',
          },
        ),
      ));
}
