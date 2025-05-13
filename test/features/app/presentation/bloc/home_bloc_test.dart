import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';

import 'package:afinz_app/features/app/presentation/bloc/home_bloc.dart';
import 'package:afinz_app/features/app/presentation/bloc/home_event.dart';
import 'package:afinz_app/features/app/presentation/bloc/home_state.dart';
import 'package:afinz_app/features/profile/domain/entities/profile.dart';

import '../../../transfer/mocks/mock_home_dependencies.mocks.dart';

void main() {
  late MockProfileRepository profileRepository;
  late MockBalanceRepository balanceRepository;

  setUp(() {
    profileRepository = MockProfileRepository();
    balanceRepository = MockBalanceRepository();
  });

  final tProfile = Profile(name: 'John Doe', agency: 1234, account: 5678);
  const tBalance = 15000;

  blocTest<HomeBloc, HomeState>(
    'emits [HomeLoading, HomeLoaded] when data is fetched successfully',
    build: () {
      when(profileRepository.getProfile()).thenAnswer((_) async => tProfile);
      when(balanceRepository.getBalance()).thenAnswer((_) async => tBalance);
      return HomeBloc(
        profileRepository: profileRepository,
        balanceRepository: balanceRepository,
      );
    },
    act: (bloc) => bloc.add(LoadHomeData()),
    expect: () => [
      isA<HomeLoading>(),
      isA<HomeLoaded>()
          .having((s) => s.profile.name, 'profile.name', 'John Doe')
          .having((s) => s.balance, 'balance', 15000),
    ],
  );

  blocTest<HomeBloc, HomeState>(
    'emits [HomeLoading, HomeError] when profile fetch fails',
    build: () {
      when(profileRepository.getProfile()).thenThrow(Exception('fail'));
      return HomeBloc(
        profileRepository: profileRepository,
        balanceRepository: balanceRepository,
      );
    },
    act: (bloc) => bloc.add(LoadHomeData()),
    expect: () => [
      isA<HomeLoading>(),
      isA<HomeError>().having((s) => s.message, 'message', contains('Failed')),
    ],
  );

  blocTest<HomeBloc, HomeState>(
    'emits [HomeLoading, HomeError] when balance fetch fails',
    build: () {
      when(profileRepository.getProfile()).thenAnswer((_) async => tProfile);
      when(balanceRepository.getBalance()).thenThrow(Exception('fail'));
      return HomeBloc(
        profileRepository: profileRepository,
        balanceRepository: balanceRepository,
      );
    },
    act: (bloc) => bloc.add(LoadHomeData()),
    expect: () => [
      isA<HomeLoading>(),
      isA<HomeError>().having((s) => s.message, 'message', contains('Failed')),
    ],
  );
}
