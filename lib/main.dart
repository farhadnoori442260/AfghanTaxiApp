import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app.dart';

void main() async {
  // اطمینان از مقداردهی اولیه ویجت‌ها
  WidgetsFlutterBinding.ensureInitialized();

  // فیکس کردن جهت صفحه و استایل استاتوس‌بار برای ظاهر مدرن سفیر
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));

  runApp(const SafirApp());
}
