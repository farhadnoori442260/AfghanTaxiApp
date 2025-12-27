import 'package:flutter/material.dart';
import 'fare_test_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('اپ تاکسی افغانستان'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildButton(
              context,
              title: 'مسافر',
              icon: Icons.person,
              onTap: () {
                // بعداً صفحه مسافر اضافه می‌شود
              },
            ),
            const SizedBox(height: 16),
            _buildButton(
              context,
              title: 'راننده',
              icon: Icons.local_taxi,
              onTap: () {
                // بعداً صفحه راننده اضافه می‌شود
              },
            ),
            const SizedBox(height: 16),
            _buildButton(
              context,
              title: 'تست کرایه',
              icon: Icons.calculate,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const FareTestPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(
    BuildContext context, {
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton.icon(
        icon: Icon(icon, size: 28),
        label: Text(
          title,
          style: const TextStyle(fontSize: 18),
        ),
        onPressed: onTap,
      ),
    );
  }
}