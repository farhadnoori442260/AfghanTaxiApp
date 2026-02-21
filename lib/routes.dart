import 'package:flutter/material.dart';
// وارد کردن صفحات پروژه سفیر
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/driver_home_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/smart_screen.dart';

// تعریف مسیرهای اپلیکیشن سفیر
final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const HomeScreen(),
  '/login': (context) => const LoginScreen(),
  '/register': (context) => const RegisterScreen(),
  '/driverHome': (context) => const DriverHomeScreen(),
  '/profile': (context) => const ProfileScreen(),
  '/smart': (context) => const SmartScreen(),
  
  // نکته: اگر در آینده صفحه تاریخچه یا تنظیمات ساختی، اینجا اضافه کن:
  // '/history': (context) => const HistoryScreen(),
};
