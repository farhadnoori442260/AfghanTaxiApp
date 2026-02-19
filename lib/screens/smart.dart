import 'package:flutter/material.dart';
import '../utils/colors.dart';

class SmartScreen extends StatelessWidget {
  const SmartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBF9),
      appBar: AppBar(
        title: const Text(
          'ویژگی‌های هوشمند سفیر',
          style: TextStyle(fontFamily: 'IranYekan', fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: SafirColors.primaryGreen,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        children: [
          _buildHeaderDesc(),
          const SizedBox(height: 10),
          _buildFeatureCard(
            icon: Icons.shield_outlined,
            title: 'امنیت پیشرفته (Safir Guard)',
            description: 'احراز هویت بیومتریک رانندگان و سیستم نظارت لحظه‌ای بر سفر برای آرامش شما.',
            accentColor: Colors.blueAccent,
          ),
          _buildFeatureCard(
            icon: Icons.auto_graph_outlined,
            title: 'مسیریابی هوش مصنوعی',
            description: 'الگوریتم‌های پیشرفته برای پیش‌بینی ترافیک کابل و انتخاب سریع‌ترین مسیر ممکن.',
            accentColor: Colors.purpleAccent,
          ),
          _buildFeatureCard(
            icon: Icons.account_balance_wallet_outlined,
            title: 'کیف پول یکپارچه',
            description: 'پرداخت بدون نیاز به پول نقد و مدیریت دقیق هزینه‌های سفر در حساب سفیر.',
            accentColor: Colors.orangeAccent,
          ),
          _buildFeatureCard(
            icon: Icons.insights_outlined,
            title: 'سیستم بازخورد ۳۶۰ درجه',
            description: 'تحلیل نظرات شما برای بهبود مستمر کیفیت خدمات و رتبه‌بندی سفیران.',
            accentColor: Colors.teal,
          ),
          _buildFeatureCard(
            icon: Icons.bolt_outlined,
            title: 'تخصیص هوشمند (Smart Match)',
            description: 'اتصال شما به نزدیک‌ترین راننده در کمتر از ۳۰ ثانیه با بهینه‌ترین حالت.',
            accentColor: Colors.amber,
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderDesc() {
    return const Padding(
      padding: EdgeInsets.all(10.0),
      child: Text(
        "تکنولوژی سفیر در خدمت راحتی و امنیت شماست. ما از جدیدترین ابزارهای هوش مصنوعی برای بهبود سفرهای شهری استفاده می‌کنیم.",
        textAlign: TextAlign.center,
        style: TextStyle(fontFamily: 'IranYekan', color: Colors.grey, fontSize: 13),
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
    required Color accentColor,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: SafirColors.primaryGreen.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(color: SafirColors.primaryGreen.withOpacity(0.03)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // آیکون با پس‌زمینه رنگی ملایم
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: accentColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(icon, size: 30, color: accentColor),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontFamily: 'IranYekan',
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: const TextStyle(
                      fontFamily: 'IranYekan',
                      fontSize: 13,
                      color: Colors.black54,
                      height: 1.5,
                    ),
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
