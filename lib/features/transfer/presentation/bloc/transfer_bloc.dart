import 'package:afinz_app/features/transfer/domain/repositories/transfer_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'transfer_event.dart';
import 'transfer_state.dart';

class TransferBloc extends Bloc<TransferEvent, TransferState> {
  final TransferRepository repository;
  final int currentBalance;

  TransferBloc({
    required this.repository,
    required this.currentBalance,
  }) : super(TransferState()) {
    on<AgencyChanged>((event, emit) {
      emit(state.copyWith(
        agency: event.value,
        error: null,
      ));
    });

    on<AccountChanged>((event, emit) {
      emit(state.copyWith(
        account: event.value,
        error: null,
      ));
    });

    on<AmountChanged>((event, emit) {
      emit(state.copyWith(
        amount: event.value,
        error: null,
      ));
    });

    on<ValidateAgencyAccount>((event, emit) async {
      if (event.agency.isEmpty || event.account.isEmpty) return;

      try {
        emit(state.copyWith(isSubmitting: true, error: null));
        final recipientName = await repository.validateAgencyAccount(
          agency: int.parse(event.agency),
          account: int.parse(event.account),
        );
        emit(state.copyWith(
          isSubmitting: false,
          recipientName: recipientName,
          isValid: true,
        ));
      } catch (e) {
        emit(state.copyWith(
          isSubmitting: false,
          error: 'Conta não encontrada. Verifique os dados e tente novamente.',
          isValid: false,
        ));
      }
    });

    on<SubmitTransfer>((event, emit) async {
      if (!state.isFormValid) return;

      final amount = int.tryParse(state.amount);
      if (amount == null || amount <= 0) {
        emit(state.copyWith(error: 'Valor inválido'));
        return;
      }

      if (amount > currentBalance) {
        emit(state.copyWith(error: 'Saldo insuficiente'));
        return;
      }

      try {
        emit(state.copyWith(isSubmitting: true, error: null));

        final recipientName = await repository.validateAgencyAccount(
          agency: int.parse(state.agency),
          account: int.parse(state.account),
        );

        await repository.transfer(
          value: amount,
          agency: int.parse(state.agency),
          account: int.parse(state.account),
        );

        emit(state.copyWith(
          isSubmitting: false,
          recipientName: recipientName,
          isValid: true,
        ));
      } catch (e) {
        emit(state.copyWith(
          isSubmitting: false,
          error: 'Não foi possível realizar a transferência. Tente novamente.',
          isValid: false,
        ));
      }
    });
  }
}
