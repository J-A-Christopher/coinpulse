import 'package:coinpulse/providers/expense_provider.dart';
import 'package:coinpulse/utils/blocobserver.dart';
import 'package:coinpulse/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'home/navbar.dart';

void main() {
  // configureDependencies();
  Bloc.observer = AppGlobalBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();
    return ChangeNotifierProvider(
      create: (context) => ExpenseProvider(),
      child: MaterialApp(
          title: 'Coin Pulse',
          debugShowCheckedModeBanner: false,
          theme: theme.copyWith(
              colorScheme: theme.colorScheme.copyWith(
                  primary: ColorsUsed.primaryColor,
                  secondary: ColorsUsed.secondaryColor)),
          home: const BottomNavBar()
          // const HomePage(),
          ),
    );
  }
}
