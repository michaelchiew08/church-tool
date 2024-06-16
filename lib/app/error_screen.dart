import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Error one',
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.home_outlined),
              label: const Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'Go Home',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              onPressed: () => context.go('/'),
            ),
          ],
        ),
      ),
    );
  }
}
