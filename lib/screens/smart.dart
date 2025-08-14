import 'package:flutter/material.dart';

class SmartScreen extends StatelessWidget {
  const SmartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ویژگی‌های هوشمند'),
        backgroundColor: Colors.green,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildFeatureCard(
            icon: Icons.security,
            title: 'امنیت پیشرفته',
            description: 'استفاده از سیستم تأیید دو مرحله‌ای و احراز هویت راننده‌ها برای امنیت بیشتر.',
          ),
          _buildFeatureCard(
            icon: Icons.map,
            title: 'مسیر هوشمند',
            description: 'انتخاب بهترین مسیر با توجه به ترافیک و شرایط جاده‌ها.',
          ),
          _buildFeatureCard(
            icon: Icons.attach_money,
            title: 'پرداخت آنلاین',
            description: 'امکان پرداخت سریع و امن از طریق کیف پول یا کارت بانکی.',
          ),
          _buildFeatureCard(
            icon: Icons.star,
            title: 'امتیازدهی و بازخورد',
            description: 'امکان ثبت نظر و امتیاز برای راننده و مسافر.',
          ),
          _buildFeatureCard(
            icon: Icons.notifications,
            title: 'اعلان‌های هوشمند',
            description: 'اطلاع‌رسانی فوری درباره تغییر وضعیت سفر و پیشنهادات ویژه.',
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 40, color: Colors.green),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}