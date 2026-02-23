import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'home_screen.dart';
import 'map_screen.dart'; // وارد کردن فایل نقشه
import 'profile_screen.dart';

void main() {
  runApp(const SafirApp());
}

class SafirApp extends StatelessWidget {
  const SafirApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Safir Taxi',
      theme: ThemeData(
        primaryColor: const Color(0xFF145A41),
        fontFamily: 'IranYekan', 
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomeScreen(),
        '/map': (context) => const MapScreen(), // مسیر جدید نقشه
        '/profile': (context) => const ProfileScreen(),
      },
    );
  }
}
