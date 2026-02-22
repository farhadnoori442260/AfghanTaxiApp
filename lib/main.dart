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
      title: 'Safir Taxi',
      locale: const Locale('fa', 'AF'), 
      supportedLocales: const [Locale('fa', 'AF'), Locale('ps', 'AF')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(useMaterial3: true, primaryColor: const Color(0xFF145A41)),
      initialRoute: '/',
      routes: appRoutes,
    );
  }
}
