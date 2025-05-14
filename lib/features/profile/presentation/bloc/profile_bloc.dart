import 'package:flutter_bloc/flutter_bloc.dart';

abstract class TransferConfirmationEvent {}

class ToggleValueVisibility extends TransferConfirmationEvent {}

class AmountChanged extends TransferConfirmationEvent {
  final String amount;
  AmountChanged(this.amount);
}

class TransferConfirmationState {
  final bool isValueVisible;
  final String amount;

  TransferConfirmationState({
    this.isValueVisible = true,
    this.amount = '',
  });

  TransferConfirmationState copyWith({
    bool? isValueVisible,
    String? amount,
  }) {
    return TransferConfirmationState(
      isValueVisible: isValueVisible ?? this.isValueVisible,
      amount: amount ?? this.amount,
    );
  }
}


class TransferConfirmationBloc extends Bloc<TransferConfirmationEvent, TransferConfirmationState> {
  TransferConfirmationBloc() : super(TransferConfirmationState()) {
    on<ToggleValueVisibility>((event, emit) {
      emit(state.copyWith(isValueVisible: !state.isValueVisible));
    });

    on<AmountChanged>((event, emit) {
      emit(state.copyWith(amount: event.amount));
    });
  }
} 