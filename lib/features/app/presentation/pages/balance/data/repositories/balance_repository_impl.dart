import '../../domain/repositories/balance_repository.dart';
import '../datasources/balance_remote_datasource.dart';

class BalanceRepositoryImpl implements BalanceRepository {
  final BalanceRemoteDatasource remoteDatasource;

  BalanceRepositoryImpl(this.remoteDatasource);

  @override
  Future<int> getBalance() {
    return remoteDatasource.getBalance();
  }
}
