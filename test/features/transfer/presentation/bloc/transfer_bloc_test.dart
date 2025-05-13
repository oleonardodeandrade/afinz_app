import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:afinz_app/features/transfer/presentation/bloc/transfer_bloc.dart';
import 'package:afinz_app/features/transfer/presentation/bloc/transfer_event.dart';
import 'package:afinz_app/features/transfer/presentation/bloc/transfer_state.dart';

import '../../mocks/mock_transfer_repository.mocks.dart';

void main() {
  late MockTransferRepository repository;

  setUp(() {
    repository = MockTransferRepository();
  });

  group('TransferBloc', () {
    blocTest<TransferBloc, TransferState>(
      'emits updated state when fields are changed',
      build: () => TransferBloc(repository: repository, currentBalance: 10000),
      act: (bloc) => bloc
        ..add(AgencyChanged('3212'))
        ..add(AccountChanged('9073'))
        ..add(AmountChanged('500')),
      expect: () => [
        isA<TransferState>().having((s) => s.agency, 'agency', '3212'),
        isA<TransferState>().having((s) => s.account, 'account', '9073'),
        isA<TransferState>().having((s) => s.amount, 'amount', '500'),
      ],
    );

    blocTest<TransferBloc, TransferState>(
      'emits error when balance is insufficient',
      build: () => TransferBloc(repository: repository, currentBalance: 300),
      act: (bloc) {
        bloc
          ..add(AgencyChanged('3212'))
          ..add(AccountChanged('9073'))
          ..add(AmountChanged('500'))
          ..add(SubmitTransfer());
      },
      expect: () => [
        isA<TransferState>(),
        isA<TransferState>(),
        isA<TransferState>(),
        isA<TransferState>().having((s) => s.error, 'error', 'Insufficient balance'),
      ],
    );

    blocTest<TransferBloc, TransferState>(
      'emits success when transfer is successful',
      build: () {
        when(repository.transfer(
          agency: 3212,
          account: 9073,
          value: 500,
        )).thenAnswer((_) async {
          return;
        });
        return TransferBloc(repository: repository, currentBalance: 10000);
      },
      act: (bloc) {
        bloc
          ..add(AgencyChanged('3212'))
          ..add(AccountChanged('9073'))
          ..add(AmountChanged('500'))
          ..add(SubmitTransfer());
      },
      expect: () => [
        isA<TransferState>(),
        isA<TransferState>(),
        isA<TransferState>(),
        isA<TransferState>().having((s) => s.isSubmitting, 'isSubmitting', true),
        isA<TransferState>().having((s) => s.isSuccess, 'isSuccess', true),
      ],
    );

    blocTest<TransferBloc, TransferState>(
      'emits error when transfer fails',
      build: () {
        when(repository.transfer(
          agency: 3212,
          account: 9073,
          value: 500,
        )).thenThrow(Exception('API error'));
        return TransferBloc(repository: repository, currentBalance: 10000);
      },
      act: (bloc) {
        bloc
          ..add(AgencyChanged('3212'))
          ..add(AccountChanged('9073'))
          ..add(AmountChanged('500'))
          ..add(SubmitTransfer());
      },
      expect: () => [
        isA<TransferState>(),
        isA<TransferState>(),
        isA<TransferState>(),
        isA<TransferState>().having((s) => s.isSubmitting, 'isSubmitting', true),
        isA<TransferState>().having((s) => s.error, 'error', contains('Exception')),
      ],
    );
  });
}
