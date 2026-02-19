import 'package:flutter/material.dart';
import '../utils/colors.dart'; // فایل رنگ‌های سفیر

class DriverHomeScreen extends StatefulWidget {
  const DriverHomeScreen({super.key});

  @override
  State<DriverHomeScreen> createState() => _DriverHomeScreenState();
}

class _DriverHomeScreenState extends State<DriverHomeScreen> {
  bool _isOnline = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAF9), // پس‌زمینه بسیار روشن متمایل به سبز
      body: Stack(
        children: [
          // ۱. هدر سفیری (کارت درآمد و وضعیت آنلاین)
          _buildHeader(),

          // ۲. بخش لیست درخواست‌ها یا وضعیت آفلاین
          Positioned.fill(
            top: 260,
            child: _isOnline ? _buildRequestsList() : _buildOfflineState(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 300,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [SafirColors.primaryGreen, Color(0xFF0A2E21)],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 60),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "سفیر: فرهاد نوری",
                    style: TextStyle(fontFamily: 'IranYekan', color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "راننده سطح طلایی ⭐",
                    style: TextStyle(fontFamily: 'IranYekan', color: Colors.amberAccent, fontSize: 13),
                  ),
                ],
              ),
              // دکمه تغییر وضعیت آنلاین/آفلاین
              Transform.scale(
                scale: 1.2,
                child: Switch(
                  value: _isOnline,
                  activeColor: Colors.white,
                  activeTrackColor: Colors.greenAccent.withOpacity(0.5),
                  inactiveThumbColor: Colors.white60,
                  onChanged: (val) => setState(() => _isOnline = val),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          _buildIncomeCard(),
        ],
      ),
    );
  }

  Widget _buildIncomeCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.12),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.white24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _incomeStat("۱۲", "سفرها"),
          Container(width: 1, height: 30, color: Colors.white24),
          _incomeStat("۱,۴۵۰", "درآمد (AFN)"),
          Container(width: 1, height: 30, color: Colors.white24),
          _incomeStat("۴.۹", "امتیاز"),
        ],
      ),
    );
  }

  Widget _incomeStat(String value, String label) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontFamily: 'IranYekan', color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(fontFamily: 'IranYekan', color: Colors.white70, fontSize: 11)),
      ],
    );
  }

  Widget _buildOfflineState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.power_settings_new_rounded, size: 80, color: Colors.grey.withOpacity(0.3)),
        const SizedBox(height: 15),
        const Text(
          "در انتظار ورود شما...",
          style: TextStyle(fontFamily: 'IranYekan', fontSize: 20, color: Colors.black54, fontWeight: FontWeight.bold),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          child: Text(
            "برای شروع دریافت درخواست‌های سفر در سفیر، وضعیت خود را به آنلاین تغییر دهید",
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: 'IranYekan', color: Colors.grey, fontSize: 13),
          ),
        ),
      ],
    );
  }

  Widget _buildRequestsList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      itemCount: 2,
      itemBuilder: (context, index) => _buildRequestCard(),
    );
  }

  Widget _buildRequestCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [BoxShadow(color: SafirColors.primaryGreen.withOpacity(0.08), blurRadius: 15, offset: const Offset(0, 8))],
        border: Border.all(color: SafirColors.primaryGreen.withOpacity(0.05)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 25,
                backgroundColor: Color(0xFFE8F5E9),
                child: Icon(Icons.person, color: SafirColors.primaryGreen),
              ),
              const SizedBox(width: 15),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("مسافر: صبور احمدی", style: TextStyle(fontFamily: 'IranYekan', fontWeight: FontWeight.bold, fontSize: 16)),
                    Text("فاصله از شما: ۸۰۰ متر", style: TextStyle(fontFamily: 'IranYekan', color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ),
              Text(
                "۲۴۰ AFN",
                style: TextStyle(fontFamily: 'IranYekan', color: SafirColors.primaryGreen, fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Divider(color: Color(0xFFEEEEEE)),
          ),
          _locationRow(Icons.radio_button_checked, Colors.blue, "مبدأ: کابل، شهر نو"),
          const SizedBox(height: 12),
          _locationRow(Icons.location_on, Colors.redAccent, "مقصد: خیرخانه، چهارراهی شهید"),
          const SizedBox(height: 25),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: SafirColors.primaryGreen,
              minimumSize: const Size(double.infinity, 55),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              elevation: 0,
            ),
            child: const Text(
              "قبول درخواست سفیر",
              style: TextStyle(fontFamily: 'IranYekan', color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
            ),
          )
        ],
      ),
    );
  }

  Widget _locationRow(IconData icon, Color color, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 12),
        Text(text, style: const TextStyle(fontFamily: 'IranYekan', fontSize: 14, color: Colors.black87)),
      ],
    );
  }
}
