import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // دکمه منو در سمت چپ طبق تصویر
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Color(0xFF145A41)),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  'Safir',
                  style: TextStyle(
                    color: Color(0xFF145A41),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                // آیکون خانه با خط زیرین در گوشه سمت راست (طبق عکس 1000049456.jpg)
                Container(
                  margin: const EdgeInsets.only(top: 2),
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: Color(0xFF145A41), width: 2)),
                  ),
                  child: const Icon(Icons.home, size: 20, color: Color(0xFF145A41)),
                ),
              ],
            ),
          ],
        ),
      ),
      drawer: _buildDrawer(context),
      body: Stack(
        children: [
          // فضای نقشه در پس‌زمینه
          const Center(
            child: Icon(Icons.location_on, size: 50, color: Colors.redAccent),
          ),
          // بخش گزینه‌های پایین صفحه (طبق عکس 1000049456.jpg)
          _buildBottomOptions(),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF145A41)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(backgroundColor: Colors.white, radius: 30, child: Icon(Icons.person, color: Color(0xFF145A41), size: 35)),
                SizedBox(height: 10),
                Text("farhadnoori", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person_outline, color: Color(0xFF145A41)),
            title: const Text('حساب کاربری'),
            onTap: () => Navigator.pushNamed(context, '/account'),
          ),
          // بخش تنظیمات زبان به صورت کشویی (ExpansionTile)
          const ExpansionTile(
            leading: Icon(Icons.language, color: Color(0xFF145A41)),
            title: Text('تنظیمات زبان'),
            children: [
              ListTile(title: Text('دری'), contentPadding: EdgeInsets.only(right: 50)),
              ListTile(title: Text('پشتو'), contentPadding: EdgeInsets.only(right: 50)),
              ListTile(title: Text('English'), contentPadding: EdgeInsets.only(right: 50)),
            ],
          ),
          ListTile(
            leading: const Icon(Icons.history, color: Color(0xFF145A41)),
            title: const Text('تاریخچه سفرها'),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildBottomOptions() {
    return Positioned(
      bottom: 20,
      left: 15,
      right: 15,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 15, offset: const Offset(0, 5))],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _optionItem(Icons.location_city, 'بین شهری'),
            _optionItem(Icons.grid_view, 'ثبت نام'),
            _optionItem(Icons.local_shipping, 'باربری'),
            _optionItem(Icons.directions_car, 'درخواست سفیر'),
          ],
        ),
      ),
    );
  }

  Widget _optionItem(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: Colors.green.withOpacity(0.1), shape: BoxShape.circle),
          child: Icon(icon, color: const Color(0xFF145A41), size: 28),
        ),
        const SizedBox(height: 5),
        Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
