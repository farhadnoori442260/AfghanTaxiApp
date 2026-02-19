import 'package:flutter/material.dart';
import '../utils/helper.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';

class IntercityScreen extends StatelessWidget {
  const IntercityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tr(context, 'intercity_title'))),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CustomTextField(
              hintText: tr(context, 'origin_city'),
              controller: TextEditingController(),
              prefixIcon: Icons.location_on,
            ),
            const SizedBox(height: 15),
            CustomTextField(
              hintText: tr(context, 'dest_city'),
              controller: TextEditingController(),
              prefixIcon: Icons.flag,
            ),
            const SizedBox(height: 30),
            CustomButton(
              text: tr(context, 'search'),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
