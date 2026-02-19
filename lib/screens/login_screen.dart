import 'dart:ui';
import 'package:flutter/material.dart';
import '../utils/colors.dart'; // حتماً این فایل را داشته باش

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ۱. پس‌زمینه با رنگ سبز برند سفیر (گرادینت ملایم)
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [SafirColors.primaryGreen, Color(0xFF0A2E21)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          
          // ۲. محتوای صفحه با افکت شیشه‌ای
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(30),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.white.withOpacity(0.2)),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // لوگوی سفیر (استفاده از لوگوی S که ساختی یا آیکون)
                        const Icon(Icons.local_taxi_rounded, size: 80, color: Colors.white),
                        const SizedBox(height: 10),
                        const Text(
                          "سفیر",
                          style: TextStyle(
                            fontFamily: 'IranYekan',
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          "سفر هوشمند و مطمئن",
                          style: TextStyle(fontFamily: 'IranYekan', color: Colors.white70, fontSize: 14),
                        ),
                        const SizedBox(height: 40),

                        // فیلد ورود شماره موبایل
                        _buildTextField("شماره موبایل", Icons.phone_android),
                        const SizedBox(height: 20),

                        // دکمه ورود
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white, // دکمه سفید روی پس‌زمینه سبز
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                              elevation: 0,
                            ),
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, '/map');
                            },
                            child: const Text(
                              "ورود / ثبت‌نام",
                              style: TextStyle(
                                fontFamily: 'IranYekan',
                                color: SafirColors.primaryGreen,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        
                        // لینک به صفحه ثبت‌نام (اگر جداست)
                        TextButton(
                          onPressed: () => Navigator.pushNamed(context, '/register'),
                          child: const Text(
                            "هنوز عضو نشده‌اید؟ ثبت‌نام کنید",
                            style: TextStyle(fontFamily: 'IranYekan', color: Colors.white70, fontSize: 13),
                          ),
                        ),
                        
                        const Text(
                          "با ورود به سفیر، شرایط و قوانین را می‌پذیرم",
                          style: TextStyle(fontFamily: 'IranYekan', color: Colors.white38, fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String hint, IconData icon) {
    return TextField(
      style: const TextStyle(fontFamily: 'IranYekan', color: Colors.white),
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(fontFamily: 'IranYekan', color: Colors.white54),
        prefixIcon: Icon(icon, color: Colors.white70),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
      ),
      keyboardType: TextInputType.phone,
    );
  }
}
