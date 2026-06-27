import 'package:flutter/material.dart';
import 'utlis/colors.dart';

class SettingsScreen extends StatefulWidget {
  final String currentLanguage;
  final Function(String, String) onLanguageChanged; // برای ارسال همزمان کد و نام زبان تغییر یافت ✅

  const SettingsScreen({
    super.key,
    required this.currentLanguage,
    required this.onLanguageChanged,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late String _tempLanguage;

  @override
  void initState() {
    super.initState();
    _tempLanguage = widget.currentLanguage;
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Directionality(
          // تغییر پویای جهت دیالوگ بر اساس زبان انتخابی برای پشتیبانی از انگلیسی
          textDirection: _tempLanguage == 'English' ? TextDirection.ltr : TextDirection.rtl,
          child: AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(Icons.language, color: SafirColors.primaryGreen),
                const SizedBox(width: 8),
                Text(
                  _tempLanguage == 'English' ? 'Select Language' : 'انتخاب زبان', 
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            // استفاده از StatefulBuilder برای جابه‌جایی و نمایش آنی تیک سبز رنگ روی گزینه‌ها ✅
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setDialogState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // گزینه زبان دری
                    ListTile(
                      title: const Text('دری', style: TextStyle(fontWeight: FontWeight.w500)),
                      trailing: _tempLanguage == 'دری' ? const Icon(Icons.check_circle, color: SafirColors.primaryGreen) : null,
                      onTap: () {
                        setDialogState(() => _tempLanguage = 'دری');
                        setState(() {}); // بروزرسانی متن صفحه اصلی تنظیمات
                        widget.onLanguageChanged('fa', 'دری');
                        Navigator.pop(context);
                      },
                    ),
                    Divider(height: 1, color: Colors.grey.withOpacity(0.15)),
                    
                    // گزینه زبان پشتو
                    ListTile(
                      title: const Text('پشتو', style: TextStyle(fontWeight: FontWeight.w500)),
                      trailing: _tempLanguage == 'پشتو' ? const Icon(Icons.check_circle, color: SafirColors.primaryGreen) : null,
                      onTap: () {
                        setDialogState(() => _tempLanguage = 'پشتو');
                        setState(() {}); // بروزرسانی متن صفحه اصلی تنظیمات
                        widget.onLanguageChanged('ps', 'پشتو');
                        Navigator.pop(context);
                      },
                    ),
                    Divider(height: 1, color: Colors.grey.withOpacity(0.15)),
                    
                    // گزینه زبان انگلیسی که گم شده بود و اضافه شد 🌟
                    ListTile(
                      title: const Text('English', style: TextStyle(fontWeight: FontWeight.w500)),
                      trailing: _tempLanguage == 'English' ? const Icon(Icons.check_circle, color: SafirColors.primaryGreen) : null,
                      onTap: () {
                        setDialogState(() => _tempLanguage = 'English');
                        setState(() {}); // بروزرسانی متن صفحه اصلی تنظیمات
                        widget.onLanguageChanged('en', 'English');
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isEnglish = _tempLanguage == 'English';

    return Directionality(
      textDirection: isEnglish ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF9F9F9),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.5,
          title: Text(
            isEnglish ? 'Settings' : 'تنظیمات', 
            style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          centerTitle: true,
          // تغییر اتوماتیک آیکون بازگشت بر اساس راست‌چین یا چپ‌چین بودن
          leading: IconButton(
            icon: Icon(isEnglish ? Icons.arrow_back : Icons.arrow_back, color: Colors.black87),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 12),
          children: [
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: Colors.grey.withOpacity(0.15))),
              child: UrbanListTile(
                leading: const Icon(Icons.language, color: SafirColors.primaryGreen),
                title: Text(
                  isEnglish ? 'App Language' : 'زبان برنامه (Language)', 
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                subtitle: Text(
                  isEnglish ? 'Current: $_tempLanguage' : 'زبان فعلی: $_tempLanguage', 
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                trailing: Icon(isEnglish ? Icons.chevron_right : Icons.chevron_left, color: Colors.grey),
                onTap: _showLanguageDialog,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ویجت اختصاصی شما بدون هیچ تغییری کاملاً حفظ شد حفظ شد 🔓
class UrbanListTile extends StatelessWidget {
  final Widget leading;
  final Widget title;
  final Widget subtitle;
  final Widget trailing;
  final VoidCallback onTap;

  const UrbanListTile({
    super.key,
    required this.leading,
    required this.title,
    required this.subtitle,
    required this.trailing,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            leading,
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  title,
                  const SizedBox(height: 4),
                  subtitle,
                ],
              ),
            ),
            trailing,
          ],
        ),
      ),
    );
  }
}
