// IMPORTS
import 'package:afinz_app/features/profile/presentation/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

import '../../../app/presentation/bloc/home_bloc.dart';
import '../../../app/presentation/bloc/home_state.dart';
import '../../data/datasources/transfer_remote_datasource.dart';
import '../../data/repositories/transfer_repository_impl.dart';
import '../bloc/transfer_bloc.dart';
import '../bloc/transfer_event.dart';
import '../bloc/transfer_state.dart';

import '../../../../shared/widgets/inputs/input_widget.dart';
import '../../../../shared/widgets/layout/custom_header_widget.dart';
import '../../../../shared/widgets/buttons/custom_button_widget.dart';

class TransferScreen extends StatelessWidget {
  const TransferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeState = context.read<HomeBloc>().state;

    if (homeState is! HomeLoaded) {
      return const Scaffold(body: Center(child: Text('Saldo não carregado')));
    }

    return BlocProvider(
      create: (_) => TransferBloc(
        repository: TransferRepositoryImpl(TransferRemoteDatasourceImpl()),
        currentBalance: homeState.balance,
      ),
      child: BlocConsumer<TransferBloc, TransferState>(
        listener: (context, state) {
          if (state.isSuccess) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (_) => TransferConfirmationPage(
                      toAgency: state.agency,
                      toAccount: state.account,
                      amountInCents: int.tryParse(state.amount) ?? 0,
                      currentBalanceInCents: homeState.balance,
                      fromAgency: homeState.profile.agency.toString(),
                      fromAccount: homeState.profile.account.toString(),
                    ),
              ),
            );
          }
        },
        builder: (context, state) {
          return CustomHeaderWidget.expanded(
            appBarTitle: 'Transferir',
            isLeadingIcon: true,
            onTapLeadingIcon: () => Navigator.pop(context),
            bottomNavigationWidget: CustomButtonWidget(
              title: state.isSubmitting ? 'Enviando...' : 'Continuar',
              isLoading: state.isSubmitting,
              onTap:
                  state.isValid && !state.isSubmitting
                      ? () {
                        context.read<TransferBloc>().add(SubmitTransfer());
                      }
                      : null,
            ),
            body: SafeArea(
              minimum: const EdgeInsets.only(top: 32, left: 24, right: 24),
              child: Column(
                children: [
                  InputWidget(
                    hintText: 'Agência',
                    onChanged:
                        (v) =>
                            context.read<TransferBloc>().add(AgencyChanged(v)),
                  ),
                  const SizedBox(height: 12),
                  InputWidget(
                    hintText: 'Conta',
                    onChanged:
                        (v) =>
                            context.read<TransferBloc>().add(AccountChanged(v)),
                  ),
                  const SizedBox(height: 12),
                  InputWidget(
                    hintText: 'Valor',
                    keyboardType: TextInputType.number,
                    onChanged:
                        (v) =>
                            context.read<TransferBloc>().add(AmountChanged(v)),
                  ),
                  if (state.error != null) ...[
                    const SizedBox(height: 12),
                    Text(
                      state.error!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
