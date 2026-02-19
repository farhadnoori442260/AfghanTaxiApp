import 'dart:ui';
import 'package:flutter/material.dart';
import '../utils/colors.dart';

class RideRequestScreen extends StatefulWidget {
  const RideRequestScreen({super.key});

  @override
  State<RideRequestScreen> createState() => _RideRequestScreenState();
}

class _RideRequestScreenState extends State<RideRequestScreen> with TickerProviderStateMixin {
  late AnimationController _radarController;

  @override
  void initState() {
    super.initState();
    _radarController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _radarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ۱. پس‌زمینه (در اینجا می‌توانید تصویر نقشه را بگذارید)
          Container(
            color: const Color(0xFF0A1A14), // سبز بسیار تیره
          ),

          // ۲. بخش مرکزی: انیمیشن رادار سفیری
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildPulseRadar(),
                const SizedBox(height: 40),
                const Text(
                  "در حال جستجوی سفیر...",
                  style: TextStyle(fontFamily: 'IranYekan', color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  "سفیران کابل در حال بررسی درخواست شما هستند",
                  style: TextStyle(fontFamily: 'IranYekan', color: Colors.white54, fontSize: 13),
                ),
              ],
            ),
          ),

          // ۳. کارت اطلاعات سفر در پایین صفحه با افکت شیشه‌ای
          Align(
            alignment: Alignment.bottomCenter,
            child: _buildRequestDetailsCard(),
          ),
        ],
      ),
    );
  }

  Widget _buildPulseRadar() {
    return AnimatedBuilder(
      animation: _radarController,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            for (int i = 1; i <= 3; i++)
              Transform.scale(
                scale: _radarController.value * i * 0.8,
                child: Opacity(
                  opacity: (1 - _radarController.value).clamp(0.0, 1.0),
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: SafirColors.primaryGreen, width: 2),
                    ),
                  ),
                ),
              ),
            Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                color: SafirColors.primaryGreen,
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: SafirColors.primaryGreen, blurRadius: 30)],
              ),
              child: const Icon(Icons.local_taxi, color: Colors.white, size: 50),
            ),
          ],
        );
      },
    );
  }

  Widget _buildRequestDetailsCard() {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "سفیر اقتصادی",
                        style: TextStyle(fontFamily: 'IranYekan', fontWeight: FontWeight.bold, fontSize: 18, color: SafirColors.primaryGreen),
                      ),
                      Text(
                        "کرایه برآورد شده",
                        style: TextStyle(fontFamily: 'IranYekan', color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                    decoration: BoxDecoration(
                      color: SafirColors.primaryGreen.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Text(
                      "۱۸۰ AFN",
                      style: TextStyle(fontFamily: 'IranYekan', color: SafirColors.primaryGreen, fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const LinearProgressIndicator(
                backgroundColor: Color(0xFFE0E0E0),
                color: SafirColors.primaryGreen,
                minHeight: 6,
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.redAccent, width: 1.5),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                  child: const Text(
                    "لغو درخواست سفیر",
                    style: TextStyle(fontFamily: 'IranYekan', color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
