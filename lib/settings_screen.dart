import 'package:flutter/material.dart';
// آدرس‌ها را مستقیم کردیم چون فایل‌ها را جابه‌جا کردیم
// اگر فایل‌های colors و helper هنوز در پوشه utils هستند، آدرس به این شکل می‌شود:
import 'package:afghan_taxi_app/utils/helper.dart'; 
import 'package:afghan_taxi_app/utils/colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr(context, 'settings')),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            tr(context, 'language_settings'),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          _langTile(context, "دری", "fa"),
          _langTile(context, "پښتو", "ps"),
          _langTile(context, "English", "en"),
          const Divider(height: 40),
          ListTile(
            leading: const Icon(Icons.support_agent, color: Color(0xFF145A41)), // کد رنگ سفیر
            title: Text(tr(context, 'support')),
            onTap: () {
              // منطق پشتیبانی
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.redAccent),
            title: Text(tr(context, 'exit')),
            onTap: () {
              // منطق خروج
            },
          ),
        ],
      ),
    );
  }

  Widget _langTile(BuildContext context, String name, String code) {
    // رنگ سبز سفیر را مستقیم جایگزین کردیم تا اگر فایل colors پیدا نشد، ارور ندهد
    const Color primaryGreen = Color(0xFF145A41);
    bool isCurrent = Localizations.localeOf(context).languageCode == code;
    
    return ListTile(
      title: Text(name),
      trailing: isCurrent ? const Icon(Icons.check_circle, color: primaryGreen) : null,
      onTap: () {
        // منطق تغییر زبان
      },
    );
  }
}
