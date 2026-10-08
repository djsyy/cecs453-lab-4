import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MortgageApp());
}

class MortgageApp extends StatefulWidget {
  const MortgageApp({super.key});

  @override
  State<MortgageApp> createState() => _MortgageAppState();
}

class _MortgageAppState extends State<MortgageApp> {
  Mortgage mortgage = Mortgage();
  bool termsAccepted = false;

  void modifyMortgage() async {
    Mortgage? updatedMortgage = await Navigator.push<Mortgage>(
      context,
      MaterialPageRoute(
        builder: (context) => ModifyScreen(mortgage: mortgage),
      ),
    );

    if (updatedMortgage != null) {
      setState(() {
        mortgage = updatedMortgage;
      });
    }
  }

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
              CheckboxListTile(
                title: const Text('Terms and Conditions'),
                value: termsAccepted,
                onChanged: (bool? value) {
                  setState(() {
                    termsAccepted = value ?? false;
                  });

                  if (value == true) {
                    showDialog<void>(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Terms and Conditions'),
                          content: const Text(
                            'You have accepted the terms and conditions.',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: modifyMortgage,
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
  const ModifyScreen({super.key, required this.mortgage});

  final Mortgage mortgage;

  @override
  State<ModifyScreen> createState() => _ModifyScreenState();
}

class _ModifyScreenState extends State<ModifyScreen> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController yearsController = TextEditingController();
  final List<double> rates = [];
  int selectedRateIndex = 0;
  double selectedRate = 0;

  @override
  void initState() {
    super.initState();

    amountController.text = widget.mortgage.amount.toString();
    yearsController.text = widget.mortgage.years.toString();

    for (int index = 0; index <= 52; index++) {
      rates.add(0.02 + (index * 0.0025));
    }

    selectedRateIndex = ((widget.mortgage.rate - 0.02) / 0.0025).round();
    selectedRate = rates[selectedRateIndex];
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
                double amount =
                    double.tryParse(amountController.text) ??
                    widget.mortgage.amount;
                int years =
                    int.tryParse(yearsController.text) ?? widget.mortgage.years;

                Navigator.pop(
                  context,
                  Mortgage(
                    amount: amount,
                    years: years,
                    rate: selectedRate,
                  ),
                );
              },
              child: const Text('DONE'),
            ),
          ],
        ),
      ),
    );
  }
}
