import 'package:afinz_app/features/transfer/data/datasources/transfer_remote_datasource.dart';
import 'package:afinz_app/features/transfer/data/repositories/transfer_repository_impl.dart';
import 'package:afinz_app/features/transfer/domain/repositories/transfer_repository.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../features/app/presentation/bloc/home_bloc.dart';
import '../features/profile/data/datasources/profile_remote_datasource.dart';
import '../features/profile/data/repositories/profile_repository_impl.dart';
import '../features/profile/domain/repositories/profile_repository.dart';
import '../features/balance/data/datasources/balance_remote_datasource.dart';
import '../features/balance/data/repositories/balance_repository_impl.dart';
import '../features/balance/domain/repositories/balance_repository.dart';

final getIt = GetIt.instance;
const String apiToken = String.fromEnvironment('API_TOKEN');

Future<void> init() async {
  final token = dotenv.env['API_TOKEN']!;
  final baseUrl = dotenv.env['BASE_URL']!;

  // Dio
  getIt.registerLazySingleton(
    () => Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: {'Authorization': 'Bearer $token'},
      ),
    ),
  );

  // Profile
  getIt.registerLazySingleton<ProfileRemoteDatasource>(
    () => ProfileRemoteDatasourceImpl(getIt()),
  );
  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(getIt()),
  );

  // Balance
  getIt.registerLazySingleton<BalanceRemoteDatasource>(
    () => BalanceRemoteDatasourceImpl(getIt()),
  );
  getIt.registerLazySingleton<BalanceRepository>(
    () => BalanceRepositoryImpl(getIt()),
  );

  // Bloc
  getIt.registerFactory(
    () => HomeBloc(profileRepository: getIt(), balanceRepository: getIt()),
  );

  // Transfer
  getIt.registerLazySingleton<TransferRemoteDatasource>(
    () => TransferRemoteDatasourceImpl(getIt()),
  );
  getIt.registerLazySingleton<TransferRepository>(
    () => TransferRepositoryImpl(getIt()),
  );
}
