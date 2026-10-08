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

class ModifyScreen extends StatefulWidget {
  const ModifyScreen({super.key});

  @override
  State<ModifyScreen> createState() => _ModifyScreenState();
}

class _ModifyScreenState extends State<ModifyScreen> {
  final TextEditingController amountController = TextEditingController(
    text: '100000',
  );
  final TextEditingController yearsController = TextEditingController(text: '30');
  final List<double> rates = [];
  int selectedRateIndex = 6;
  double selectedRate = 0.035;

  @override
  void initState() {
    super.initState();

    for (int index = 0; index <= 52; index++) {
      rates.add(0.02 + (index * 0.0025));
    }
  }

  @override
  void dispose() {
    amountController.dispose();
    yearsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Modify Mortgage Data')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Mortgage Amount'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: yearsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Number of Years'),
            ),
            const SizedBox(height: 24),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Interest Rate'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: rates.length,
                itemBuilder: (context, index) {
                  double rate = rates[index];

                  return ListTile(
                    title: Text('${(rate * 100).toStringAsFixed(2)}%'),
                    selected: index == selectedRateIndex,
                    onTap: () {
                      setState(() {
                        selectedRateIndex = index;
                        selectedRate = rate;
                      });
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('DONE'),
            ),
          ],
        ),
      ),
    );
  }
}
