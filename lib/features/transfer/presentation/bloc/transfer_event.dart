abstract class TransferEvent {}

class AgencyChanged extends TransferEvent {
  final String value;
  AgencyChanged(this.value);
}

class AccountChanged extends TransferEvent {
  final String value;
  AccountChanged(this.value);
}

class AmountChanged extends TransferEvent {
  final String value;
  AmountChanged(this.value);
}

class SubmitTransfer extends TransferEvent {}
