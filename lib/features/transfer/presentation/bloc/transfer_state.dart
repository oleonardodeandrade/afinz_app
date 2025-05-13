class TransferState {
  final String agency;
  final String account;
  final String amount;
  final String? error;
  final bool isSubmitting;
  final bool isValid;
  final String? recipientName;

  TransferState({
    this.agency = '',
    this.account = '',
    this.amount = '',
    this.error,
    this.isSubmitting = false,
    this.isValid = false,
    this.recipientName,
  });

  bool get isFormValid => agency.isNotEmpty && account.isNotEmpty && amount.isNotEmpty;

  TransferState copyWith({
    String? agency,
    String? account,
    String? amount,
    String? error,
    bool? isSubmitting,
    bool? isValid,
    String? recipientName,
  }) {
    return TransferState(
      agency: agency ?? this.agency,
      account: account ?? this.account,
      amount: amount ?? this.amount,
      error: error,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isValid: isValid ?? this.isValid,
      recipientName: recipientName ?? this.recipientName,
    );
  }
}
