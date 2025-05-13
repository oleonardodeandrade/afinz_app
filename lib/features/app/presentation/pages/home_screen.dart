import 'package:afinz_app/shared/widgets/custom_welcome_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/widgets/layout/custom_header_widget.dart';
import '../../../../shared/widgets/buttons/custom_button_widget.dart';
import '../../../../shared/widgets/banner_widget.dart';
import '../../../../shared/widgets/data/custom_eye_value.dart';

import '../bloc/home_bloc.dart';
import '../bloc/home_state.dart';
import '../bloc/home_event.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        if (state is HomeError) {
          return Scaffold(body: Center(child: Text(state.message)));
        }

        if (state is HomeLoaded) {
          final name = state.profile.name;
          final balance = (state.balance / 100).toStringAsFixed(2);
          final parts = balance.split('.');
          final main = parts[0];
          final cents = parts[1];

          return CustomHeaderWidget(
            bottomNavigationWidget: CustomButtonWidget(
              title: 'Realizar transferência',
              onTap: () => Navigator.pushNamed(context, '/transfer'),
            ),
            body: SafeArea(
              minimum: const EdgeInsets.only(top: 60, left: 24, right: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomWelcomeWidget(
                    namedUser: name,
                    onTap: () => context.read<HomeBloc>().add(ToggleBalanceVisibility()),
                  ),
                  const SizedBox(height: 32),
                  const CustomBannerWidget(),
                  const SizedBox(height: 16),
                  CustomEyeValue(
                    title: 'saldo',
                    value: main,
                    cents: cents,
                    onTap: () => {},
                    isNotEye: true,
                    hideEye: !state.isBalanceVisible,
                  )
                ],
              ),
            ),
          );
        }

        return const Scaffold(body: Center(child: Text('Erro desconhecido')));
      },
    );
  }
}
