import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/driver_home_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/smart_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const HomeScreen(),
  '/login': (context) => const LoginScreen(),
  '/register': (context) => const RegisterScreen(),
  '/driverHome': (context) => const DriverHomeScreen(),
  '/profile': (context) => const ProfileScreen(),
  '/smart': (context) => const SmartScreen(),
};