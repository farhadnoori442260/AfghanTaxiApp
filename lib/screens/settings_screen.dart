import 'package:flutter/material.dart';
import '../utils/helper.dart';
import '../utils/colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tr(context, 'settings'))),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            tr(context, 'settings'), // عنوان بخش زبان
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          // انتخاب زبان دری
          _languageTile(context, "دری (Persian)", 'fa', Icons.language),
          
          // انتخاب زبان پشتو
          _languageTile(context, "پښتو (Pashto)", 'ps', Icons.translate),
          
          // انتخاب زبان انگلیسی
          _languageTile(context, "English", 'en', Icons.abc),
        ],
      ),
    );
  }

  Widget _languageTile(BuildContext context, String title, String langCode, IconData icon) {
    bool isSelected = Localizations.localeOf(context).languageCode == langCode;

    return Card(
      elevation: isSelected ? 4 : 0,
      color: isSelected ? SafirColors.primaryGreen.withOpacity(0.1) : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: isSelected ? SafirColors.primaryGreen : Colors.grey.shade300),
      ),
      child: ListTile(
        leading: Icon(icon, color: isSelected ? SafirColors.primaryGreen : Colors.grey),
        title: Text(title, style: TextStyle(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
        trailing: isSelected ? const Icon(Icons.check_circle, color: SafirColors.primaryGreen) : null,
        onTap: () {
          // اینجا در آینده منطق تغییر زبان سیستم را وصل می‌کنیم
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("زبان به $title تغییر یافت (نیاز به مدیریت وضعیت)")),
          );
        },
      ),
    );
  }
}
