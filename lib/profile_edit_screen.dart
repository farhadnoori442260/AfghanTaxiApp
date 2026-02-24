import 'package:flutter/material.dart';
import 'utils/colors.dart';
import 'utils/helper.dart';

class ProfileEditScreen extends StatelessWidget {
  const ProfileEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // تشخیص جهت متن برای تراز کردن فیلدها
    bool isFa = Localizations.localeOf(context).languageCode != 'en';

    return Scaffold(
      backgroundColor: SafirColors.bgLight,
      appBar: AppBar(
        title: Text(tr(context, 'full_name'), style: const TextStyle(fontSize: 18)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: isFa ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            // بخش اول: اطلاعات اصلی
            Text(
              isFa ? "اطلاعات اصلی" : "Primary Information",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: SafirColors.primaryGreen),
            ),
            const SizedBox(height: 15),
            _buildModernField(context, tr(context, 'full_name'), "Farhad Noori", Icons.person_outline),
            _buildModernField(context, tr(context, 'phone'), "09907027123", Icons.phone_android),
            _buildModernField(context, tr(context, 'id_card'), "123456789", Icons.badge_outlined),
            
            const SizedBox(height: 30),
            
            // بخش دوم: اطلاعات فرعی (مطابق عکس ۴)
            Text(
              isFa ? "اطلاعات فرعی" : "Secondary Information",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: SafirColors.primaryGreen),
            ),
            const SizedBox(height: 15),
            _buildModernField(context, isFa ? "ایمیل" : "Email", "farhad@example.com", Icons.email_outlined),
            _buildModernField(context, isFa ? "آدرس" : "Address", isFa ? "کابل، افغانستان" : "Kabul, Afghanistan", Icons.location_on_outlined),

            const SizedBox(height: 40),

            // دکمه ذخیره بزرگ (مطابق عکس ۴)
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  // منطق ذخیره سازی
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(tr(context, 'status_updated'))),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: SafirColors.primaryGreen,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  elevation: 2,
                ),
                child: Text(
                  tr(context, 'confirm'),
                  style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ویجت فیلد ورودی مدرن با استایل جهانی
  Widget _buildModernField(BuildContext context, String label, String hint, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: Icon(icon, color: SafirColors.primaryGreen, size: 20),
          filled: true,
          fillColor: Colors.white,
          labelStyle: const TextStyle(color: SafirColors.textDark),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: SafirColors.primaryGreen, width: 2),
          ),
        ),
      ),
    );
  }
}
