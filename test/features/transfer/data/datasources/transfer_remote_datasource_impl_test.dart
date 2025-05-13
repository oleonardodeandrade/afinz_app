import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:afinz_app/features/transfer/data/datasources/transfer_remote_datasource.dart';

import '../../mocks/mock_transfer_remote_datasource.mocks.dart';

void main() {
  late TransferRemoteDatasourceImpl datasource;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    datasource = TransferRemoteDatasourceImpl(mockDio);
  });

  test('should complete successfully when API returns 200', () async {
    when(mockDio.post(
      any,
      data: anyNamed('data'),
    )).thenAnswer((_) async => Response(
          requestOptions: RequestOptions(path: '/transfer'),
          statusCode: 200,
          data: {"status": "APPROVED"},
        ));

    await datasource.transfer(value: 100, agency: 3212, account: 9073);
    verify(mockDio.post('/transfer', data: {
      'value': 100,
      'agency': 3212,
      'account': 9073,
    })).called(1);
  });

  test('should throw if API returns error', () async {
    when(mockDio.post(any, data: anyNamed('data'))).thenAnswer((_) async => Response(
          requestOptions: RequestOptions(path: '/transfer'),
          statusCode: 400,
          data: {"message": "Bad request"},
        ));

    expect(
      () => datasource.transfer(value: 100, agency: 3212, account: 9073),
      throwsA(isA<Exception>()),
    );
  });
}
