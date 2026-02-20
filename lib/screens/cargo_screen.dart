import 'package:flutter/material.dart';
import '../utils/helper.dart';
import '../utils/colors.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';

class CargoScreen extends StatefulWidget {
  const CargoScreen({super.key});

  @override
  State<CargoScreen> createState() => _CargoScreenState();
}

class _CargoScreenState extends State<CargoScreen> {
  String? selectedCargoType;
  bool needsLoader = false; // نیاز به کارگر

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tr(context, 'cargo_title'))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ۱. انتخاب نوع بار
            _buildSectionTitle(tr(context, 'cargo_type')),
            CustomTextField(
              hintText: "مثلاً: وسایل منزل یا میوه جات",
              controller: TextEditingController(),
              prefixIcon: Icons.category_outlined,
            ),
            const SizedBox(height: 20),

            // ۲. وزن بار
            _buildSectionTitle(tr(context, 'weight')),
            CustomTextField(
              hintText: tr(context, 'weight'),
              controller: TextEditingController(),
              keyboardType: TextInputType.number,
              prefixIcon: Icons.scale_outlined,
            ),
            const SizedBox(height: 20),

            // ۳. آپشن کارگر (Switch)
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("نیاز به کارگر برای بارگیری؟", style: TextStyle(fontWeight: FontWeight.bold)),
                  Switch(
                    value: needsLoader,
                    onChanged: (val) => setState(() => needsLoader = val),
                    activeColor: SafirColors.primaryGreen,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // ۴. دکمه درخواست سفیر باربر
            CustomButton(
              text: tr(context, 'request_ride'),
              onPressed: () {
                // منطق محاسبه قیمت باربری بر اساس وزن و فاصله
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, right: 5),
      child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
    );
  }
}
