import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'screens/home_screen.dart';
import 'screens/home_dashboard.dart';
import 'screens/fare_test_page.dart';
import 'utils/colors.dart';

// این کلاس همان چیزی است که در main.dart فراخوانی کردیم
class SafirApp extends StatelessWidget {
  const SafirApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'سفیر | Safir',
      debugShowCheckedModeBanner: false,
      
      // ۱. تنظیمات زبان افغانستان
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('fa', 'AF')],
      locale: const Locale('fa', 'AF'),

      // ۲. تم رنگی پروژه سفیر
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: SafirColors.primaryGreen,
        fontFamily: 'IranYekan', 
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: SafirColors.primaryGreen,
          elevation: 0,
          centerTitle: true,
        ),
      ),

      // ۳. لیست تمام صفحات (Routes)
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/dashboard': (context) => const HomeDashboard(),
        '/fare_test': (context) => const FareTestPage(),
      },
    );
  }
}
