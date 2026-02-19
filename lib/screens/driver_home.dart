import 'package:flutter/material.dart';

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
      backgroundColor: const Color(0xFFF1F5F9),
      body: Stack(
        children: [
          // ۱. بخش بالایی (کارت درآمد و وضعیت)
          _buildHeader(),

          // ۲. بخش لیست درخواست‌ها
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
          colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
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
                  Text("سفیر: فرهاد نوری", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                  Text("راننده سطح طلایی ⭐", style: TextStyle(color: Colors.orangeAccent, fontSize: 13)),
                ],
              ),
              Switch(
                value: _isOnline,
                activeColor: Colors.greenAccent,
                onChanged: (val) => setState(() => _isOnline = val),
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
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.white10),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _incomeStat("۱۲", "سفرها"),
          VerticalDivider(color: Colors.white24),
          _incomeStat("۱,۴۵۰", "درآمد امروز (AFN)"),
          VerticalDivider(color: Colors.white24),
          _incomeStat("۴.۹", "امتیاز"),
        ],
      ),
    );
  }

  static Widget _incomeStat(String value, String label) {
    return Column(
      children: [
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: Colors.white60, fontSize: 11)),
      ],
    );
  }

  Widget _buildOfflineState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.bedtime_rounded, size: 80, color: Colors.grey.shade400),
        const SizedBox(height: 10),
        const Text("در حالت آفلاین هستید", style: TextStyle(fontSize: 18, color: Colors.grey, fontWeight: FontWeight.bold)),
        const Text("برای دریافت درخواست، دکمه بالا را بزنید", style: TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget _buildRequestsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: 3,
      itemBuilder: (context, index) => _buildRequestCard(),
    );
  }

  Widget _buildRequestCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(backgroundColor: Colors.blueGrey, child: Icon(Icons.person, color: Colors.white)),
              const SizedBox(width: 15),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("مسافر: صبور احمدی", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("فاصله: ۸۰۰ متر", style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ),
              Text("۲۴۰ AFN", style: TextStyle(color: Colors.green.shade700, fontWeight: FontWeight.bold, fontSize: 18)),
            ],
          ),
          const Divider(height: 30),
          _locationInfo(Icons.circle, Colors.blue, "مبدأ: شهر نو"),
          const SizedBox(height: 10),
          _locationInfo(Icons.location_on, Colors.red, "مقصد: خیرخانه"),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orangeAccent,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            ),
            child: const Text("قبول درخواست سفیر", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }

  Widget _locationInfo(IconData icon, Color color, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 10),
        Text(text, style: const TextStyle(fontSize: 13, color: Colors.black87)),
      ],
    );
  }
}
