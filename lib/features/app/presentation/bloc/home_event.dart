abstract class HomeEvent {}

class LoadHomeData extends HomeEvent {}

class ToggleBalanceVisibility extends HomeEvent {}

class UpdateBalance extends HomeEvent {
  final int newBalance;

  UpdateBalance(this.newBalance);
}
