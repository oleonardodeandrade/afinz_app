import 'package:afinz_app/shared/widgets/dividers/divider_widget.dart';
import 'package:afinz_app/shared/widgets/text/text_and_subtitle.dart';
import 'package:flutter/material.dart';

import '../../../../shared/widgets/buttons/custom_button_widget.dart';
import '../../../../shared/widgets/data/custom_eye_value.dart';
import '../../../../shared/widgets/layout/custom_header_widget.dart';
import '../../../app/presentation/pages/home_screen.dart';

class ReceiptPage extends StatelessWidget {
  final int finalBalanceInCents;
  final String status;
  final DateTime dateTime;
  final String toAgency;
  final String toAccount;
  final int amountInCents;
  final String fromAgency;
  final String fromAccount;

  const ReceiptPage({
    super.key,
    required this.finalBalanceInCents,
    required this.status,
    required this.dateTime,
    required this.toAgency,
    required this.toAccount,
    required this.amountInCents,
    required this.fromAgency,
    required this.fromAccount,
  });

  @override
  Widget build(BuildContext context) {
    final balanceFormatted = (finalBalanceInCents / 100).toStringAsFixed(2).split('.');
    final amountFormatted = (amountInCents / 100).toStringAsFixed(2);
    final dateStr = "${dateTime.day}/${dateTime.month}/${dateTime.year}";
    final timeStr = "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";

    return CustomHeaderWidget.expanded(
      appBarTitle: 'Comprovante',
      isLeadingIcon: true,
      onTapLeadingIcon: () => Navigator.pop(context),
      bottomNavigationWidget: CustomButtonWidget(
        title: 'Voltar para home ',
        color: Colors.green,
        onTap: () {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const HomeScreen()),
            (route) => false,
          );
        },
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          minimum: const EdgeInsets.only(top: 30, left: 24, right: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomEyeValue(
                title: 'Novo Saldo',
                value: balanceFormatted[0],
                cents: balanceFormatted[1],
                onTap: () {},
                isNotEye: false,
                hideEye: false,
              ),
              const SizedBox(height: 32),
              CustomTitleWithSubtitleWidget(
                title: 'Status',
                subtitle: status,
              ),
              CustomTitleWithSubtitleWidget(
                title: 'Data - Hora',
                subtitle: '$dateStr - $timeStr',
              ),
              const SizedBox(height: 16),
              const CustomDividerWidget(),
              const SizedBox(height: 28),
              CustomTitleWithSubtitleWidget(
                title: 'Agência',
                subtitle: toAgency,
              ),
              CustomTitleWithSubtitleWidget(
                title: 'Conta',
                subtitle: toAccount,
              ),
              const CustomDividerWidget(),
              const SizedBox(height: 28),
              CustomTitleWithSubtitleWidget(
                title: 'Valor',
                subtitle: 'R\$ $amountFormatted',
              ),
              CustomTitleWithSubtitleWidget(
                title: 'Sua conta',
                subtitle: fromAccount,
              ),
              CustomTitleWithSubtitleWidget(
                title: 'Sua agência',
                subtitle: fromAgency,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
