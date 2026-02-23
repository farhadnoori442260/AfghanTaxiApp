import 'package:flutter/material.dart';
// وارد کردن صفحات اصلی از پوشه lib طبق گیت‌هاب شما
import 'splash_screen.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import 'profile_edit_screen.dart';

void main() {
  runApp(const SafirApp());
}

class SafirApp extends StatelessWidget {
  const SafirApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Safir Taxi',
      
      // تنظیم فونت و رنگ‌بندی برند سفیر
      theme: ThemeData(
        primaryColor: const Color(0xFF145A41),
        fontFamily: 'IranYekan', // فونتی که در pubspec تعریف کردی
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
      ),

      // مدیریت تمام مسیرهای اپلیکیشن
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomeScreen(),
        '/profile': (context) => const ProfileScreen(), // متصل به فایل profile_screen.dart
        '/edit_profile': (context) => const ProfileEditScreen(), // متصل به فایل ویرایش
      },
    );
  }
}
