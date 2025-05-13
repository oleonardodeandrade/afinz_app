import 'package:afinz_app/features/transfer/presentation/pages/receipt_page.dart';
import 'package:afinz_app/shared/widgets/text/text_and_subtitle.dart';
import 'package:flutter/material.dart';

import '../../../../shared/widgets/buttons/custom_button_widget.dart';
import '../../../../shared/widgets/data/custom_eye_value.dart';
import '../../../../shared/widgets/layout/custom_header_widget.dart';

class TransferConfirmationPage extends StatelessWidget {
  final String toAgency;
  final String toAccount;
  final int amountInCents;
  final int currentBalanceInCents;
  final String fromAgency;
  final String fromAccount;

  const TransferConfirmationPage({
    super.key,
    required this.toAgency,
    required this.toAccount,
    required this.amountInCents,
    required this.currentBalanceInCents,
    required this.fromAgency,
    required this.fromAccount,
  });

  @override
  Widget build(BuildContext context) {
    final formattedValue = (amountInCents / 100).toStringAsFixed(2);
    final parts = formattedValue.split('.');
    final main = parts[0];
    final cents = parts[1];

    final newBalance = currentBalanceInCents - amountInCents;

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
              onTap: () {},
              isNotEye: false,
              hideEye: false,
            ),
            const SizedBox(height: 32),
            const CustomTitleWithSubtitleWidget(
              title: 'Transferir para',
              subtitle: 'Leonardo',
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
  }
}
