import 'package:flutter/material.dart';
import '../utils/helper.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';

class IntercityScreen extends StatefulWidget {
  const IntercityScreen({super.key});

  @override
  State<IntercityScreen> createState() => _IntercityScreenState();
}

class _IntercityScreenState extends State<IntercityScreen> {
  String? fromCity;
  String? toCity;
  DateTime? selectedDate;
  final List<String> _provinces = ['kabul', 'herat', 'mazar', 'kandahar', 'jalalabad', 'kunduz'];

  // تابع برای انتخاب تاریخ از تقویم گوشی
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2027),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tr(context, 'intercity_title'))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // انتخاب مبدأ
            _buildDropdown(tr(context, 'origin_city'), fromCity, (val) => setState(() => fromCity = val)),
            const SizedBox(height: 15),

            // انتخاب مقصد
            _buildDropdown(tr(context, 'dest_city'), toCity, (val) => setState(() => toCity = val)),
            const SizedBox(height: 15),

            // انتخاب تاریخ (بصری و شیک)
            GestureDetector(
              onTap: () => _selectDate(context),
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(selectedDate == null 
                      ? tr(context, 'select_date') 
                      : "${selectedDate!.year}/${selectedDate!.month}/${selectedDate!.day}"),
                    const Icon(Icons.calendar_month, color: Colors.blue),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),

            // تعداد مسافرین
            CustomTextField(
              hintText: tr(context, 'passengers_count'),
              controller: TextEditingController(),
              keyboardType: TextInputType.number,
              prefixIcon: Icons.people,
            ),
            const SizedBox(height: 30),

            // دکمه جستجو
            CustomButton(
              text: tr(context, 'search_rides'),
              onPressed: () {
                // اینجا منطق پیدا کردن موترهای بین‌شهری را می‌نویسیم
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(String hint, String? value, Function(String?) onChanged) {
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
          items: _provinces.map((city) => DropdownMenuItem(value: city, child: Text(tr(context, city)))).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
