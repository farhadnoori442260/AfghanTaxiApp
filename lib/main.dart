import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'routes.dart'; // اصلاح شد: نام فایل شما در لیست سمت چپ routes.dart است

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // متصل کردن برنامه به فایربیس
  try {
    await Firebase.initializeApp();
  } catch (e) {
    print("Firebase initialization error: $e");
  }

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
        primaryColor: Colors.blue,
        useMaterial3: true,
      ),
      // استفاده از متغیر appRoutes که در فایل routes.dart تعریف کردی
      initialRoute: '/',
      routes: appRoutes,
    );
  }
}
