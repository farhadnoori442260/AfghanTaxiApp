import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // حتماً این را اضافه کن
import 'app_routes.dart'; // یا هر اسمی که فایل مسیرها دارد

void main() async {
  // این خط برای اطمینان از آماده بودن زیرساخت اندروید است
  WidgetsFlutterBinding.ensureInitialized();
  
  // متصل کردن برنامه به فایربیس با استفاده از همان فایلی که آپلود کردی
  await Firebase.initializeApp();

  runApp(const SafirApp());
}

class SafirApp extends StatelessWidget {
  const SafirApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'سفیر',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      // استفاده از مسیرهایی که با هم درست کردیم
      initialRoute: '/',
      routes: appRoutes,
    );
  }
}
