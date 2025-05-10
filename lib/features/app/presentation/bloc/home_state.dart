import '../../../profile/domain/entities/profile.dart';

abstract class HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final Profile profile;
  final int balance;

  HomeLoaded({required this.profile, required this.balance});
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}
