import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// ایمپورت کردن فایل‌های utils که ساختی
import 'utils/colors.dart';
import 'utils/helper.dart';

// ایمپورت صفحات (مطمئن شو نام فایل‌ها درست است)
import 'home_screen.dart';
import 'profile_screen.dart';
import 'profile_edit_screen.dart';
import 'map_screen.dart';

void main() => runApp(const SafirApp());

class SafirApp extends StatefulWidget {
  const SafirApp({super.key});

  // تابعی برای دسترسی به وضعیت برنامه از تمام صفحات (برای تغییر زبان و تم)
  static _SafirAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_SafirAppState>()!;

  @override
  State<SafirApp> createState() => _SafirAppState();
}

class _SafirAppState extends State<SafirApp> {
  ThemeMode _themeMode = ThemeMode.light;
  Locale _locale = const Locale('fa'); // زبان پیش‌فرض: دری

  // متد تغییر تم (تاریک/روشن)
  void changeTheme(bool isDark) {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  // متد تغییر زبان (دری، پشتو، انگلیسی)
  void changeLanguage(String langCode) {
    setState(() {
      _locale = Locale(langCode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Safir',
      
      // تنظیمات زبان و جهت متن (RTL/LTR)
      locale: _locale,
      supportedLocales: const [
        Locale('fa'), // دری
        Locale('ps'), // پشتو
        Locale('en'), // انگلیسی
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      // تنظیمات تم با استفاده از کتابخانه SafirColors
      themeMode: _themeMode,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: SafirColors.primaryGreen,
        scaffoldBackgroundColor: SafirColors.bgLight,
        fontFamily: 'IranYekan', // مطمئن شو فونت در pubspec تعریف شده
        colorScheme: ColorScheme.fromSeed(
          seedColor: SafirColors.primaryGreen,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        primaryColor: SafirColors.primaryGreen,
      ),

      // تعریف مسیرهای برنامه
      initialRoute: '/home',
      routes: {
        '/home': (context) => const HomeScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/edit_profile': (context) => const ProfileEditScreen(),
        '/map': (context) => const MapScreen(),
      },
    );
  }
}
