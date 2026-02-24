import 'package:flutter/material.dart';
import 'utils/colors.dart';
import 'utils/helper.dart';
import 'widgets/medal_card.dart'; // وارد کردن ویجت مدال

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SafirColors.bgLight,
      appBar: AppBar(
        title: Text(tr(context, 'profile'), style: const TextStyle(color: SafirColors.textDark)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: SafirColors.textDark),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            // بخش تصویر و امتیاز
            const Center(
              child: CircleAvatar(
                radius: 55,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Color(0xFFE2E8F0),
                  child: Icon(Icons.person, size: 60, color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.star, color: SafirColors.accentGold, size: 20),
                const SizedBox(width: 5),
                Text(
                  "4.8 ${tr(context, 'rating')}",
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
            
            const SizedBox(height: 40),
            
            // بخش مدال‌ها (مطابق عکس ۳)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  tr(context, 'medals_and_honors'),
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MedalCard(
                  title: tr(context, 'popular'),
                  icon: Icons.favorite,
                  color: const Color(0xFFEC4899), // صورتی مدرن
                ),
                MedalCard(
                  title: tr(context, 'top_driver_year'),
                  icon: Icons.emoji_events,
                  color: SafirColors.accentGold,
                ),
              ],
            ),
            
            const SizedBox(height: 40),
            
            // دکمه ویرایش (هدایت به صفحه ۴)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: ListTile(
                onTap: () => Navigator.pushNamed(context, '/edit_profile'),
                tileColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                leading: const Icon(Icons.edit, color: SafirColors.primaryGreen),
                title: Text(tr(context, 'full_name')), // یا کلید ویرایش
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
