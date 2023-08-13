import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            ElevatedButton(onPressed: () {}, child: const Text('Legend')),
            FloatingActionButton(
              onPressed: () {},
              child: const Text('mj'),
            )
          ],
        ),
      ),
    );
  }
}
