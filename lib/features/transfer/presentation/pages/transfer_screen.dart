import 'package:afinz_app/features/transfer/presentation/pages/transfer_confirmation_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      child: BlocBuilder<TransferBloc, TransferState>(
        builder: (context, state) {
          return CustomHeaderWidget.expanded(
            appBarTitle: 'Transferir',
            isLeadingIcon: true,
            onTapLeadingIcon: () => Navigator.pop(context),
            bottomNavigationWidget: CustomButtonWidget(
              title: 'Continuar',
              onTap: (state.agency.isNotEmpty && state.account.isNotEmpty)
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => TransferConfirmationPage(
                            toAgency: state.agency,
                            toAccount: state.account,
                            currentBalanceInCents: homeState.balance,
                            fromAgency: homeState.profile.agency.toString(),
                            fromAccount: homeState.profile.account.toString(),
                            recipientName: state.recipientName ?? '',
                          ),
                        ),
                      );
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
                      if (v.isNotEmpty && state.account.isNotEmpty) {
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
                      if (v.isNotEmpty && state.agency.isNotEmpty) {
                        context.read<TransferBloc>().add(ValidateAgencyAccount(state.agency, v));
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
