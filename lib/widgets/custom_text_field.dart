import 'package:flutter/material.dart';
import '../utils/helper.dart'; // برای مدیریت زبان سه‌گانه
import '../utils/colors.dart';

class CustomTextField extends StatelessWidget {
  final String hintKey; // استفاده از کلید ترجمه به جای متن مستقیم
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final IconData? prefixIcon;
  final String? Function(String?)? validator; // اضافه شدن قابلیت اعتبارسنجی
  final int? maxLength;

  const CustomTextField({
    Key? key,
    required this.hintKey,
    required this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.validator,
    this.maxLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      maxLength: maxLength,
      style: const TextStyle(fontFamily: 'IranYekan', fontSize: 15),
      decoration: InputDecoration(
        hintText: tr(context, hintKey), // ترجمه خودکار متن راهنما
        prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: SafirColors.primaryGreen) : null,
        filled: true,
        fillColor: Colors.grey[100], // پس‌زمینه ملایم برای خوانایی بهتر
        counterText: "", // مخفی کردن شمارنده حروف در صورت نیاز
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15), // هماهنگی با شعاع دکمه‌ها
          borderSide: BorderSide.none, // حذف خط دور در حالت عادی برای ظاهر مدرن‌تر
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: SafirColors.primaryGreen, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.red, width: 1),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      ),
    );
  }
}
