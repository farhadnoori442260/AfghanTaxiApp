import 'dart:ui';
import 'package:flutter/material.dart';

class SafirSidePanel extends StatelessWidget {
  final int yearsOfService;

  SafirSidePanel({this.yearsOfService = 3}); // مدال بر اساس ۳ سال فعالیت

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.transparent, // شفاف برای ایجاد حالت شیشه‌ای
      child: Stack(
        children: [
          // ۱. ایجاد پس‌زمینه شیشه‌ای (Glassmorphism)
          ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  border: Border(left: BorderSide(color: Colors.white10)),
                ),
              ),
            ),
          ),
          
          // ۲. محتویات منو
          SafeArea(
            child: Column(
              children: [
                _buildProfileHeader(),
                Divider(color: Colors.white10, height: 1),
                
                // بخش مدال‌ها (ایده طلایی تو)
                _buildMedalsSection(yearsOfService),
                
                Divider(color: Colors.white10, height: 1),

                // آیتم‌های منو
                _buildMenuItem(Icons.account_balance_wallet_rounded, "کیف پول سفیر", "1,200 AFN"),
                _buildMenuItem(Icons.military_tech_rounded, "مدال‌ها و افتخارات", ""),
                _buildMenuItem(Icons.history_rounded, "سفرهای انجام شده", ""),
                _buildMenuItem(Icons.support_agent_rounded, "مرکز تماس سفیر", ""),
                
                Spacer(),
                
                // دکمه خروج با استایل مدرن
                _buildLogoutButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Padding(
      padding: EdgeInsets.all(25),
      child: Row(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: Colors.orangeAccent,
            child: CircleAvatar(
              radius: 32,
              backgroundColor: Colors.white10,
              child: Icon(Icons.person, color: Colors.white, size: 40),
            ),
          ),
          SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("احمد نوری", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              Text("سفیر برتر سال", style: TextStyle(color: Colors.orangeAccent, fontSize: 11)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMedalsSection(int years) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Text("نشان‌های افتخار", style: TextStyle(color: Colors.white54, fontSize: 11)),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _medalIcon(Icons.workspace_premium, "$years ساله", Colors.amber),
              _medalIcon(Icons.favorite_rounded, "محبوب", Colors.pinkAccent),
              _medalIcon(Icons.verified_user_rounded, "تایید شده", Colors.blueAccent),
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
        SizedBox(height: 5),
        Text(label, style: TextStyle(color: Colors.white70, fontSize: 10)),
      ],
    );
  }

  Widget _buildMenuItem(IconData icon, String title, String trailing) {
    return ListTile(
      leading: Icon(icon, color: Colors.white70),
      title: Text(title, style: TextStyle(color: Colors.white, fontSize: 14)),
      trailing: Text(trailing, style: TextStyle(color: Colors.orangeAccent, fontSize: 12)),
      onTap: () {},
    );
  }

  Widget _buildLogoutButton() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.redAccent.withOpacity(0.5)),
        ),
        child: Center(
          child: Text("خروج از حساب", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
