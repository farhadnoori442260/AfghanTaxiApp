import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'main.dart'; 
import 'routes.dart';

class SafirApp extends StatelessWidget {
  const SafirApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'سفیر',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fa', 'IR'),
        Locale('ps', 'AF'),
        Locale('en', 'US'),
      ],
      locale: const Locale('fa', 'IR'),
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF145A41),
      ),
      home: const SplashScreen(), // شروع از اسپلش
    );
  }
}
