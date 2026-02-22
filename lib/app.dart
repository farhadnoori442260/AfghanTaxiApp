import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'routes.dart';

class SafirApp extends StatelessWidget {
  const SafirApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // حذف نوار دیباگ از بالای صفحه
      debugShowCheckedModeBanner: false,
      
      // نام برنامه
      title: 'Safir',

      // تنظیم لسان پیش‌فرض روی دری افغانستان
      // این بخش باعث می‌شود تمام ویجت‌ها به صورت راست‌به‌چپ (RTL) نمایش داده شوند
      locale: const Locale('fa', 'AF'), 

      // لسان‌های مورد حمایت برنامه
      supportedLocales: const [
        Locale('fa', 'AF'), // دری
        Locale('ps', 'AF'), // پشتو
        Locale('en', 'US'), // انگلیسی
      ],

      // تنظیمات مربوط به بومی‌سازی (Localizations)
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      // تنظیمات تم رنگی برنامه بر اساس رنگ سبز سفیر
      theme: ThemeData(
        primaryColor: const Color(0xFF145A41),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Color(0xFF145A41)),
          titleTextStyle: TextStyle(
            color: Color(0xFF145A41),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        // فونت پیش‌فرض برای نمایش بهتر متون دری
        fontFamily: 'sans-serif', 
      ),

      // تعیین مسیرهای برنامه که در فایل routes.dart تعریف شده‌اند
      initialRoute: '/',
      routes: appRoutes,
    );
  }
}
