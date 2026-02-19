import 'dart:ui';
import 'package:flutter/material.dart';
import '../utils/colors.dart'; // وارد کردن پالت رنگی سفیر

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          "حساب کاربری سفیر",
          style: TextStyle(fontFamily: 'IranYekan', color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // ۱. پس‌زمینه اختصاصی برند سفیر
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [SafirColors.primaryGreen, Color(0xFF082218)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          
          // ۲. محتوا
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 120),
                _buildProfileHeader(),
                const SizedBox(height: 30),
                _buildStatsSection(),
                const SizedBox(height: 30),
                _buildMedalsSection(), // بخش مدال‌های طلایی
                const SizedBox(height: 30),
                _buildSettingsList(),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // بخش سربرگ (عکس و نام) با استایل جدید
  Widget _buildProfileHeader() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white24),
              ),
              child: const CircleAvatar(
                radius: 60,
                backgroundColor: Colors.white12,
                child: Icon(Icons.person, size: 80, color: Colors.white),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(color: Colors.amber, shape: BoxShape.circle),
              child: const Icon(Icons.verified, color: SafirColors.primaryGreen, size: 22),
            ),
          ],
        ),
        const SizedBox(height: 15),
        const Text(
          "احمد نوری",
          style: TextStyle(fontFamily: 'IranYekan', color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
        ),
        const Text(
          "سفیر فعال از ۲۰۲۳",
          style: TextStyle(fontFamily: 'IranYekan', color: Colors.white70, fontSize: 14),
        ),
      ],
    );
  }

  // بخش آمار با اعداد فارسی و طلایی
  Widget _buildStatsSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _statItem("۴.۹", "امتیاز", Icons.star_rounded),
        _statItem("۱,۲۵۰", "کل سفرها", Icons.local_taxi_rounded),
        _statItem("۳ سال", "سابقه", Icons.calendar_today_rounded),
      ],
    );
  }

  Widget _statItem(String value, String label, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.amber, size: 28),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(fontFamily: 'IranYekan', color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: const TextStyle(fontFamily: 'IranYekan', color: Colors.white60, fontSize: 12),
        ),
      ],
    );
  }

  // بخش مدال‌های افتخار (با افکت شیشه‌ای)
  Widget _buildMedalsSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.military_tech, color: Colors.amber, size: 20),
              SizedBox(width: 8),
              Text(
                "نشان‌های افتخار سفیر",
                style: TextStyle(fontFamily: 'IranYekan', color: Colors.amber, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _medalIcon(Icons.looks_3, "۳ ساله", Colors.amber),
              _medalIcon(Icons.verified_user, "امنیت", Colors.cyanAccent),
              _medalIcon(Icons.sentiment_very_satisfied, "اخلاق", Colors.greenAccent),
              _medalIcon(Icons.workspace_premium, "VIP", Colors.purpleAccent),
            ],
          ),
        ],
      ),
    );
  }

  Widget _medalIcon(IconData icon, String label, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withOpacity(0.1),
            border: Border.all(color: color.withOpacity(0.3), width: 1.5),
          ),
          child: Icon(icon, color: color, size: 28),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontFamily: 'IranYekan', color: Colors.white70, fontSize: 10),
        ),
      ],
    );
  }

  // لیست تنظیمات
  Widget _buildSettingsList() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        children: [
          _settingsTile(Icons.account_balance_wallet_outlined, "کیف پول و درآمدها"),
          _settingsTile(Icons.history_rounded, "تاریخچه سفرهای سفیر"),
          _settingsTile(Icons.notifications_none_rounded, "تنظیمات اعلان‌ها"),
          _settingsTile(Icons.shield_outlined, "امنیت و حریم خصوصی"),
          _settingsTile(Icons.contact_support_outlined, "مرکز پشتیبانی"),
        ],
      ),
    );
  }

  Widget _settingsTile(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.white70),
      title: Text(
        title,
        style: const TextStyle(fontFamily: 'IranYekan', color: Colors.white, fontSize: 15),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white24, size: 14),
      onTap: () {},
    );
  }
}
