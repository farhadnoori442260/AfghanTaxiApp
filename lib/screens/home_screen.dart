import 'package:flutter/material.dart';
import '../utils/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("سفیر", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: SafirColors.primaryGreen),
              currentAccountPicture: const CircleAvatar(backgroundColor: Colors.white, child: Icon(Icons.person, color: SafirColors.primaryGreen)),
              accountName: const Text("کاربر سفیر"),
              accountEmail: const Text("07xxxxxxxxx"),
            ),
            ListTile(
              leading: const Icon(Icons.history, color: SafirColors.primaryGreen),
              title: const Text("تاریخچه سفرها"),
              onTap: () => Navigator.pushNamed(context, '/history'),
            ),
            ListTile(
              leading: const Icon(Icons.account_balance_wallet, color: SafirColors.primaryGreen),
              title: const Text("کیف پول"),
              onTap: () {}, // بعداً ست می‌کنیم
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.local_taxi, size: 80, color: SafirColors.primaryGreen),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/map'),
              child: const Text("درخواست سفر جدید"),
            ),
          ],
        ),
      ),
    );
  }
}
