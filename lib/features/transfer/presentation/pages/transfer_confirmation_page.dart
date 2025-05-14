import 'package:afinz_app/features/transfer/presentation/pages/receipt_page.dart';
import 'package:afinz_app/shared/widgets/text/text_and_subtitle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../bloc/transfer_confirmation_bloc.dart' as confirmation;

import '../../../../shared/widgets/buttons/custom_button_widget.dart';
import '../../../../shared/widgets/data/custom_eye_value.dart';
import '../../../../shared/widgets/layout/custom_header_widget.dart';
import '../../../../shared/widgets/inputs/input_widget.dart';

class TransferConfirmationPage extends StatelessWidget {
  final String toAgency;
  final String toAccount;
  final int currentBalanceInCents;
  final String fromAgency;
  final String fromAccount;
  final String? recipientName;

  const TransferConfirmationPage({
    super.key,
    required this.toAgency,
    required this.toAccount,
    required this.currentBalanceInCents,
    required this.fromAgency,
    required this.fromAccount,
    this.recipientName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => confirmation.TransferConfirmationBloc(),
      child: _TransferConfirmationPageContent(
        toAgency: toAgency,
        toAccount: toAccount,
        currentBalanceInCents: currentBalanceInCents,
        fromAgency: fromAgency,
        fromAccount: fromAccount,
        recipientName: recipientName,
      ),
    );
  }
}

class _TransferConfirmationPageContent extends StatelessWidget {
  final String toAgency;
  final String toAccount;
  final int currentBalanceInCents;
  final String fromAgency;
  final String fromAccount;
  final String? recipientName;
  final _amountController = TextEditingController();

  _TransferConfirmationPageContent({
    required this.toAgency,
    required this.toAccount,
    required this.currentBalanceInCents,
    required this.fromAgency,
    required this.fromAccount,
    this.recipientName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<confirmation.TransferConfirmationBloc, confirmation.TransferConfirmationState>(
      builder: (context, state) {
        final formatter = NumberFormat.currency(locale: 'pt_BR', symbol: '', decimalDigits: 2);
        final formattedBalance = formatter.format(currentBalanceInCents / 100);
        final parts = formattedBalance.split(',');
        final main = parts[0].replaceAll('R\$ ', '');
        final cents = parts[1];

        return CustomHeaderWidget.expanded(
          appBarTitle: 'Transferir',
          isLeadingIcon: true,
          onTapLeadingIcon: () => Navigator.pop(context),
          bottomNavigationWidget: CustomButtonWidget(
            title: 'Transferir',
            color: Colors.green,
            onTap: () {
              final amount = int.tryParse(state.amount) ?? 0;
              if (amount > 0) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ReceiptPage(
                      finalBalanceInCents: currentBalanceInCents - amount,
                      status: 'Aprovado',
                      dateTime: DateTime.now(),
                      toAgency: toAgency,
                      toAccount: toAccount,
                      amountInCents: amount,
                      fromAgency: fromAgency,
                      fromAccount: fromAccount,
                    ),
                  ),
                );
              }
            },
          ),
          body: SafeArea(
            minimum: const EdgeInsets.only(top: 32, left: 24, right: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomEyeValue(
                  title: 'Saldo em conta',
                  value: main,
                  cents: cents,
                  onTap: () {
                    context.read<confirmation.TransferConfirmationBloc>().add(confirmation.ToggleValueVisibility());
                  },
                  isNotEye: false,
                  hideEye: !state.isValueVisible,
                ),
                const SizedBox(height: 32),
                InputWidget(
                  controller: _amountController,
                  hintText: 'Valor a ser transferido',
                  keyboardType: TextInputType.number,
                  onChanged: (v) {
                    if (v.isEmpty) {
                      context.read<confirmation.TransferConfirmationBloc>().add(confirmation.AmountChanged(''));
                      return;
                    }
                    final numericValue = v.replaceAll(RegExp(r'[^0-9]'), '');
                    final amount = int.tryParse(numericValue) ?? 0;
                    final formatter = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$', decimalDigits: 2);
                    final formattedValue = formatter.format(amount / 100);
                    
                    _amountController.value = TextEditingValue(
                      text: formattedValue,
                      selection: TextSelection.collapsed(offset: formattedValue.length),
                    );
                    
                    context.read<confirmation.TransferConfirmationBloc>().add(confirmation.AmountChanged(numericValue));
                  },
                ),
                const SizedBox(height: 32),
                CustomTitleWithSubtitleWidget(
                  title: 'Transferir para',
                  subtitle: recipientName ?? '',
                ),
                CustomTitleWithSubtitleWidget(
                  title: 'Agência',
                  subtitle: toAgency,
                ),
                CustomTitleWithSubtitleWidget(
                  title: 'Conta',
                  subtitle: toAccount,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
