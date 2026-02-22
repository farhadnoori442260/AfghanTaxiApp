import 'package:flutter/material.dart';

// مسیرهای ناوبری
final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const HomeScreen(),
  '/profile': (context) => const ProfileScreen(),
};

// --- صفحه اصلی ---
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Safir', style: TextStyle(color: Color(0xFF145A41), fontWeight: FontWeight.bold)),
            Builder(builder: (context) => IconButton(
              icon: const Icon(Icons.menu, color: Color(0xFF145A41)),
              onPressed: () => Scaffold.of(context).openDrawer(),
            )),
          ],
        ),
      ),
      drawer: _buildDrawer(context),
      body: Column(
        children: [
          Container(height: 1, color: Colors.grey[300]), // خط جداکننده زیر هدر
          const SizedBox(height: 20),
          _buildActionGrid(context),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // بخش پروفایل بالای منو
          Container(
            padding: const EdgeInsets.only(top: 50, right: 15, left: 10, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit_outlined, color: Colors.grey),
                  onPressed: () => Navigator.pushNamed(context, '/profile'),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Text('farhadnoori', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    Text('۰۹۹۰۷۰۲۷۱۲۳', style: TextStyle(color: Colors.grey, fontSize: 13)),
                  ],
                ),
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Color(0xFFF5F5F5),
                  child: Icon(Icons.person, color: Colors.grey, size: 40),
                ),
              ],
            ),
          ),
          const Divider(),
          _drawerItem(Icons.account_balance_wallet_outlined, 'کیف پول'),
          _drawerItem(Icons.language_outlined, 'تنظیمات لسان'),
          _drawerItem(Icons.headset_mic_outlined, 'ارتباط با پشتیبانی'),
        ],
      ),
    );
  }

  Widget _drawerItem(IconData icon, String title) {
    return ListTile(
      trailing: Icon(icon, color: Colors.black87),
      title: Text(title, textAlign: TextAlign.right),
      onTap: () {},
    );
  }

  Widget _buildActionGrid(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 4,
        children: [
          _gridItem('سفیر', Icons.directions_car),
          _gridItem('باربری', Icons.local_shipping),
          _gridItem('ثبت نام', Icons.person_add), // دکمه ثبت نام راننده
          _gridItem('ولایتی', Icons.location_city),
        ],
      ),
    );
  }

  Widget _gridItem(String title, IconData icon) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: const Color(0xFFE8F5E9), borderRadius: BorderRadius.circular(12)),
          child: Icon(icon, color: const Color(0xFF145A41)),
        ),
        const SizedBox(height: 5),
        Text(title, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
      ],
    );
  }
}

// --- صفحه حساب کاربری ---
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('حساب کاربری', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const CircleAvatar(radius: 50, child: Icon(Icons.person, size: 70)),
            const SizedBox(height: 10),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
              Icon(Icons.star, color: Colors.amber),
              Text(' ۴.۵')
            ]),
            const SizedBox(height: 30),
            _infoRow('اطلاعات کاربری', 'ویرایش'),
            _infoRow('farhadnoori', '۰۹۹۰۷۰۲۷۱۲۳'),
            const Divider(height: 50),
            const Text('مدال‌های افتخار', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _medal('وقت‌شناس', Colors.purple),
                _medal('خوش‌رفتار', Colors.green),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String t1, String t2) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(t2, style: const TextStyle(color: Colors.blue)),
        Text(t1),
      ]),
    );
  }

  Widget _medal(String label, Color col) {
    return Container(
      width: 120,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: col.withOpacity(0.1), borderRadius: BorderRadius.circular(15)),
      child: Column(children: [
        Icon(Icons.military_tech, color: col, size: 40),
        const SizedBox(height: 10),
        Text(label, style: TextStyle(color: col, fontWeight: FontWeight.bold)),
      ]),
    );
  }
}
