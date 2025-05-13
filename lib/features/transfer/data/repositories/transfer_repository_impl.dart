import '../../domain/repositories/transfer_repository.dart';
import '../datasources/transfer_remote_datasource.dart';

class TransferRepositoryImpl implements TransferRepository {
  final TransferRemoteDatasource datasource;

  TransferRepositoryImpl(this.datasource);

  @override
  Future<void> transfer({
    required int value,
    required int agency,
    required int account,
  }) async {
    await datasource.transfer(
      value: value,
      agency: agency,
      account: account,
    );
  }

  @override
  Future<String> validateAgencyAccount({
    required int agency,
    required int account,
  }) async {
    return await datasource.validateAgencyAccount(
      agency: agency,
      account: account,
    );
  }
}
