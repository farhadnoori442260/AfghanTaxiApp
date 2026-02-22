import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'routes.dart';

void main() {
  runApp(const SafirApp());
}

class SafirApp extends StatelessWidget {
  const SafirApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Safir',
      // تنظیمات لسان دری برای افغانستان
      locale: const Locale('fa', 'AF'),
      supportedLocales: const [
        Locale('fa', 'AF'),
        Locale('ps', 'AF'),
        Locale('en', 'US'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(fontFamily: 'Vazir'), // اگر فونت وزیر داری
      initialRoute: '/',
      routes: appRoutes,
    );
  }
}
