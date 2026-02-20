import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// ایمپورت صفحات
import 'screens/home_screen.dart';
import 'screens/home_dashboard.dart';
import 'screens/fare_test_page.dart';
import 'screens/driver_reg_screen.dart';
import 'screens/cargo_screen.dart';      
import 'screens/intercity_screen.dart';  
import 'utils/colors.dart';

class SafirApp extends StatelessWidget {
  const SafirApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'سفیر | Safir',
      debugShowCheckedModeBanner: false,
      
      // ۱. تنظیمات سه‌زبانه (Localization)
      // نکته: برای تغییر داینامیک زبان، باید از یک Provider استفاده کرد.
      // فعلاً اجازه می‌دهیم سیستم به صورت خودکار با تنظیمات گوشی هماهنگ شود.
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

      // ۲. تم رنگی مدرن سفیر
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: SafirColors.primaryGreen,
        fontFamily: 'IranYekan', 
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: SafirColors.primaryGreen,
          primary: SafirColors.primaryGreen,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: SafirColors.primaryGreen,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontFamily: 'IranYekan',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: SafirColors.primaryGreen,
          ),
        ),
      ),

      // ۳. مدیریت مسیرها (Navigation)
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/dashboard': (context) => const HomeDashboard(),
        '/fare_test': (context) => const FareTestPage(),
        '/driver_reg': (context) => const DriverRegScreen(),
        '/cargo': (context) => const CargoScreen(),
        '/intercity': (context) => const IntercityScreen(),
      },
    );
  }
}
