import 'package:afinz_app/features/transfer/data/repositories/transfer_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

import '../../data/datasources/transfer_remote_datasource.dart';
import '../bloc/transfer_bloc.dart';
import '../bloc/transfer_event.dart';
import '../bloc/transfer_state.dart';
import '../../../app/presentation/bloc/home_bloc.dart';
import '../../../app/presentation/bloc/home_state.dart';

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
        repository: TransferRepositoryImpl(TransferRemoteDatasourceImpl(Dio())),
        currentBalance: homeState.balance,
      ),
      child: Scaffold(
        appBar: AppBar(title: const Text('Transferir')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocConsumer<TransferBloc, TransferState>(
            listener: (context, state) {
              if (state.isSuccess) {
                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  TextField(
                    decoration: const InputDecoration(labelText: 'Agencia'),
                    onChanged: (v) => context.read<TransferBloc>().add(AgencyChanged(v)),
                  ),
                  TextField(
                    decoration: const InputDecoration(labelText: 'Conta'),
                    onChanged: (v) => context.read<TransferBloc>().add(AccountChanged(v)),
                  ),
                  TextField(
                    decoration: const InputDecoration(labelText: 'Saldo'),
                    keyboardType: TextInputType.number,
                    onChanged: (v) => context.read<TransferBloc>().add(AmountChanged(v)),
                  ),
                  const SizedBox(height: 20),
                  if (state.error != null)
                    Text(state.error!, style: const TextStyle(color: Colors.red)),
                  ElevatedButton(
                    onPressed: state.isValid && !state.isSubmitting
                        ? () => context.read<TransferBloc>().add(SubmitTransfer())
                        : null,
                    child: state.isSubmitting
                        ? const CircularProgressIndicator()
                        : const Text('Transferir'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
