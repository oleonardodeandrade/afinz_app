abstract class BalanceRepository {
  /// Balance in cents (int)
  Future<int> getBalance();
}
