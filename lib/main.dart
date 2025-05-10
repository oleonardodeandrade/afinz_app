import 'package:afinz_app/features/transfer/presentation/pages/transfer_screen_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'core/injection.dart' as di;
import 'features/app/presentation/bloc/home_bloc.dart';
import 'features/app/presentation/bloc/home_event.dart';
import 'features/app/presentation/pages/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.getIt<HomeBloc>()..add(LoadHomeData()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Afinz Home',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (_) => const HomeScreen(),
          '/transfer': (_) => const TransferScreenPlaceholder(),
        },
      ),
    );
  }
}
