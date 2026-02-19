import 'package:flutter/material.dart';
import '../utils/colors.dart';
import 'profile_screen.dart';
import 'ride_history_screen.dart';

class HomeDashboard extends StatefulWidget {
  const HomeDashboard({super.key});

  @override
  State<HomeDashboard> createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: _buildDrawer(context),
      body: Stack(
        children: [
          // ۱. بخش نقشه (پس‌زمینه اصلی)
          Container(
            color: const Color(0xFFE5E7EB), // اینجا محل قرارگیری Google Maps است
            child: const Center(
              child: Icon(Icons.map_rounded, size: 100, color: Colors.black12),
            ),
          ),

          // ۲. دکمه همبرگری منو (شناور روی نقشه)
          Positioned(
            top: 50,
            right: 20,
            child: GestureDetector(
              onTap: () => _scaffoldKey.currentState?.openDrawer(),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
                ),
                child: const Icon(Icons.menu_rounded, color: SafirColors.primaryGreen),
              ),
            ),
          ),

          // ۳. بخش پایینی (جستجوی مقصد و پیشنهادات)
          Align(
            alignment: Alignment.bottomCenter,
            child: _buildRequestPanel(),
          ),
        ],
      ),
    );
  }

  Widget _buildRequestPanel() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 20)],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // خط کوچک بالای پنل برای حس کشویی
          Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(10))),
          const SizedBox(height: 20),
          
          const Text(
            "سفیر عزیز، کجا می‌روید؟",
            style: TextStyle(fontFamily: 'IranYekan', fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          // فیلد مقصد
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(15),
            ),
            child: const TextField(
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                hintText: "جستجوی مقصد در کابل...",
                hintStyle: TextStyle(fontFamily: 'IranYekan', fontSize: 14, color: Colors.grey),
                border: InputBorder.none,
                icon: Icon(Icons.search, color: SafirColors.primaryGreen),
              ),
            ),
          ),

          const SizedBox(height: 25),

          // مقصدهای پیشنهادی
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _quickDestination(Icons.home_rounded, "خانه"),
              _quickDestination(Icons.work_rounded, "کار"),
              _quickDestination(Icons.star_rounded, "علاقه‌مندی"),
              _quickDestination(Icons.history_rounded, "اخیر"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _quickDestination(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: SafirColors.primaryGreen.withOpacity(0.08), shape: BoxShape.circle),
          child: Icon(icon, color: SafirColors.primaryGreen, size: 24),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontFamily: 'IranYekan', fontSize: 12, color: Colors.black54)),
      ],
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: SafirColors.primaryGreen),
            currentAccountPicture: const CircleAvatar(backgroundColor: Colors.white, child: Icon(Icons.person, color: SafirColors.primaryGreen, size: 40)),
            accountName: const Text("احمد نوری", style: TextStyle(fontFamily: 'IranYekan', fontWeight: FontWeight.bold)),
            accountEmail: const Text("امتیاز شما: ۴.۹ ⭐", style: TextStyle(fontFamily: 'IranYekan', fontSize: 12)),
          ),
          _drawerTile(Icons.person_outline, "پروفایل من", () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen()))),
          _drawerTile(Icons.history, "تاریخچه سفرهای سفیر", () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RideHistoryScreen()))),
          _drawerTile(Icons.account_balance_wallet_outlined, "کیف پول", () {}),
          _drawerTile(Icons.support_agent_rounded, "پشتیبانی سفیر", () {}),
          const Spacer(),
          _drawerTile(Icons.logout_rounded, "خروج از حساب", () {}, isDestructive: true),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _drawerTile(IconData icon, String title, VoidCallback onTap, {bool isDestructive = false}) {
    return ListTile(
      leading: Icon(icon, color: isDestructive ? Colors.redAccent : SafirColors.primaryGreen),
      title: Text(title, style: TextStyle(fontFamily: 'IranYekan', color: isDestructive ? Colors.redAccent : Colors.black87, fontSize: 15)),
      onTap: onTap,
    );
  }
}
