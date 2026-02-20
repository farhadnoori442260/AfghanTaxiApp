import 'package:flutter/material.dart';
import '../utils/helper.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';

class DriverRegScreen extends StatefulWidget {
  const DriverRegScreen({super.key});

  @override
  State<DriverRegScreen> createState() => _DriverRegScreenState();
}

class _DriverRegScreenState extends State<DriverRegScreen> {
  int _currentStep = 0;
  
  // متغیرهای ذخیره انتخاب کاربر
  String? selectedCity;
  String? selectedVehicle;

  // ۱. لیست ولایات برای دراپ‌دان
  final List<String> _provinces = ['kabul', 'herat', 'mazar', 'kandahar', 'jalalabad', 'kunduz'];
  
  // ۲. لیست وسایل نقلیه برای دراپ‌دان
  final List<String> _vehicles = ['safir_taxi', 'safir_cargo', 'safir_bike'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tr(context, 'reg_title'))),
      body: Theme(
        // سفارشی‌سازی رنگ استپر برای برند سفیر
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(primary: Colors.blue),
        ),
        child: Stepper(
          type: StepperType.horizontal,
          currentStep: _currentStep,
          onStepContinue: () {
            if (_currentStep < 3) setState(() => _currentStep += 1);
          },
          onStepCancel: () {
            if (_currentStep > 0) setState(() => _currentStep -= 1);
          },
          controlsBuilder: (context, details) {
            return Padding(
              padding: const EdgeInsets.only(top: 30),
              child: CustomButton(
                text: tr(context, 'next_step'),
                onPressed: details.onStepContinue,
              ),
            );
          },
          steps: [
            // مرحله ۱: مشخصات (مطابق اسکرین‌شاتی که فرستادی)
            Step(
              isActive: _currentStep >= 0,
              title: const Text(""),
              content: Column(
                children: [
                  _buildDropdown(
                    hint: tr(context, 'vehicle_type'),
                    value: selectedVehicle,
                    items: _vehicles,
                    onChanged: (val) => setState(() => selectedVehicle = val),
                  ),
                  const SizedBox(height: 15),
                  _buildDropdown(
                    hint: tr(context, 'city_activity'),
                    value: selectedCity,
                    items: _provinces,
                    onChanged: (val) => setState(() => selectedCity = val),
                  ),
                  const SizedBox(height: 15),
                  CustomTextField(hintText: tr(context, 'id_card'), controller: TextEditingController()),
                  const SizedBox(height: 15),
                  CustomTextField(hintText: tr(context, 'father_name'), controller: TextEditingController()),
                  const SizedBox(height: 15),
                  CustomTextField(hintText: tr(context, 'referral_code'), controller: TextEditingController()),
                ],
              ),
            ),
            // مرحله ۲: بارگذاری مدارک
            Step(
              isActive: _currentStep >= 1,
              title: const Text(""),
              content: _buildUploadSection(),
            ),
            // مرحله ۳: احراز هویت
            Step(isActive: _currentStep >= 2, title: const Text(""), content: const Center(child: Icon(Icons.verified_user, size: 100, color: Colors.orange))),
            // مرحله ۴: قرارداد
            Step(isActive: _currentStep >= 3, title: const Text(""), content: const Center(child: Icon(Icons.Assignment, size: 100, color: Colors.blue))),
          ],
        ),
      ),
    );
  }

  // ویجت دراپ‌دان عمومی برای استفاده در کل صفحه
  Widget _buildDropdown({required String hint, String? value, required List<String> items, required Function(String?) onChanged}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          hint: Text(hint),
          value: value,
          items: items.map((key) => DropdownMenuItem(value: key, child: Text(tr(context, key)))).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  // ویجت بخش آپلود مدارک برای مرحله دوم
  Widget _buildUploadSection() {
    return Column(
      children: [
        const Icon(Icons.cloud_upload, size: 60, color: Colors.grey),
        const SizedBox(height: 10),
        Text(tr(context, 'upload_doc')),
      ],
    );
  }
}
