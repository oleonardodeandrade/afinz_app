class TransferState {
  final String agency;
  final String account;
  final String amount;
  final bool isSubmitting;
  final bool isSuccess;
  final String? error;

  bool get isValid =>
      agency.length == 4 &&
      account.length == 4 &&
      int.tryParse(amount) != null &&
      int.parse(amount) > 0;

  const TransferState({
    required this.agency,
    required this.account,
    required this.amount,
    required this.isSubmitting,
    required this.isSuccess,
    this.error,
  });

  factory TransferState.initial() => const TransferState(
    agency: '',
    account: '',
    amount: '',
    isSubmitting: false,
    isSuccess: false,
    error: null,
  );

  TransferState copyWith({
    String? agency,
    String? account,
    String? amount,
    bool? isSubmitting,
    bool? isSuccess,
    String? error,
  }) {
    return TransferState(
      agency: agency ?? this.agency,
      account: account ?? this.account,
      amount: amount ?? this.amount,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error,
    );
  }
}
