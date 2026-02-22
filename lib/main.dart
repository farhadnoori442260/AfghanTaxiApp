import 'package:flutter/material.dart';
import 'dart:async';
import 'app.dart';
import 'routes.dart';

void main() {
  runApp(const SafirApp());
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MapScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF145A41),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // اگر عکس هنوز آپلود نشده، این خط ممکن است خطا بدهد.
            // در آن صورت موقتاً این خط را کامنت کن.
            Image.asset('assets/images/splash.png', width: 200, errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.directions_car, size: 100, color: Colors.white);
            }),
            const SizedBox(height: 30),
            const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
          ],
        ),
      ),
    );
  }
}
