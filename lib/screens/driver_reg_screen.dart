import 'package:flutter/material.dart';
import '../utils/helper.dart'; // برای ترجمه
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';

class DriverRegScreen extends StatelessWidget {
  const DriverRegScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tr(context, 'reg_title'))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CustomTextField(
              hintText: tr(context, 'full_name'),
              controller: TextEditingController(),
              prefixIcon: Icons.person,
            ),
            const SizedBox(height: 15),
            CustomTextField(
              hintText: tr(context, 'id_card'),
              controller: TextEditingController(),
              prefixIcon: Icons.badge,
            ),
            const SizedBox(height: 30),
            CustomButton(
              text: tr(context, 'confirm'),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
