import 'package:afinz_app/features/profile/presentation/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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
    final amountController = TextEditingController();

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
          // Remove navigation from here
        },
        builder: (context, state) {
          return CustomHeaderWidget.expanded(
            appBarTitle: 'Transferir',
            isLeadingIcon: true,
            onTapLeadingIcon: () => Navigator.pop(context),
            bottomNavigationWidget: CustomButtonWidget(
              title: state.isSubmitting ? 'Enviando...' : 'Continuar',
              isLoading: state.isSubmitting,
              onTap: state.isValid && !state.isSubmitting
                  ? () {
                      context.read<TransferBloc>().add(SubmitTransfer());
                      if (state.recipientName != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => TransferConfirmationPage(
                              toAgency: state.agency,
                              toAccount: state.account,
                              amountInCents: int.tryParse(state.amount) ?? 0,
                              currentBalanceInCents: homeState.balance,
                              fromAgency: homeState.profile.agency.toString(),
                              fromAccount: homeState.profile.account.toString(),
                              recipientName: state.recipientName,
                            ),
                          ),
                        );
                      }
                    }
                  : null,
            ),
            body: SafeArea(
              minimum: const EdgeInsets.only(top: 32, left: 24, right: 24),
              child: Column(
                children: [
                  InputWidget(
                    hintText: 'Agência',
                    onChanged: (v) {
                      context.read<TransferBloc>().add(AgencyChanged(v));
                      final state = context.read<TransferBloc>().state;
                      if (v.isNotEmpty && state.account.isNotEmpty && state.amount.isNotEmpty) {
                        context.read<TransferBloc>().add(ValidateAgencyAccount(v, state.account));
                      }
                    },
                  ),
                  const SizedBox(height: 12),
                  InputWidget(
                    hintText: 'Conta',
                    onChanged: (v) {
                      context.read<TransferBloc>().add(AccountChanged(v));
                      final state = context.read<TransferBloc>().state;
                      if (v.isNotEmpty && state.agency.isNotEmpty && state.amount.isNotEmpty) {
                        context.read<TransferBloc>().add(ValidateAgencyAccount(state.agency, v));
                      }
                    },
                  ),
                  const SizedBox(height: 12),
                  InputWidget(
                    controller: amountController,
                    hintText: 'Valor',
                    keyboardType: TextInputType.number,
                    onChanged: (v) {
                      if (v.isEmpty) {
                        context.read<TransferBloc>().add(AmountChanged(''));
                        return;
                      }
                      final numericValue = v.replaceAll(RegExp(r'[^0-9]'), '');
                      final amount = int.tryParse(numericValue) ?? 0;
                      final formatter = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$', decimalDigits: 2);
                      final formattedValue = formatter.format(amount / 100);
                      
                      amountController.value = TextEditingValue(
                        text: formattedValue,
                        selection: TextSelection.collapsed(offset: formattedValue.length),
                      );
                      
                      context.read<TransferBloc>().add(AmountChanged(numericValue));
                      
                      final state = context.read<TransferBloc>().state;
                      if (state.agency.isNotEmpty && state.account.isNotEmpty && amount > 0) {
                        context.read<TransferBloc>().add(ValidateAgencyAccount(state.agency, state.account));
                      }
                    },
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
