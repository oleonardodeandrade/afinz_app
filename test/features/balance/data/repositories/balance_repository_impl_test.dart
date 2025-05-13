import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:afinz_app/features/balance/data/repositories/balance_repository_impl.dart';

import '../../../transfer/mocks/mock_balance_remote_datasource.mocks.dart';

void main() {
  late BalanceRepositoryImpl repository;
  late MockBalanceRemoteDatasource mockDatasource;

  setUp(() {
    mockDatasource = MockBalanceRemoteDatasource();
    repository = BalanceRepositoryImpl(mockDatasource);
  });

  const tBalance = 10000;

  test('should return balance when datasource succeeds', () async {
    when(mockDatasource.getBalance()).thenAnswer((_) async => tBalance);

    final result = await repository.getBalance();

    expect(result, equals(tBalance));
    verify(mockDatasource.getBalance()).called(1);
  });

  test('should throw if datasource throws', () async {
    when(mockDatasource.getBalance()).thenThrow(Exception('Error'));

    expect(() => repository.getBalance(), throwsA(isA<Exception>()));
  });
}
