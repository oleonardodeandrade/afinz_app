abstract class TransferRepository {
  Future<void> transfer({
    required int value,
    required int agency,
    required int account,
  });

  Future<String> validateAgencyAccount({
    required int agency,
    required int account,
  });
}
