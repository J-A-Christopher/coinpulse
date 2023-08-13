import 'package:coinpulse/home/home_page.dart';
import 'package:coinpulse/utils/colors.dart';
import 'package:flutter/material.dart';

import 'home/navbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();
    return MaterialApp(
        title: 'Coin Pulse',
        debugShowCheckedModeBanner: false,
        theme: theme.copyWith(
            colorScheme: theme.colorScheme.copyWith(
                primary: ColorsUsed.primaryColor,
                secondary: ColorsUsed.secondaryColor)),
        home: const BottomNavBar()
        // const HomePage(),
        );
  }
}
