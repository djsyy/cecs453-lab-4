import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MortgageApp());
}

class MortgageApp extends StatelessWidget {
  MortgageApp({super.key});

  final Mortgage mortgage = Mortgage();

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
              Text('Mortgage Amount: \$${mortgage.amount.toStringAsFixed(2)}'),
              const SizedBox(height: 16),
              Text('Number of Years: ${mortgage.years}'),
              const SizedBox(height: 16),
              Text(
                'Interest Rate: ${(mortgage.rate * 100).toStringAsFixed(2)}%',
              ),
              const SizedBox(height: 16),
              Text(
                'Monthly Payment: \$${mortgage.monthlyPayment().toStringAsFixed(2)}',
              ),
              const SizedBox(height: 16),
              Text(
                'Total Payment: \$${mortgage.totalPayment().toStringAsFixed(2)}',
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ModifyScreen(),
                    ),
                  );
                },
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

class ModifyScreen extends StatelessWidget {
  const ModifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Modify Mortgage Data')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('DONE'),
        ),
      ),
    );
  }
}
