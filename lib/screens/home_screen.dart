import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxi_app_afghanistan/screens/driver_home.dart';
import 'package:taxi_app_afghanistan/screens/passenger_home.dart';
import 'package:taxi_app_afghanistan/screens/profile_screen.dart';
import 'package:taxi_app_afghanistan/screens/map_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'تاکسی آنلاین افغانستان',
          style: GoogleFonts.getFont(
            'B Nazanin',
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.green.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PassengerHome()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade600,
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: Text(
                'ورود به بخش مسافر',
                style: GoogleFonts.getFont(
                  'B Nazanin',
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DriverHome()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange.shade700,
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: Text(
                'ورود به بخش راننده',
                style: GoogleFonts.getFont(
                  'B Nazanin',
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MapScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade800,
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: Text(
                'نمایش نقشه',
                style: GoogleFonts.getFont(
                  'B Nazanin',
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfileScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple.shade700,
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: Text(
                'پروفایل من',
                style: GoogleFonts.getFont(
                  'B Nazanin',
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}