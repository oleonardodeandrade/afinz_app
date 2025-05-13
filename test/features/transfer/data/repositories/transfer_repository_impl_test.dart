import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:afinz_app/features/transfer/data/repositories/transfer_repository_impl.dart';

import '../../mocks/mock_transfer_remote_datasource.mocks.dart';

void main() {
  late TransferRepositoryImpl repository;
  late MockTransferRemoteDatasource mockDatasource;

  setUp(() {
    mockDatasource = MockTransferRemoteDatasource();
    repository = TransferRepositoryImpl(mockDatasource);
  });

  test('should call datasource and complete successfully', () async {
    when(mockDatasource.transfer(value: 100, agency: 3212, account: 9073))
        .thenAnswer((_) async => {});

    await repository.transfer(value: 100, agency: 3212, account: 9073);

    verify(mockDatasource.transfer(value: 100, agency: 3212, account: 9073)).called(1);
  });

  test('should throw if datasource throws', () async {
    when(mockDatasource.transfer(value: 100, agency: 3212, account: 9073))
        .thenThrow(Exception('API Error'));

    expect(
      () => repository.transfer(value: 100, agency: 3212, account: 9073),
      throwsA(isA<Exception>()),
    );
  });
}
