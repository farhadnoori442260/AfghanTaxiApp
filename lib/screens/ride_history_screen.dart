import 'package:flutter/material.dart';

class RideHistoryScreen extends StatelessWidget {
  const RideHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // پس‌زمینه بسیار ملایم
      appBar: AppBar(
        title: const Text("تاریخچه سفرهای سفیر", 
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 5, // تعداد سفرهای تستی
        itemBuilder: (context, index) {
          return _buildHistoryCard(index);
        },
      ),
    );
  }

  Widget _buildHistoryCard(int index) {
    // رنگ و متن بر اساس نوع سفر به صورت تستی
    bool isCompleted = index % 2 == 0; 

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // ۱. بخش بالایی: اطلاعات موتر و قیمت
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.directions_car_filled_rounded, color: Colors.orange, size: 28),
                ),
                const SizedBox(width: 12),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("سفیر اقتصادی", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    Text("۲۹ دلو، ساعت ۱۰:۳۰", style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
                const Spacer(),
                const Text("۱۸۰ AFN", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.green)),
              ],
            ),
          ),
          
          const Divider(height: 1, thickness: 0.5, indent: 20, endIndent: 20),

          // ۲. بخش میانی: آدرس‌ها
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _locationStep(Icons.circle, Colors.blue, "کارته چهار، چهارراهی پل سرخ"),
                const SizedBox(height: 12),
                _locationStep(Icons.location_on, Colors.red, "وزیر اکبرخان، سرک ۱۵"),
              ],
            ),
          ),

          // ۳. وضعیت سفر (تکمیل شده یا لغو شده)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: isCompleted ? Colors.green.withOpacity(0.05) : Colors.red.withOpacity(0.05),
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            child: Center(
              child: Text(
                isCompleted ? "سفر با موفقیت انجام شد ✅" : "سفر لغو شده ❌",
                style: TextStyle(
                  color: isCompleted ? Colors.green : Colors.red,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
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
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            address,
            style: const TextStyle(color: Colors.black54, fontSize: 13),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
