import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(const SafirApp());

class SafirApp extends StatelessWidget {
  const SafirApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Safir Taxi',
      // نقطه شروع را روی اسپلش می‌گذاریم
      initialRoute: '/', 
      theme: ThemeData(
        primaryColor: const Color(0xFF145A41),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomeScreen(),
        '/account': (context) => const AccountScreen(),
        '/edit_profile': (context) => const ProfileEditScreen(),
      },
    );
  }
}

// --- ۱. اسپلش اسکرین مدرن و انیمیشنی ---
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.backOut),
    );

    _controller.forward();

    // انتقال خودکار به صفحه اصلی بعد از ۳ ثانیه
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FadeTransition(
          opacity: _opacityAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // لوگوی متنی با استایل مدرن
                const Text(
                  'Safir',
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF145A41),
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 10),
                // خط انیمیشنی زیر S
                Container(
                  width: 80,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFF145A41),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 40),
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF145A41)),
                  strokeWidth: 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// --- ۲. صفحه اصلی (Home) با چیدمان درخواستی شما ---
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // دراور گوشه بالا سمت چپ
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
                const Text('Safir', style: TextStyle(color: Color(0xFF145A41), fontWeight: FontWeight.bold)),
                // آیکون خانه زیر اسم با خط
                Container(
                  margin: const EdgeInsets.only(top: 2),
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: Color(0xFF145A41), width: 2)),
                  ),
                  child: const Icon(Icons.home, size: 18, color: Color(0xFF145A41)),
                ),
              ],
            ),
          ],
        ),
      ),
      drawer: _buildDrawer(context),
      body: Stack(
        children: [
          const Center(child: Icon(Icons.map, size: 100, color: Colors.black12)),
          _buildBottomOptions(),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF145A41)),
            child: Center(child: Text('منوی سفیر', style: TextStyle(color: Colors.white, fontSize: 24))),
          ),
          ListTile(
            leading: const Icon(Icons.person_outline),
            title: const Text('پروفایل / حساب کاربری'),
            onTap: () => Navigator.pushNamed(context, '/account'),
          ),
          ExpansionTile(
            leading: const Icon(Icons.language),
            title: const Text('تنظیمات زبان'),
            children: [
              ListTile(title: const Text('دری'), onTap: () {}),
              ListTile(title: const Text('پشتو'), onTap: () {}),
              ListTile(title: const Text('English'), onTap: () {}),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomOptions() {
    return Positioned(
      bottom: 20, left: 20, right: 20,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _option(Icons.location_city, 'بین شهری'),
            _option(Icons.grid_view, 'ثبت نام'),
            _option(Icons.local_shipping, 'باربری'),
            _option(Icons.directions_car, 'درخواست سفیر'),
          ],
        ),
      ),
    );
  }

  Widget _option(IconData icon, String label) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      CircleAvatar(backgroundColor: Colors.green.withOpacity(0.1), child: Icon(icon, color: const Color(0xFF145A41))),
      const SizedBox(height: 5),
      Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
    ],
  );
}

// --- ۳. صفحه حساب کاربری ---
class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('حساب کاربری')),
      body: ListView(
        children: [
          const SizedBox(height: 20),
          const Center(child: CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50))),
          const Center(child: Text('farhadnoori', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/edit_profile'),
            child: const Text('ویرایش مشخصات', style: TextStyle(color: Colors.blue)),
          ),
          const Divider(),
          _item(Icons.card_giftcard, 'تخفیف‌ها'),
          _item(Icons.message, 'پیام‌ها'),
          _item(Icons.wallet, 'کیف پول'),
        ],
      ),
    );
  }

  Widget _item(IconData icon, String title) => ListTile(leading: Icon(icon), title: Text(title), trailing: const Icon(Icons.chevron_right));
}

// --- ۴. صفحه ویرایش پروفایل ---
class ProfileEditScreen extends StatelessWidget {
  const ProfileEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ویرایش اطلاعات')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _field('نام و نام خانوادگی', 'farhadnoori'),
            _field('شماره موبایل', '+989907027123'),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF145A41), minimumSize: const Size(double.infinity, 50)),
              onPressed: () => Navigator.pop(context),
              child: const Text('ذخیره تغییرات', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _field(String label, String val) => Padding(
    padding: const EdgeInsets.only(bottom: 15),
    child: TextFormField(initialValue: val, decoration: InputDecoration(labelText: label, border: const OutlineInputBorder())),
  );
}
