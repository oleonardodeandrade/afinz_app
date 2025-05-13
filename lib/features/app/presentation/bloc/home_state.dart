import '../../../profile/domain/entities/profile.dart';

abstract class HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final Profile profile;
  final int balance;
  final bool isBalanceVisible;

  HomeLoaded({
    required this.profile, 
    required this.balance,
    this.isBalanceVisible = true,
  });

  HomeLoaded copyWith({
    Profile? profile,
    int? balance,
    bool? isBalanceVisible,
  }) {
    return HomeLoaded(
      profile: profile ?? this.profile,
      balance: balance ?? this.balance,
      isBalanceVisible: isBalanceVisible ?? this.isBalanceVisible,
    );
  }
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}
