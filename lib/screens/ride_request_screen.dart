import 'dart:ui';
import 'package:flutter/material.dart';

class RideRequestScreen extends StatefulWidget {
  const RideRequestScreen({super.key});

  @override
  State<RideRequestScreen> createState() => _RideRequestScreenState();
}

class _RideRequestScreenState extends State<RideRequestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ۱. پس‌زمینه نقشه (مات شده)
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFF1E1E1E), // یا یک تصویر نقشه
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(color: Colors.black.withOpacity(0.4)),
            ),
          ),

          // ۲. بخش مرکزی: انیمیشن رادار برای جستجوی سفیر
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildRadarAnimation(),
                const SizedBox(height: 30),
                const Text(
                  "در حال جستجوی نزدیک‌ترین سفیر...",
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  "لطفاً صبور باشید، رانندگان در حال بررسی هستند",
                  style: TextStyle(color: Colors.white54, fontSize: 13),
                ),
              ],
            ),
          ),

          // ۳. کارت اطلاعات سفر در پایین صفحه
          Align(
            alignment: Alignment.bottomCenter,
            child: _buildRequestDetailsCard(),
          ),
        ],
      ),
    );
  }

  Widget _buildRadarAnimation() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // افکت تپش (Pulse)
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.orangeAccent.withOpacity(0.1),
          ),
        ),
        const Icon(Icons.location_searching_rounded, color: Colors.orangeAccent, size: 60),
      ],
    );
  }

  Widget _buildRequestDetailsCard() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [BoxShadow(blurRadius: 30, color: Colors.black38)],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("سفیر اقتصادی", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  Text("کرایه تخمینی شما", style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                decoration: BoxDecoration(color: Colors.green.withOpacity(0.1), borderRadius: BorderRadius.circular(15)),
                child: const Text("۱۸۰ AFN", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 20)),
              ),
            ],
          ),
          const SizedBox(height: 25),
          const LinearProgressIndicator(
            backgroundColor: Colors.black12, 
            color: Colors.orangeAccent,
            minHeight: 6,
          ),
          const SizedBox(height: 20),
          
          // دکمه لغو درخواست
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text("لغو درخواست سفر", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}
