import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_event.dart';
import 'home_state.dart';
import '../../../profile/domain/repositories/profile_repository.dart';
import '../../../balance/domain/repositories/balance_repository.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ProfileRepository profileRepository;
  final BalanceRepository balanceRepository;

  HomeBloc({required this.profileRepository, required this.balanceRepository}) : super(HomeLoading()) {
    on<LoadHomeData>((event, emit) async {
      try {
        final profile = await profileRepository.getProfile();
        final balance = await balanceRepository.getBalance();
        emit(HomeLoaded(profile: profile, balance: balance));
      } catch (e) {
        emit(HomeError('Erro ao carregar dados'));
      }
    });
  }
}
