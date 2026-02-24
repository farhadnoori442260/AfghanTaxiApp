import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'utils/colors.dart';
import 'utils/helper.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import 'profile_edit_screen.dart';

void main() => runApp(const SafirApp());

class SafirApp extends StatefulWidget {
  const SafirApp({super.key});

  static _SafirAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_SafirAppState>()!;

  @override
  State<SafirApp> createState() => _SafirAppState();
}

class _SafirAppState extends State<SafirApp> {
  ThemeMode _themeMode = ThemeMode.light;
  Locale _locale = const Locale('fa'); // پیش‌فرض: دری

  void changeTheme(bool isDark) => setState(() => _themeMode = isDark ? ThemeMode.dark : ThemeMode.light);
  void changeLanguage(String langCode) => setState(() => _locale = Locale(langCode));

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: _locale,
      supportedLocales: const [Locale('fa'), Locale('ps'), Locale('en')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      themeMode: _themeMode,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: SafirColors.primaryGreen,
        scaffoldBackgroundColor: SafirColors.bgLight,
        fontFamily: 'IranYekan',
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: SafirColors.primaryGreen,
        useMaterial3: true,
      ),
      initialRoute: '/home',
      routes: {
        '/home': (context) => const HomeScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/edit_profile': (context) => const ProfileEditScreen(),
      },
    );
  }
}
