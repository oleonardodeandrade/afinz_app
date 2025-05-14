import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ReceiptEvent {}

class ToggleBalanceVisibility extends ReceiptEvent {}

class ReceiptState {
  final bool isBalanceVisible;

  ReceiptState({this.isBalanceVisible = true});

  ReceiptState copyWith({bool? isBalanceVisible}) {
    return ReceiptState(
      isBalanceVisible: isBalanceVisible ?? this.isBalanceVisible,
    );
  }
}

class ReceiptBloc extends Bloc<ReceiptEvent, ReceiptState> {
  ReceiptBloc() : super(ReceiptState()) {
    on<ToggleBalanceVisibility>((event, emit) {
      emit(state.copyWith(isBalanceVisible: !state.isBalanceVisible));
    });
  }
} 