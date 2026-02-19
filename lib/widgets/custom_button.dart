import 'package:flutter/material.dart';
import '../utils/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? color; // اجازه می‌دهیم مقدار پیش‌فرض را از تم بگیرد
  final Color textColor;
  final double radius;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color, // اگر رنگ پاس داده نشود، سبز سفیری استفاده می‌شود
    this.textColor = Colors.white,
    this.radius = 18.0, // لبه‌های گردتر برای حس مدرن بودن
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // دکمه‌ها در اپلیکیشن سفیر معمولاً تمام‌عرض هستند
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? SafirColors.primaryGreen,
          foregroundColor: textColor,
          elevation: 2, // سایه ملایم برای ایجاد عمق
          shadowColor: (color ?? SafirColors.primaryGreen).withOpacity(0.4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16), // پدینگ عمودی بیشتر برای راحتی لمس
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            fontFamily: 'IranYekan', // هماهنگی با فونت اصلی پروژه
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
