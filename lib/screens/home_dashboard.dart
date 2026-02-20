import 'package:flutter/material.dart';
import '../utils/helper.dart';
import '../utils/colors.dart';

class HomeDashboard extends StatelessWidget {
  const HomeDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tr(context, 'app_name'))),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // کارت سفر شهری (تاکسی)
            _mainButton(context, tr(context, 'request_ride'), Icons.local_taxi, Colors.orange, '/fare_test'),
            
            const SizedBox(height: 15),

            // کارت سفر بین‌شهری
            _mainButton(context, tr(context, 'intercity_title'), Icons.add_road, Colors.blue, '/intercity'),
            
            const SizedBox(height: 15),

            // کارت باربری
            _mainButton(context, tr(context, 'cargo_title'), Icons.local_shipping, Colors.purple, '/cargo'),
            
            const Spacer(),

            // دکمه ثبت‌نام راننده در پایین
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(minimumSize: const Size(double.infinity, 55)),
              onPressed: () => Navigator.pushNamed(context, '/driver_reg'),
              icon: const Icon(Icons.person_add),
              label: Text(tr(context, 'reg_title')),
            ),
          ],
        ),
      ),
    );
  }

  // ویجت دکمه‌های اصلی (برای جلوگیری از تکرار کد)
  Widget _mainButton(BuildContext context, String title, IconData icon, Color color, String route) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, route),
      child: Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: color.withOpacity(0.5)),
        ),
        child: Row(
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(width: 20),
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }
}
