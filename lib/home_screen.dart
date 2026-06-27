import 'package:flutter/material.dart';
import 'utlis/colors.dart';
import 'map_screen.dart';
import 'settings_screen.dart';
import 'profile_screen.dart';

class SafirHomeScreen extends StatefulWidget {
  const SafirHomeScreen({super.key});

  @override
  State<SafirHomeScreen> createState() => _SafirHomeScreenState();
}

class _SafirHomeScreenState extends State<SafirHomeScreen> {
  int? _activeSelectedIndex; 
  String _currentLanguage = 'دری'; 
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Map<String, dynamic>> _services = [
    {'title': 'درخواست سفیر', 'icon': Icons.local_taxi, 'type': 'سفیر'},
    {'title': 'بین شهری', 'icon': Icons.add_road, 'type': 'بین شهری'},
    {'title': 'باربری سفیر', 'icon': Icons.local_shipping, 'type': 'باربری'},
    {'title': 'ثبت نام', 'icon': Icons.person_add, 'type': 'ثبت نام'},
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white, 
        drawer: Drawer(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 16, right: 12),
              child: ExactAnimatedMenu(
                currentLanguage: _currentLanguage,
                onLanguageChanged: (langCode, langName) {
                  setState(() {
                    _currentLanguage = langName;
                  });
                },
              ),
            ),
          ),
        ),
        body: GestureDetector(
          onTap: () => setState(() => _activeSelectedIndex = null),
          child: Stack(
            children: [
              Positioned(
                top: 40, right: 0, left: 0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Safir',
                            style: TextStyle(color: SafirColors.primaryGreen, fontSize: 28, fontWeight: FontWeight.bold, fontFamily: 'Serif'),
                          ),
                          IconButton(
                            icon: const Icon(Icons.menu, color: SafirColors.primaryGreen, size: 28),
                            onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                          ),
                        ],
                      ),
                    ),
                    Divider(color: SafirColors.primaryGreen.withOpacity(0.2), height: 1, thickness: 1),
                  ],
                ),
              ),
              Positioned(
                top: 140, right: 25, left: 25,
                child: const Text(
                  'سرویس مورد نظر را از منوی شناور انتخاب کنید:',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: SafirColors.primaryGreen),
                  textAlign: TextAlign.right,
                ),
              ),
              Positioned(
                bottom: 40, left: 15, right: 15,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15), 
                        blurRadius: 20,                       
                        spreadRadius: 2,                      
                        offset: const Offset(0, 8),           
                      )
                    ]
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(_services.length, (index) {
                      bool isVisualActive = _activeSelectedIndex == index;

                      return GestureDetector(
                        onTap: () {
                          if (_activeSelectedIndex == index) {
                            String serviceType = _services[index]['type'];
                            Widget targetScreen;

                            switch (serviceType) {
                              case 'سفیر':
                                targetScreen = SafirMapScreen(serviceType: serviceType);
                                break;
                              case 'بین شهری':
                                targetScreen = const BinShahriScreen();
                                break;
                              case 'باربری':
                                targetScreen = const BarbariScreen();
                                break;
                              case 'ثبت نام':
                                targetScreen = const RegistrationScreen();
                                break;
                              default:
                                targetScreen = SafirMapScreen(serviceType: serviceType);
                            }

                            Navigator.push(context, MaterialPageRoute(builder: (context) => targetScreen));
                          } else {
                            setState(() => _activeSelectedIndex = index);
                          }
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          clipBehavior: Clip.none,
                          children: [
                            AnimatedPositioned(
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.easeOutBack,
                              bottom: isVisualActive ? 65 : 20, 
                              child: AnimatedOpacity(
                                duration: const Duration(milliseconds: 180),
                                opacity: isVisualActive ? 1.0 : 0.0,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: SafirColors.primaryGreen,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    _services[index]['title'],
                                    style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              width: 52,
                              height: 52,
                              decoration: BoxDecoration(
                                color: isVisualActive ? SafirColors.primaryGreen : Colors.grey[100],
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                _services[index]['icon'],
                                color: isVisualActive ? Colors.white : SafirColors.primaryGreen,
                                size: 24,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
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

class ExactAnimatedMenu extends StatefulWidget {
  final String currentLanguage;
  final Function(String, String) onLanguageChanged; // برای هماهنگی با هر دو پارامتر اصلاح شد ✅

  const ExactAnimatedMenu({
    super.key,
    required this.currentLanguage,
    required this.onLanguageChanged,
  });

  @override
  State<ExactAnimatedMenu> createState() => _ExactAnimatedMenuState();
}

class _ExactAnimatedMenuState extends State<ExactAnimatedMenu> {
  int? activeIndex;

  final List<Map<String, dynamic>> menuItems = [
    {'title': 'دعوت دوستان', 'icon': Icons.person_add_alt_1_outlined},
    {'title': 'تنظیمات', 'icon': Icons.settings_outlined},
    {'title': 'پیام‌ها', 'icon': Icons.mail_outline},
    {'title': 'کد تخفیف', 'icon': Icons.local_offer_outlined},
  ];

  void _updateIndexByPosition(Offset localPosition, double itemHeight) {
    double profileHeaderHeight = 96.0; 
    double relativeY = localPosition.dy - profileHeaderHeight;
    int index = (relativeY / itemHeight).floor();
    if (index >= 0 && index < menuItems.length) {
      if (activeIndex != index) setState(() => activeIndex = index);
    } else {
      if (activeIndex != null) setState(() => activeIndex = null);
    }
  }

  void _navigateToPage(String title) {
    Navigator.pop(context);
    if (title == 'تنظیمات') {
      // اصلاح ناوبری برای ارسال صحیح توابع چندپارامتری به صفحه تنظیمات ✅
      Navigator.push(
        context, 
        MaterialPageRoute(
          builder: (context) => SettingsScreen(
            currentLanguage: widget.currentLanguage, 
            onLanguageChanged: widget.onLanguageChanged,
          ),
        ),
      );
    } else if (title == 'دعوت دوستان') {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const InviteFriendsScreen()));
    } else if (title == 'پیام‌ها') {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const MessagesScreen()));
    } else if (title == 'کد تخفیف') {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const DiscountCodeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    double menuWidth = 280.0;
    double itemHeight = 56.0;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        width: menuWidth,
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [BoxShadow(color: Color(0x0A000000), blurRadius: 40, offset: Offset(0, 16))],
        ),
        child: GestureDetector(
          onPanUpdate: (details) => _updateIndexByPosition(details.localPosition, itemHeight),
          onPanEnd: (_) => setState(() => activeIndex = null),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context); 
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const UserProfileScreen()));
                },
                child: Container(
                  height: 72,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  color: Colors.transparent, 
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: SafirColors.primaryGreen.withOpacity(0.12),
                        child: const Icon(Icons.person, color: SafirColors.primaryGreen, size: 26),
                      ),
                      const SizedBox(width: 14),
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('فرهاد نوری', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87)),
                          SizedBox(height: 4),
                          Text('مشاهده و ویرایش حساب', style: TextStyle(fontSize: 11, color: Colors.black54)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Divider(height: 16, thickness: 1, color: Colors.grey.withOpacity(0.12), indent: 12, endIndent: 12),
              ...List.generate(menuItems.length, (index) {
                final item = menuItems[index];
                final isHovered = activeIndex == index;

                return AnimatedScale(
                  scale: isHovered ? 1.05 : 1.0,
                  duration: const Duration(milliseconds: 180),
                  curve: Curves.easeOutBack,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    curve: Curves.easeOutBack,
                    height: itemHeight - 4,
                    margin: EdgeInsets.symmetric(horizontal: isHovered ? 4 : 12, vertical: 2),
                    decoration: BoxDecoration(
                      color: isHovered ? Colors.white : Colors.transparent,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(color: isHovered ? Colors.black.withOpacity(0.08) : Colors.transparent, blurRadius: 16, spreadRadius: 1, offset: const Offset(0, 8)),
                      ],
                    ),
                    child: GestureDetector(
                      onTap: () => _navigateToPage(item['title']),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: (isHovered || index == menuItems.length - 1) ? Colors.transparent : Colors.grey.withOpacity(0.08), width: 1)),
                        ),
                        child: Row(
                          children: [
                            Icon(item['icon'], size: 20, color: isHovered ? Colors.black : Colors.black54),
                            const SizedBox(width: 16),
                            Text(item['title'], style: TextStyle(fontSize: 14, fontWeight: isHovered ? FontWeight.w600 : FontWeight.w400, color: isHovered ? Colors.black : Colors.black87)),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

// کلاس‌های فرعی متصل به گزینه‌ها
class InviteFriendsScreen extends StatelessWidget { const InviteFriendsScreen({super.key}); @override Widget build(BuildContext context) { return Scaffold(appBar: AppBar(title: const Text('دعوت از دوستان'), centerTitle: true), body: const Center(child: Text('کد معرف شما: SAFIR-50'))); } }
class MessagesScreen extends StatelessWidget { const MessagesScreen({super.key}); @override Widget build(BuildContext context) { return Scaffold(appBar: AppBar(title: const Text('پیام‌ها'), centerTitle: true), body: const Center(child: Text('صندوق پیام‌ها خالی است.'))); } }
class DiscountCodeScreen extends StatelessWidget { const DiscountCodeScreen({super.key}); @override Widget build(BuildContext context) { return Scaffold(appBar: AppBar(title: const Text('کدهای تخفیف'), centerTitle: true), body: const Center(child: Text('کد تخفیف فعالی ندارید.'))); } }
class BinShahriScreen extends StatelessWidget { const BinShahriScreen({super.key}); @override Widget build(BuildContext context) { return Scaffold(appBar: AppBar(title: const Text('سفر بین شهری'), centerTitle: true), body: const Center(child: Text('سرویس بین ولایات به‌زودی...'))); } }
class BarbariScreen extends StatelessWidget { const BarbariScreen({super.key}); @override Widget build(BuildContext context) { return Scaffold(appBar: AppBar(title: const Text('باربری سفیر'), centerTitle: true), body: const Center(child: Text('سرویس باربری به‌زودی...'))); } }
class RegistrationScreen extends StatelessWidget { const RegistrationScreen({super.key}); @override Widget build(BuildContext context) { return Scaffold(appBar: AppBar(title: const Text('ثبت‌نام رانندگان'), centerTitle: true), body: const Center(child: Text('فرم ثبت‌نام رانندگان به‌زودی...'))); } }
