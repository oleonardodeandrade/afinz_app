import 'package:flutter_bloc/flutter_bloc.dart';

// Events
abstract class TransferConfirmationEvent {}

class ToggleValueVisibility extends TransferConfirmationEvent {}

// State
class TransferConfirmationState {
  final bool isValueVisible;

  TransferConfirmationState({this.isValueVisible = true});

  TransferConfirmationState copyWith({bool? isValueVisible}) {
    return TransferConfirmationState(
      isValueVisible: isValueVisible ?? this.isValueVisible,
    );
  }
}

// Bloc
class TransferConfirmationBloc extends Bloc<TransferConfirmationEvent, TransferConfirmationState> {
  TransferConfirmationBloc() : super(TransferConfirmationState()) {
    on<ToggleValueVisibility>((event, emit) {
      emit(state.copyWith(isValueVisible: !state.isValueVisible));
    });
  }
} 