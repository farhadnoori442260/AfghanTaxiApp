import 'package:flutter/material.dart';
import 'utils/colors.dart'; // فایل رنگی که ساختی
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/map_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/ride_history_screen.dart';
import 'screens/ride_request_screen.dart';
import 'screens/driver_home.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'سفیر', // نام پروژه شما
      
      // تنظیمات تم با رنگ اختصاصی کانوا
      theme: ThemeData(
        primaryColor: SafirColors.primaryGreen,
        scaffoldBackgroundColor: SafirColors.bgLight,
        colorScheme: ColorScheme.fromSeed(seedColor: SafirColors.primaryGreen),
        
        // استایل دکمه‌های کل اپلیکیشن
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: SafirColors.primaryGreen,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            padding: const EdgeInsets.symmetric(vertical: 15),
          ),
        ),
      ),

      // شروع برنامه با صفحه اسپلش که لوگوی S را دارد
      initialRoute: '/',

      // تعریف تمام صفحات در سیستم مسیردهی
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/map': (context) => const MapScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/history': (context) => const RideHistoryScreen(),
        '/request': (context) => const RideRequestScreen(),
        '/driver': (context) => const DriverHomeScreen(),
      },
    );
  }
}
