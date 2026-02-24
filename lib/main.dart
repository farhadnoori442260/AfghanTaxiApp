import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// اصلاح نام پوشه به utlis مطابق با پوشه‌ای که در گیت‌هاب ساختی
import 'utlis/colors.dart';
import 'utlis/helper.dart';

// ایمپورت صفحات
import 'splash_screen.dart'; // اضافه شدن صفحه اسپلش
import 'home_screen.dart';
import 'profile_screen.dart';
import 'profile_edit_screen.dart';
import 'map_screen.dart';

void main() => runApp(const SafirApp());

class SafirApp extends StatefulWidget {
  const SafirApp({super.key});

  static _SafirAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_SafirAppState>()!;

  @override
  State<SafirApp> createState() => _SafirAppState();
}

class _SafirAppState extends State<SafirApp> {
  ThemeMode _themeMode = ThemeMode.light;
  Locale _locale = const Locale('fa'); // زبان پیش‌فرض: دری

  void changeTheme(bool isDark) {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

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

      themeMode: _themeMode,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: SafirColors.primaryGreen,
        scaffoldBackgroundColor: SafirColors.bgLight,
        fontFamily: 'IranYekan', 
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

      // تغییر مسیر اولیه به اسپلش اسکرین
      initialRoute: '/splash', 
      routes: {
        '/splash': (context) => const SplashScreen(), // صفحه شروع
        '/home': (context) => const HomeScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/edit_profile': (context) => const ProfileEditScreen(),
        '/map': (context) => const MapScreen(),
      },
    );
  }
}
