import 'package:flutter/material.dart';
import 'utils/colors.dart';
import 'utils/helper.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // بررسی جهت زبان برای چیدمان درست (راست به چپ)
    bool isRtl = Localizations.localeOf(context).languageCode != 'en';

    return Scaffold(
      extendBodyBehindAppBar: true,
      // اپ‌بار شفاف برای نمایش بهتر نقشه
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: SafirColors.textDark, size: 30),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Column(
              children: [
                Text(
                  tr(context, 'app_name'),
                  style: const TextStyle(
                    color: SafirColors.primaryGreen,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const Icon(Icons.home, color: SafirColors.primaryGreen, size: 18),
              ],
            ),
          )
        ],
      ),
      drawer: _buildModernDrawer(context),
      body: Stack(
        children: [
          // بخش نقشه (پس‌زمینه اصلی)
          Container(
            color: const Color(0xFFE2E8F0),
            child: const Center(
              child: Icon(Icons.map, size: 100, color: Colors.black12),
            ),
          ),

          // قاب معلق پایین صفحه (Floating Navigation Dashboard)
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 25,
                    spreadRadius: 5,
                    offset: const Offset(0, 10),
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // ۱. درخواست سفیر
                  _buildNavOption(
                    context,
                    icon: Icons.directions_car_filled,
                    labelKey: 'request_ride', // در helper: درخواست سفیر
                    onTap: () => Navigator.pushNamed(context, '/map'),
                  ),
                  // ۲. ثبت‌نام راننده
                  _buildNavOption(
                    context,
                    icon: Icons.person_add_alt_1,
                    labelKey: 'reg_title', // در helper: ثبت‌نام راننده
                    onTap: () {},
                  ),
                  // ۳. باربری
                  _buildNavOption(
                    context,
                    icon: Icons.local_shipping,
                    labelKey: 'safir_cargo', // در helper: باربری
                    onTap: () {},
                  ),
                  // ۴. بین شهری
                  _buildNavOption(
                    context,
                    icon: Icons.location_city,
                    labelKey: 'safir_luxury', // در helper: بین شهری (یا لغتی که برای آن ست کردید)
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ویجت اختصاصی برای آیتم‌های منوی پایین
  Widget _buildNavOption(BuildContext context, {required IconData icon, required String labelKey, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: SafirColors.primaryGreen.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: SafirColors.primaryGreen, size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            tr(context, labelKey),
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: SafirColors.textDark,
            ),
          ),
        ],
      ),
    );
  }

  // دراور مدرن با تنظیمات زبان و شب
  Widget _buildModernDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // هدر دراور (بخش پروفایل)
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: SafirColors.primaryGreen),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: SafirColors.primaryGreen, size: 40),
            ),
            accountName: const Text("Farhad Noori", style: TextStyle(fontWeight: FontWeight.bold)),
            accountEmail: const Text("09907027123"),
            onDetailsPressed: () => Navigator.pushNamed(context, '/profile'),
          ),
          
          // بخش تنظیمات داینامیک
          ExpansionTile(
            leading: const Icon(Icons.settings, color: SafirColors.primaryGreen),
            title: Text(tr(context, 'settings')),
            children: [
              // انتخاب زبان
              ListTile(
                leading: const Icon(Icons.language, size: 20),
                title: const Text("انتخاب زبان (Language)"),
                onTap: () => _showLanguagePicker(context),
              ),
              // حالت شب
              ListTile(
                leading: const Icon(Icons.dark_mode, size: 20),
                title: Text(tr(context, 'is_sos_active')), // یا هر کلیدی برای تم
                trailing: Switch(
                  value: Theme.of(context).brightness == Brightness.dark,
                  onChanged: (val) {
                    // فراخوانی متد تغییر تم از main.dart
                    import 'main.dart'; // اگر ارور داد باید به شکلی که در پیام قبلی گفتم صدا بزنید
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showLanguagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(title: const Text("دری"), onTap: () { /* کد تغییر به fa */ Navigator.pop(context); }),
          ListTile(title: const Text("پشتو"), onTap: () { /* کد تغییر به ps */ Navigator.pop(context); }),
          ListTile(title: const Text("English"), onTap: () { /* کد تغییر به en */ Navigator.pop(context); }),
        ],
      ),
    );
  }
}
