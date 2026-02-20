import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// ایمپورت صفحات
import 'screens/home_screen.dart';
import 'screens/home_dashboard.dart';
import 'screens/fare_test_page.dart';
import 'screens/driver_reg_screen.dart'; // جدید
import 'screens/cargo_screen.dart';      // جدید
import 'screens/intercity_screen.dart';  // جدید
import 'utils/colors.dart';

class SafirApp extends StatelessWidget {
  const SafirApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'سفیر | Safir',
      debugShowCheckedModeBanner: false,
      
      // ۱. تنظیمات سه‌زبانه (دری، پشتو، انگلیسی)
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fa', 'AF'), // دری
        Locale('ps', 'AF'), // پشتو
        Locale('en', 'US'), // انگلیسی
      ],
      // نکته: این Locale بعداً باید توسط دکمه تغییر زبان عوض شود
      locale: const Locale('fa', 'AF'), 

      // ۲. تم رنگی و فونت پروژه سفیر
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: SafirColors.primaryGreen,
        fontFamily: 'IranYekan', 
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: SafirColors.primaryGreen),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: SafirColors.primaryGreen,
          elevation: 0,
          centerTitle: true,
        ),
      ),

      // ۳. لیست تمام صفحات (مدیریت مسیرها)
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/dashboard': (context) => const HomeDashboard(),
        '/fare_test': (context) => const FareTestPage(),
        '/driver_reg': (context) => const DriverRegScreen(), // مسیر جدید
        '/cargo': (context) => const CargoScreen(),           // مسیر جدید
        '/intercity': (context) => const IntercityScreen(),   // مسیر جدید
      },
    );
  }
}
