import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:afinz_app/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:afinz_app/features/profile/domain/entities/profile.dart';

import '../../../transfer/mocks/mock_profile_remote_datasource.mocks.dart';

void main() {
  late ProfileRepositoryImpl repository;
  late MockProfileRemoteDatasource mockDatasource;

  setUp(() {
    mockDatasource = MockProfileRemoteDatasource();
    repository = ProfileRepositoryImpl(mockDatasource);
  });

  final tProfile = Profile(name: 'Leo', agency: 1234, account: 5678);

  test('should return Profile when datasource succeeds', () async {
    when(mockDatasource.getProfile()).thenAnswer((_) async => tProfile);

    final result = await repository.getProfile();

    expect(result, equals(tProfile));
    verify(mockDatasource.getProfile()).called(1);
  });

  test('should throw if datasource throws', () async {
    when(mockDatasource.getProfile()).thenThrow(Exception('API Error'));

    expect(() => repository.getProfile(), throwsA(isA<Exception>()));
  });
}
