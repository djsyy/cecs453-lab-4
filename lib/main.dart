import 'dart:math';

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

class Mortgage {
  double amount;
  int years;
  double rate;

  // Values come from the lab example
  Mortgage({
    this.amount = 100000,
    this.years = 30,
    this.rate = 0.035,
  });

  double monthlyPayment() {
    double monthlyRate = rate / 12;
    double temp = pow(1 / (1 + monthlyRate), years * 12).toDouble();

    return amount * monthlyRate / (1 - temp);
  }

  double totalPayment() {
    return monthlyPayment() * years * 12;
  }
}
