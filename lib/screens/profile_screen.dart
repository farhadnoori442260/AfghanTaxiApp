import 'dart:ui';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("حساب کاربری سفیر", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // ۱. پس‌زمینه رنگی و مدرن
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1a2a6c), Color(0xFFb21f1f), Color(0xFFfdbb2d)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          
          // ۲. محتوای صفحه با اسکرول
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 120),
                _buildProfileHeader(),
                const SizedBox(height: 30),
                _buildStatsSection(),
                const SizedBox(height: 30),
                _buildMedalsSection(), // بخش مدال‌های طلایی تو
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

  // بخش سربرگ (عکس و نام)
  Widget _buildProfileHeader() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(color: Colors.white24, shape: BoxShape.circle),
              child: const CircleAvatar(
                radius: 60,
                backgroundColor: Colors.white10,
                child: Icon(Icons.person, size: 80, color: Colors.white70),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
              child: const Icon(Icons.check, color: Colors.white, size: 20),
            ),
          ],
        ),
        const SizedBox(height: 15),
        const Text("احمد نوری", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
        const Text("سفیر فعال از ۲۰۲۳", style: TextStyle(color: Colors.white70, fontSize: 14)),
      ],
    );
  }

  // بخش آمار (سفرها و امتیاز)
  Widget _buildStatsSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _statItem("۴.۹", "امتیاز راننده", Icons.star_rounded),
        _statItem("۱,۲۵۰", "کل سفرها", Icons.local_taxi_rounded),
        _statItem("۳ سال", "سابقه همکاری", Icons.calendar_today_rounded),
      ],
    );
  }

  Widget _statItem(String value, String label, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.orangeAccent, size: 28),
        const SizedBox(height: 5),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: Colors.white60, fontSize: 12)),
      ],
    );
  }

  // بخش مدال‌های افتخار (ایده اصلی تو)
  Widget _buildMedalsSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("نشان‌های افتخار سفیر", style: TextStyle(color: Colors.orangeAccent, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _medalIcon(Icons.looks_3, "۳ ساله", Colors.amber),
              _medalIcon(Icons.verified_user, "بهترین راننده", Colors.cyanAccent),
              _medalIcon(Icons.emoji_events, "خوش‌اخلاق", Colors.greenAccent),
              _medalIcon(Icons.workspace_premium, "مسافر برتر", Colors.purpleAccent),
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
            color: color.withOpacity(0.15),
            border: Border.all(color: color.withOpacity(0.5), width: 2),
          ),
          child: Icon(icon, color: color, size: 30),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 10)),
      ],
    );
  }

  // لیست تنظیمات با استایل شیشه‌ای
  Widget _buildSettingsList() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          _settingsTile(Icons.wallet, "کیف پول و درآمدها", ""),
          _settingsTile(Icons.history, "تاریخچه سفرهای سفیر", ""),
          _settingsTile(Icons.notifications_active, "تنظیمات اعلان‌ها", ""),
          _settingsTile(Icons.security, "امنیت و حریم خصوصی", ""),
          _settingsTile(Icons.help_center, "مرکز پشتیبانی", ""),
        ],
      ),
    );
  }

  Widget _settingsTile(IconData icon, String title, String trailing) {
    return ListTile(
      leading: Icon(icon, color: Colors.white70),
      title: Text(title, style: const TextStyle(color: Colors.white, fontSize: 15)),
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white24, size: 16),
      onTap: () {},
    );
  }
}
