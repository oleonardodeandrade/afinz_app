import 'package:afinz_app/shared/widgets/buttons/custom_button_widget.dart';
import 'package:afinz_app/shared/widgets/data/custom_eye_value.dart';
import 'package:afinz_app/shared/widgets/layout/custom_header_widget.dart';
import 'package:afinz_app/shared/widgets/text/text_and_subtitle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../bloc/transfer_confirmation_bloc.dart' as transfer;
import 'receipt_page.dart';

class TransferConfirmationPage extends StatelessWidget {
  final String toAgency;
  final String toAccount;
  final int amountInCents;
  final int currentBalanceInCents;
  final String fromAgency;
  final String fromAccount;
  final String? recipientName;

  const TransferConfirmationPage({
    super.key,
    required this.toAgency,
    required this.toAccount,
    required this.amountInCents,
    required this.currentBalanceInCents,
    required this.fromAgency,
    required this.fromAccount,
    this.recipientName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => transfer.TransferConfirmationBloc(),
      child: _TransferConfirmationPageContent(
        toAgency: toAgency,
        toAccount: toAccount,
        amountInCents: amountInCents,
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
  final int amountInCents;
  final int currentBalanceInCents;
  final String fromAgency;
  final String fromAccount;
  final String? recipientName;

  const _TransferConfirmationPageContent({
    super.key,
    required this.toAgency,
    required this.toAccount,
    required this.amountInCents,
    required this.currentBalanceInCents,
    required this.fromAgency,
    required this.fromAccount,
    this.recipientName,
  });

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.currency(locale: 'pt_BR', symbol: '', decimalDigits: 2);
    final formattedValue = formatter.format(amountInCents / 100);
    final parts = formattedValue.split(',');
    final main = parts[0].replaceAll('R\$ ', '');
    final cents = parts[1];

    final newBalance = currentBalanceInCents - amountInCents;

    return BlocBuilder<transfer.TransferConfirmationBloc, transfer.TransferConfirmationState>(
      builder: (context, state) {
        return CustomHeaderWidget.expanded(
          appBarTitle: 'Transferir ',
          isLeadingIcon: true,
          onTapLeadingIcon: () => Navigator.pop(context),
          bottomNavigationWidget: CustomButtonWidget(
            title: 'Transferir',
            color: Colors.green,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ReceiptPage(
                    finalBalanceInCents: newBalance,
                    status: 'Aprovado',
                    dateTime: DateTime.now(),
                    toAgency: toAgency,
                    toAccount: toAccount,
                    amountInCents: amountInCents,
                    fromAgency: fromAgency,
                    fromAccount: fromAccount,
                  ),
                ),
              );
            },
          ),
          body: SafeArea(
            minimum: const EdgeInsets.only(top: 32, left: 24, right: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomEyeValue(
                  title: 'Valor a ser transferido',
                  value: main,
                  cents: cents,
                  onTap: () {
                    context.read<transfer.TransferConfirmationBloc>().add(transfer.ToggleValueVisibility());
                  },
                  isNotEye: false,
                  hideEye: !state.isValueVisible,
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