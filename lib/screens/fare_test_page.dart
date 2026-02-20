import 'package:flutter/material.dart';
import '../utils/helper.dart';
import '../utils/colors.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';

class FareTestPage extends StatefulWidget {
  const FareTestPage({super.key});

  @override
  State<FareTestPage> createState() => _FareTestPageState();
}

class _FareTestPageState extends State<FareTestPage> {
  final TextEditingController _distanceController = TextEditingController();
  double _totalFare = 0.0;
  String _selectedVehicle = 'safir_taxi';

  void _calculateFare() {
    double distance = double.tryParse(_distanceController.text) ?? 0;
    // نرخ‌ها: برای لاری (cargo) ورودی ۲۰۰، برای سواری (taxi) ۵۰
    double baseFare = (_selectedVehicle == 'safir_cargo') ? 200 : 50;
    double perKm = (_selectedVehicle == 'safir_cargo') ? 30 : 12;

    setState(() {
      _totalFare = baseFare + (distance * perKm);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tr(context, 'fare'))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _vehicleOption(Icons.local_taxi, tr(context, 'safir_taxi'), 'safir_taxi'),
                _vehicleOption(Icons.local_shipping, tr(context, 'safir_cargo'), 'safir_cargo'),
              ],
            ),
            const SizedBox(height: 30),
            CustomTextField(
              hintText: tr(context, 'distance'),
              controller: _distanceController,
              keyboardType: TextInputType.number,
              prefixIcon: Icons.straighten,
            ),
            const SizedBox(height: 25),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: SafirColors.primaryGreen.withOpacity(0.05),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: SafirColors.primaryGreen.withOpacity(0.2)),
              ),
              child: Column(
                children: [
                  Text(tr(context, 'total_fare'), style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 10),
                  Text(
                    "${_totalFare.toInt()} ${tr(context, 'afn')}",
                    style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: SafirColors.primaryGreen),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            CustomButton(
              text: tr(context, 'calculate_fare'),
              onPressed: _calculateFare,
            ),
          ],
        ),
      ),
    );
  }

  Widget _vehicleOption(IconData icon, String label, String type) {
    bool isSelected = _selectedVehicle == type;
    return GestureDetector(
      onTap: () => setState(() => _selectedVehicle = type),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: isSelected ? SafirColors.primaryGreen : Colors.grey.shade200,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: isSelected ? Colors.white : Colors.grey),
          ),
          const SizedBox(height: 8),
          Text(label, style: TextStyle(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }
}
