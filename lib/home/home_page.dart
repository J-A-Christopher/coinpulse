import 'package:coinpulse/home/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coin Pulse'),
      ),
      body: const Center(
        child: Column(
          children: [WelcomeScreen()],
        ),
      ),
    );
  }
}
