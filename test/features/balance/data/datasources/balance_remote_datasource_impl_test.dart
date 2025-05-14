import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:afinz_app/features/app/presentation/pages/balance/data/datasources/balance_remote_datasource.dart';

import '../../../transfer/mocks/mock_transfer_remote_datasource.mocks.dart';

void main() {
  late Dio dio;
  late BalanceRemoteDatasourceImpl datasource;

  setUp(() {
    dio = MockDio();
    datasource = BalanceRemoteDatasourceImpl(dio);
  });

  const tBalance = 10000;

  test('should return balance when API returns 200', () async {
    when(dio.get('/balance')).thenAnswer((_) async => Response(
      requestOptions: RequestOptions(path: '/balance'),
      statusCode: 200,
      data: {'balance': tBalance},
    ));

    final result = await datasource.getBalance();

    expect(result, equals(tBalance));
  });

  test('should throw when API call fails', () async {
    when(dio.get('/balance')).thenThrow(Exception('Network error'));

    expect(() => datasource.getBalance(), throwsA(isA<Exception>()));
  });
}
