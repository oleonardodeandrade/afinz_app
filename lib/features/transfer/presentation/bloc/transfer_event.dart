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

class ValidateAgencyAccount extends TransferEvent {
  final String agency;
  final String account;

  ValidateAgencyAccount(this.agency, this.account);
}

class SubmitTransfer extends TransferEvent {}
