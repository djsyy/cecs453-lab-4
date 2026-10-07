import 'package:flutter/material.dart';

void main() {
  runApp(const MortgageApp());
}

class MortgageApp extends StatelessWidget {
  const MortgageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mortgage Calculator',
      home: Scaffold(
        appBar: AppBar(title: const Text('Mortgage Calculator')),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Mortgage Amount: \$100000'),
              const SizedBox(height: 16),
              const Text('Number of Years: 30'),
              const SizedBox(height: 16),
              const Text('Interest Rate: 3.5%'),
              const SizedBox(height: 16),
              const Text('Monthly Payment: Coming soon'),
              const SizedBox(height: 16),
              const Text('Total Payment: Coming soon'),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {},
                child: const Text('MODIFY DATA'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
