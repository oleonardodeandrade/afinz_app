import 'package:afinz_app/shared/widgets/dividers/divider_widget.dart';
import 'package:afinz_app/shared/widgets/text/text_and_subtitle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../shared/widgets/buttons/custom_button_widget.dart';
import '../../../../shared/widgets/data/custom_eye_value.dart';
import '../../../../shared/widgets/layout/custom_header_widget.dart';
import '../../../app/presentation/bloc/home_bloc.dart';
import '../../../app/presentation/bloc/home_event.dart';
import '../../../app/presentation/pages/home_screen.dart';
import '../bloc/receipt_bloc.dart' as receipt;

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
    return BlocProvider(
      create: (context) => receipt.ReceiptBloc(),
      child: _ReceiptPageContent(
        finalBalanceInCents: finalBalanceInCents,
        status: status,
        dateTime: dateTime,
        toAgency: toAgency,
        toAccount: toAccount,
        amountInCents: amountInCents,
        fromAgency: fromAgency,
        fromAccount: fromAccount,
      ),
    );
  }
}

class _ReceiptPageContent extends StatelessWidget {
  final int finalBalanceInCents;
  final String status;
  final DateTime dateTime;
  final String toAgency;
  final String toAccount;
  final int amountInCents;
  final String fromAgency;
  final String fromAccount;

  const _ReceiptPageContent({
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
    final formatter = NumberFormat.currency(locale: 'pt_BR', symbol: '', decimalDigits: 2);
    final formattedBalance = formatter.format(finalBalanceInCents / 100);
    final parts = formattedBalance.split(',');
    final main = parts[0].replaceAll('R\$ ', '');
    final cents = parts[1];

    final amountFormatted = formatter.format(amountInCents / 100);
    final dateStr = "${dateTime.day}/${dateTime.month}/${dateTime.year}";
    final timeStr = "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";

    return BlocBuilder<receipt.ReceiptBloc, receipt.ReceiptState>(
      builder: (context, state) {
        return CustomHeaderWidget.expanded(
          appBarTitle: 'Comprovante',
          isLeadingIcon: true,
          onTapLeadingIcon: () => Navigator.pop(context),
          bottomNavigationWidget: CustomButtonWidget(
            title: 'Voltar para home ',
            color: Colors.green,
            onTap: () {
              context.read<HomeBloc>().add(UpdateBalance(finalBalanceInCents));
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
                    value: main,
                    cents: cents,
                    onTap: () {
                      context.read<receipt.ReceiptBloc>().add(receipt.ToggleBalanceVisibility());
                    },
                    isNotEye: false,
                    hideEye: !state.isBalanceVisible,
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
                    subtitle: amountFormatted,
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
      },
    );
  }
}
