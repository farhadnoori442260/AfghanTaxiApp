import 'package:flutter/material.dart';
import 'utlis/colors.dart';
import 'profile_screen.dart';

class SafirMapScreen extends StatefulWidget {
  final String serviceType;
  const SafirMapScreen({super.key, required this.serviceType});

  @override
  State<SafirMapScreen> createState() => _SafirMapScreenState();
}

class _SafirMapScreenState extends State<SafirMapScreen> {
  int _selectedCategory = 0; 
  int _selectedVehicleType = 0; 
  int _currentStep = 0; 
  String _travelFor = 'برای خودم'; // متغیر جدید برای انتخاب مسافر

  final String _originAddress = 'چهارراهی صدارت، کابل';
  final String _destinationAddress = 'چهارراهی کلوله پشته، کابل';

  void _showAdvancedProfile() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent, 
      elevation: 0,
      barrierColor: Colors.black.withOpacity(0.22), 
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 24), 
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const ProfileAnimatedMenu(), 
              ],
            ),
          ),
        );
      },
    );
  }

  // اضافه شدن دکمه برگشت هوشمند به متد ساخت آدرس
  Widget _buildAddressField(String text, IconData icon, Color iconColor, VoidCallback onBackPress, IconData backIcon) {
    return Container(
      width: double.infinity, 
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(color: const Color(0xFFF3F4F6), borderRadius: BorderRadius.circular(14)),
      child: Row(
        children: [
          // دکمه فلش برگشتی یا هوم در کنار آدرس
          IconButton(
            icon: Icon(backIcon, color: SafirColors.primaryGreen, size: 24),
            onPressed: onBackPress,
          ),
          const SizedBox(width: 4),
          Icon(icon, color: iconColor, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(text, style: const TextStyle(color: SafirColors.primaryGreen, fontSize: 14, fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis)),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButton(String label, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity, height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: SafirColors.primaryGreen, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
        onPressed: onPressed,
        child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildCategoryTab(int categoryIndex, String label) {
    bool isCategorySelected = _selectedCategory == categoryIndex;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() { _selectedCategory = categoryIndex; _selectedVehicleType = 0; }),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: isCategorySelected ? SafirColors.primaryGreen : Colors.transparent, width: 2))),
          child: Text(label, textAlign: TextAlign.center, style: TextStyle(color: isCategorySelected ? SafirColors.primaryGreen : Colors.grey, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  Widget _buildHorizontalVehicleOption(int index, IconData icon, String title, String subtitle, String price) {
    bool isSelected = _selectedVehicleType == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedVehicleType = index),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? SafirColors.primaryGreen.withOpacity(0.05) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isSelected ? SafirColors.primaryGreen : Colors.grey.withOpacity(0.2)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(price, style: const TextStyle(fontWeight: FontWeight.bold)),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(subtitle, style: const TextStyle(fontSize: 10, color: Colors.grey)),
                  ],
                ),
                const SizedBox(width: 10),
                Icon(icon, color: SafirColors.primaryGreen),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Stack(
          children: [
            // بخش لایه نقشه شبیه‌سازی شده شما
            Container(
              color: const Color(0xFFE8ECE9), 
              child: Stack(
                children: [
                  Positioned(top: 200, left: -50, child: Container(width: 500, height: 40, color: Colors.white)),
                  Positioned(top: 450, left: -50, child: Container(width: 500, height: 40, color: Colors.white)),
                  Positioned(top: -50, left: 100, child: Container(width: 40, height: 900, color: Colors.white)),
                  Positioned(top: -50, left: 280, child: Container(width: 40, height: 900, color: Colors.white)),
                  if (_currentStep >= 2) ...[
                    Positioned(top: 220, left: 120, child: Container(width: 180, height: 8, color: Colors.green.shade600)),
                    Positioned(top: 220, left: 280, child: Container(width: 8, height: 250, color: Colors.green.shade600)),
                    Positioned(
                      top: 205, left: 105,
                      child: Column(
                        children: [
                          Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: SafirColors.primaryGreen, borderRadius: BorderRadius.circular(4)), child: const Text('مبدأ', style: TextStyle(color: Colors.white, fontSize: 10))),
                          const Icon(Icons.location_on, color: SafirColors.primaryGreen, size: 36),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 440, left: 266,
                      child: Column(
                        children: [
                          Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.red.shade700, borderRadius: BorderRadius.circular(4)), child: const Text('مقصد', style: TextStyle(color: Colors.white, fontSize: 10))),
                          Icon(Icons.location_on, color: Colors.red.shade700, size: 36),
                        ],
                      ),
                    ),
                    Positioned(top: 310, left: 110, child: Icon(Icons.local_taxi, color: SafirColors.primaryGreen.withOpacity(0.6), size: 24)),
                    Positioned(top: 455, left: 40, child: const Icon(Icons.motorcycle, color: Colors.orange, size: 24)),
                  ],
                ],
              ),
            ),
            if (_currentStep == 0 || _currentStep == 1)
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 40), 
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(8)),
                        child: Text(_currentStep == 0 ? 'محل مبدأ سفر' : 'محل مقصد سفر', style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(height: 4),
                      Icon(Icons.location_on, size: 50, color: _currentStep == 0 ? SafirColors.primaryGreen : Colors.red.shade700),
                    ],
                  ),
                ),
              ),
              
            // ۲. آیکون‌های بالا (انتقال به بالاترین بخش صفحه و اضافه شدن منوی بازشونده)
            Positioned(
              top: 25, left: 20, right: 20, // مقدار top از 50 به 25 کاهش یافت تا بالاتر برود ✅
              child: SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FloatingActionButton(heroTag: 'profile_btn', mini: true, backgroundColor: Colors.white, onPressed: _showAdvancedProfile, child: const Icon(Icons.person, color: SafirColors.primaryGreen)),
                    if (_currentStep < 2)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)]),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _travelFor,
                            icon: const Icon(Icons.keyboard_arrow_down, size: 18, color: Colors.black87),
                            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87, fontFamily: 'Vazir'),
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                setState(() {
                                  _travelFor = newValue;
                                });
                              }
                            },
                            items: <String>['برای خودم', 'برای دیگران'].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    FloatingActionButton(heroTag: 'home_btn', mini: true, backgroundColor: Colors.white, onPressed: () => Navigator.pop(context), child: const Icon(Icons.home, color: SafirColors.primaryGreen)),
                  ],
                ),
              ),
            ),
            
            // باکس پایین صفحه (بدون به‌هم‌ریختگی و همراه با فلش بازگشت هوشمند)
            Positioned(
              bottom: 0, left: 0, right: 0,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)), boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 1)]),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_currentStep == 0) ...[
                      // در مبدأ، دکمه به شکل هوم عمل می‌کند و خارج می‌شود
                      _buildAddressField(_originAddress, Icons.circle, SafirColors.primaryGreen, () => Navigator.pop(context), Icons.home),
                      const SizedBox(height: 12),
                      ListTile(dense: true, leading: const Icon(Icons.history, color: Colors.grey), title: const Text('شهر نو، نزدیک پارک', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)), subtitle: const Text('کابل، افغانستان', style: TextStyle(fontSize: 11)), onTap: () {}),
                      Divider(height: 1, color: Colors.grey.withOpacity(0.1)),
                      ListTile(dense: true, leading: const Icon(Icons.star_border, color: Colors.grey), title: const Text('وزیر اکبرخان، سرک ۱۵', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)), onTap: () {}),
                      const SizedBox(height: 12),
                      _buildBottomButton('تایید مبدأ و ادامه', () => setState(() => _currentStep = 1)),
                    ],
                    if (_currentStep == 1) ...[
                      // در مقصد، دکمه به شکل فلش برگشت است و به مبدأ (_currentStep = 0) برمی‌گرداند
                      _buildAddressField(_destinationAddress, Icons.location_on, Colors.red, () => setState(() => _currentStep = 0), Icons.arrow_back),
                      const SizedBox(height: 12),
                      ListTile(dense: true, leading: const Icon(Icons.location_city, color: Colors.grey), title: const Text('کارته چهار، پوهنتون کابل', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)), onTap: () {}),
                      const SizedBox(height: 16),
                      _buildBottomButton('تایید مقصد و مشاهده قیمت', () => setState(() => _currentStep = 2)),
                    ],
                    if (_currentStep == 2) ...[
                      // قبل از انتخاب نوع سرویس، یک دکمه کوچک برای برگشت به انتخاب مقصد قرار دادیم
                      Align(
                        alignment: Alignment.topRight,
                        child: TextButton.icon(
                          onPressed: () => setState(() => _currentStep = 1),
                          icon: const Icon(Icons.arrow_back, color: SafirColors.primaryGreen, size: 18),
                          label: const Text('تغییر مقصد', style: TextStyle(color: SafirColors.primaryGreen, fontSize: 12, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      Row(
                        children: [
                          _buildCategoryTab(1, 'موترسایکل'),
                          _buildCategoryTab(0, 'موتر'),
                        ],
                      ),
                      const SizedBox(height: 12),
                      if (_selectedCategory == 0) ...[
                        _buildHorizontalVehicleOption(0, Icons.local_taxi, 'سفِیر اقتصادی', 'ارزان و سریع', '۱۲۰ افغانی'),
                        const SizedBox(height: 8),
                        _buildHorizontalVehicleOption(1, Icons.electric_car, 'سفِیر ویژه', 'لوکس و راحت', '۱۸۰ افغانی'),
                      ] else ...[
                        _buildHorizontalVehicleOption(0, Icons.motorcycle, 'سفِیر موتور', 'عبور از ترافیک', '۶۰ افغانی'),
                      ],
                      const SizedBox(height: 12),
                      _buildBottomButton('درخواست سفیر', () => setState(() => _currentStep = 3)),
                    ],
                    if (_currentStep == 3) ...[
                      const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(SafirColors.primaryGreen)),
                      const SizedBox(height: 15),
                      const Text('در حال ارسال درخواست به راننده‌ها...', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 15),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                          onPressed: () => setState(() => _currentStep = 2),
                          child: const Text('لغو درخواست', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                        ),
                      )
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
