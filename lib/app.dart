import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AfghanTaxiApp',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const HomeScreen(),
      // اگر مسیرها را در آینده اضافه کنیم
      // routes: {
      //   '/home': (context) => const HomeScreen(),
      //   '/profile': (context) => const ProfileScreen(),
      // },
    );
  }
}