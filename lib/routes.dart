import 'package:flutter/material.dart';

// ۱. تعریف تمام مسیرها
final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const HomeScreen(),
  '/safir_request': (context) => const SafirRequestScreen(),
  '/barbari': (context) => const BarbariScreen(),
  '/registration': (context) => const RegistrationScreen(),
  '/intercity': (context) => const IntercityScreen(),
  '/profile_edit': (context) => const ProfileEditScreen(), // مسیر جدید پروفایل
};

// ۲. صفحه اصلی
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Safir', style: TextStyle(color: Color(0xFF145A41), fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline, color: Color(0xFF145A41)),
            onPressed: () => Navigator.pushNamed(context, '/profile_edit'), // دکمه ورود به پروفایل
          )
        ],
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(20),
        crossAxisCount: 4,
        children: [
          _menuItem(context, 'سفیر', Icons.directions_car, '/safir_request'),
          _menuItem(context, 'باربری', Icons.local_shipping, '/barbari'),
          _menuItem(context, 'بین شهری', Icons.location_city, '/intercity'),
          _menuItem(context, 'ثبت نام', Icons.person_add, '/registration'),
        ],
      ),
    );
  }

  Widget _menuItem(BuildContext context, String title, IconData icon, String route) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
      child: Column(
        children: [
          CircleAvatar(backgroundColor: const Color(0xFF145A41).withOpacity(0.1), child: Icon(icon, color: const Color(0xFF145A41))),
          const SizedBox(height: 5),
          Text(title, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

// ۳. بخش صفحات (فقط به انتهای این بخش کد اضافه کن)

class ProfileEditScreen extends StatelessWidget {
  const ProfileEditScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('اطلاعات کاربری'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('اطلاعات اصلی', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 15),
            _inputField('نام و نام خانوادگی', 'farhadnoori'),
            _inputField('شماره موبایل', '+989907027123'),
            _inputField('ایمیل', 'farhadnoori442@gmail.com'),
            const Divider(height: 40),
            const Text('اطلاعات فرعی', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 15),
            _inputField('آدرس', 'آدرستان را بنویسید...'),
            _inputField('جنسیت', 'انتخاب کنید'),
            _inputField('تاریخ تولد', '۱۴۰۲/۰۱/۰۱'),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[300]),
                onPressed: () {},
                child: const Text('ذخیره', style: TextStyle(color: Colors.black54)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _inputField(String label, String hint) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}

// سایر صفحات ساده برای جلوگیری از خطا
class SafirRequestScreen extends StatelessWidget { const SafirRequestScreen({super.key}); @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('درخواست سفیر'))); }
class BarbariScreen extends StatelessWidget { const BarbariScreen({super.key}); @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('باربری'))); }
class RegistrationScreen extends StatelessWidget { const RegistrationScreen({super.key}); @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('ثبت نام'))); }
class IntercityScreen extends StatelessWidget { const IntercityScreen({super.key}); @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('بین شهری'))); }
