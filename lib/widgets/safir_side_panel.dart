import 'dart:ui';
import 'package:flutter/material.dart';
import '../utils/helper.dart';
import '../utils/colors.dart';

class SafirSidePanel extends StatelessWidget {
  final int yearsOfService;
  final String driverName;
  final String walletBalance;

  const SafirSidePanel({
    super.key,
    this.yearsOfService = 3,
    this.driverName = "احمد نوری", // این مقادیر باید از پرووایدر یا دیتابیس بیایند
    this.walletBalance = "1,200",
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          // ۱. پس‌زمینه شیشه‌ای با افکت بلور پیشرفته
          ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.45),
                  border: const Border(left: BorderSide(color: Colors.white10)),
                ),
              ),
            ),
          ),
          
          // ۲. محتویات منو با مدیریت زبان
          SafeArea(
            child: Column(
              children: [
                _buildProfileHeader(context),
                const Divider(color: Colors.white10, height: 1),
                
                // بخش مدال‌ها (افتخارات سفیر)
                _buildMedalsSection(context, yearsOfService),
                
                const Divider(color: Colors.white10, height: 1),

                // آیتم‌های منو با استفاده از کلیدهای ترجمه
                _buildMenuItem(context, Icons.account_balance_wallet_rounded, "wallet", "$walletBalance ${tr(context, 'afn')}"),
                _buildMenuItem(context, Icons.military_tech_rounded, "medals_and_honors", ""),
                _buildMenuItem(context, Icons.history_rounded, "active_rides", ""),
                _buildMenuItem(context, Icons.support_agent_rounded, "support", ""),
                _buildMenuItem(context, Icons.settings_rounded, "settings", ""),
                
                const Spacer(),
                
                // دکمه خروج
                _buildLogoutButton(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 35,
            backgroundColor: Colors.orangeAccent,
            child: CircleAvatar(
              radius: 32,
              backgroundColor: Colors.white10,
              backgroundImage: AssetImage('assets/images/driver_placeholder.png'),
            ),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(driverName, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'IranYekan')),
              Text(tr(context, 'top_driver_year'), style: const TextStyle(color: Colors.orangeAccent, fontSize: 11, fontFamily: 'IranYekan')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMedalsSection(BuildContext context, int years) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Text(tr(context, 'honors_and_medals'), style: const TextStyle(color: Colors.white54, fontSize: 11, fontFamily: 'IranYekan')),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _medalIcon(Icons.workspace_premium, "$years ${tr(context, 'years')}", Colors.amber),
              _medalIcon(Icons.favorite_rounded, tr(context, 'popular'), Colors.pinkAccent),
              _medalIcon(Icons.verified_user_rounded, tr(context, 'accepted'), Colors.blueAccent),
            ],
          ),
        ],
      ),
    );
  }

  Widget _medalIcon(IconData icon, String label, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 30),
        const SizedBox(height: 5),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 10, fontFamily: 'IranYekan')),
      ],
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String titleKey, String trailing) {
    return ListTile(
      leading: Icon(icon, color: Colors.white70),
      title: Text(tr(context, titleKey), style: const TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'IranYekan')),
      trailing: Text(trailing, style: const TextStyle(color: Colors.orangeAccent, fontSize: 12, fontWeight: FontWeight.bold)),
      onTap: () {},
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: InkWell(
        onTap: () => Navigator.pop(context),
        child: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.redAccent.withOpacity(0.5)),
          ),
          child: Center(
            child: Text(tr(context, 'exit'), style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontFamily: 'IranYekan')),
          ),
        ),
      ),
    );
  }
}
