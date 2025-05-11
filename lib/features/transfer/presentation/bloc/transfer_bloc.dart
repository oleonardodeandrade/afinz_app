import 'package:afinz_app/features/transfer/domain/repositories/transfer_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'transfer_event.dart';
import 'transfer_state.dart';

class TransferBloc extends Bloc<TransferEvent, TransferState> {
  final TransferRepository repository;
  final int currentBalance;

  TransferBloc({required this.repository, required this.currentBalance})
    : super(TransferState.initial()) {
    on<AgencyChanged>(
      (e, emit) => emit(state.copyWith(agency: e.value, error: null)),
    );
    on<AccountChanged>(
      (e, emit) => emit(state.copyWith(account: e.value, error: null)),
    );
    on<AmountChanged>(
      (e, emit) => emit(state.copyWith(amount: e.value, error: null)),
    );

    on<SubmitTransfer>((event, emit) async {
      if (!state.isValid) {
        emit(state.copyWith(error: 'Preencha todos os campos corretamente'));
        return;
      }

      final amountInCents = int.parse(state.amount);
      if (amountInCents > currentBalance) {
        emit(state.copyWith(error: 'Saldo insuficiente'));
        return;
      }

      emit(state.copyWith(isSubmitting: true, error: null));

      try {
        await repository.transfer(
          agency: int.parse(state.agency),
          account: int.parse(state.account),
          value: amountInCents,
        );
        emit(state.copyWith(isSubmitting: false, isSuccess: true));
      } catch (e) {
        emit(state.copyWith(isSubmitting: false, error: e.toString()));
      }
    });
  }
}
