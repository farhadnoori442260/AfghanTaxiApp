import 'package:flutter/material.dart';
import 'screens/home_dashboard.dart'; // فایل جدید داشبورد
import 'screens/fare_test_page.dart';
import 'screens/driver_home.dart';
import 'screens/map_screen.dart';
// بعداً می‌توان login, register و دیگر صفحات را هم اضافه کرد

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Afghan Taxi App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Vazir', // فونت فارسی
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeDashboard(), // صفحه شروع جدید
    );
  }
}