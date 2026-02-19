import 'package:flutter/material.dart';
import '../utils/colors.dart'; // رنگ‌های سفیر

class RideHistoryScreen extends StatelessWidget {
  const RideHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFDFB), // پس‌زمینه بسیار ملایم متمایل به سبز
      appBar: AppBar(
        title: const Text(
          "تاریخچه سفرهای سفیر",
          style: TextStyle(fontFamily: 'IranYekan', fontWeight: FontWeight.bold, color: SafirColors.primaryGreen),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: SafirColors.primaryGreen, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 5,
        itemBuilder: (context, index) {
          return _buildHistoryCard(index);
        },
      ),
    );
  }

  Widget _buildHistoryCard(int index) {
    bool isCompleted = index % 3 != 0; // تنوع در وضعیت سفرها

    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: SafirColors.primaryGreen.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
        border: Border.all(color: SafirColors.primaryGreen.withOpacity(0.05)),
      ),
      child: Column(
        children: [
          // ۱. بخش بالایی: اطلاعات موتر و قیمت
          Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: SafirColors.primaryGreen.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Icon(Icons.directions_car_filled_rounded, color: SafirColors.primaryGreen, size: 26),
                ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "سفیر اقتصادی",
                      style: TextStyle(fontFamily: 'IranYekan', fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      "۲۹ دلو ۱۴۰۴ • ۱۰:۳۰",
                      style: TextStyle(fontFamily: 'IranYekan', color: Colors.grey.shade500, fontSize: 11),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  "۱۸۰ AFN",
                  style: TextStyle(
                    fontFamily: 'IranYekan',
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                    color: isCompleted ? SafirColors.primaryGreen : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          
          const Divider(height: 1, thickness: 0.6, indent: 20, endIndent: 20),

          // ۲. بخش میانی: مسیر سفر
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                _locationStep(Icons.circle_outlined, SafirColors.primaryGreen, "مبدأ: کارته چهار، چهارراهی پل سرخ"),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.only(right: 7),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(width: 1, height: 15, color: Colors.grey.shade300),
                  ),
                ),
                _locationStep(Icons.location_on_rounded, Colors.redAccent, "مقصد: وزیر اکبرخان، سرک ۱۵"),
              ],
            ),
          ),

          // ۳. نوار وضعیت پایین کارت
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: isCompleted ? SafirColors.primaryGreen.withOpacity(0.05) : Colors.red.withOpacity(0.05),
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(25)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isCompleted ? Icons.check_circle_outline : Icons.cancel_outlined,
                  size: 14,
                  color: isCompleted ? SafirColors.primaryGreen : Colors.redAccent,
                ),
                const SizedBox(width: 6),
                Text(
                  isCompleted ? "سفر با موفقیت تکمیل شد" : "این سفر لغو شد",
                  style: TextStyle(
                    fontFamily: 'IranYekan',
                    color: isCompleted ? SafirColors.primaryGreen : Colors.redAccent,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _locationStep(IconData icon, Color color, String address) {
    return Row(
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            address,
            style: const TextStyle(fontFamily: 'IranYekan', color: Colors.black87, fontSize: 13),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
