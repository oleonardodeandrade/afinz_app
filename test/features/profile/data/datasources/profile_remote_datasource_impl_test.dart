import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:afinz_app/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:afinz_app/features/profile/domain/entities/profile.dart';

import '../../../transfer/mocks/mock_transfer_remote_datasource.mocks.dart';

void main() {
  late Dio dio;
  late ProfileRemoteDatasourceImpl datasource;

  setUp(() {
    dio = MockDio();
    datasource = ProfileRemoteDatasourceImpl(dio);
  });

  final responseData = {
    'name': 'Leo',
    'agency': 1234,
    'account': 5678,
  };

  test('should return Profile when API returns 200', () async {
    when(dio.get('/profile')).thenAnswer((_) async => Response(
      requestOptions: RequestOptions(path: '/profile'),
      statusCode: 200,
      data: responseData,
    ));

    final result = await datasource.getProfile();

    expect(result, isA<Profile>());
    expect(result.name, equals('Leo'));
  });

  test('should throw when API call fails', () async {
    when(dio.get('/profile')).thenThrow(Exception('Failed'));

    expect(() => datasource.getProfile(), throwsA(isA<Exception>()));
  });
}
