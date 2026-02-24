import 'package:flutter/material.dart';
import '../utils/colors.dart';

class SafirTextField extends StatelessWidget {
  final String label;
  final String hint;
  final IconData icon;
  final bool isNumber;

  const SafirTextField({
    super.key, 
    required this.label, 
    required this.hint, 
    required this.icon, 
    this.isNumber = false
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: Icon(icon, color: SafirColors.primaryGreen),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}
