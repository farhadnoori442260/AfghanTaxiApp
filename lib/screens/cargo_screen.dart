import 'package:flutter/material.dart';
import '../utils/helper.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';

class CargoScreen extends StatelessWidget {
  const CargoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tr(context, 'cargo_title'))),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CustomTextField(
              hintText: tr(context, 'cargo_type'),
              controller: TextEditingController(),
              prefixIcon: Icons.local_shipping,
            ),
            const SizedBox(height: 15),
            CustomTextField(
              hintText: tr(context, 'weight'),
              controller: TextEditingController(),
              keyboardType: TextInputType.number,
              prefixIcon: Icons.line_weight,
            ),
            const SizedBox(height: 30),
            CustomButton(
              text: tr(context, 'request_ride'),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
