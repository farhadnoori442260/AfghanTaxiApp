import 'package:flutter/material.dart';

// تعریف مسیرهای اپلیکیشن سفیر
final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const PlaceholderScreen(title: 'صفحه اصلی سفیر'),
  '/login': (context) => const PlaceholderScreen(title: 'ورود به برنامه'),
  '/register': (context) => const PlaceholderScreen(title: 'ثبت‌نام'),
  '/driverHome': (context) => const PlaceholderScreen(title: 'پنل راننده'),
  '/profile': (context) => const PlaceholderScreen(title: 'پروفایل کاربری'),
  '/smart': (context) => const PlaceholderScreen(title: 'سرویس هوشمند'),
};

// یک ویجت ساده برای اینکه برنامه فعلاً خطا ندهد و اجرا شود
class PlaceholderScreen extends StatelessWidget {
  final String title;
  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), backgroundColor: Colors.blue),
      body: Center(
        child: Text(
          'این صفحه ($title) در حال ساخت است\nبزودی در نسخه جدید سفیر آماده می‌شود',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
