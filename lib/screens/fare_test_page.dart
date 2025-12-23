import 'package:flutter/material.dart';
import '../logic/fare_calculator.dart';

class FareTestPage extends StatefulWidget {
  const FareTestPage({Key? key}) : super(key: key);

  @override
  _FareTestPageState createState() => _FareTestPageState();
}

class _FareTestPageState extends State<FareTestPage> {
  final TextEditingController _distanceController = TextEditingController();
  Map<String, double>? _result;

  final FareCalculator calculator = FareCalculator(
    basePrice: 50,
    pricePerKm: 20,
    commissionPercent: 10,
  );

  void _calculateFare() {
    double distance = double.tryParse(_distanceController.text) ?? 0;
    setState(() {
      _result = calculator.calculate(distance);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fare Test')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _distanceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Distance (km)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _calculateFare,
              child: const Text('Calculate Fare'),
            ),
            const SizedBox(height: 24),
            if (_result != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Total Price: ${_result!['price']!.toStringAsFixed(2)}'),
                  Text('Commission: ${_result!['commission']!.toStringAsFixed(2)}'),
                  Text('Driver Earn: ${_result!['driverEarn']!.toStringAsFixed(2)}'),
                ],
              ),
          ],
        ),
      ),
    );
  }
}