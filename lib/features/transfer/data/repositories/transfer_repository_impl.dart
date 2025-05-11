import '../../domain/repositories/transfer_repository.dart';
import '../datasources/transfer_remote_datasource.dart';

class TransferRepositoryImpl implements TransferRepository {
  final TransferRemoteDatasource remote;

  TransferRepositoryImpl(this.remote);

  @override
  Future<void> transfer({
    required int value,
    required int agency,
    required int account,
  }) {
    return remote.transfer(value: value, agency: agency, account: account);
  }
}
