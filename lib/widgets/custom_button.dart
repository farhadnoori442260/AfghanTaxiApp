import 'package:flutter/material.dart';
import '../utils/helper.dart'; // اضافه شدن برای مدیریت زبان
import '../utils/colors.dart';

class CustomButton extends StatelessWidget {
  final String textKey; // تغییر نام به textKey برای اشاره به کلیدهای helper
  final VoidCallback onPressed;
  final Color? color;
  final Color textColor;
  final double radius;
  final bool isLoading; // قابلیت جدید برای نمایش وضعیت بارگذاری

  const CustomButton({
    Key? key,
    required this.textKey,
    required this.onPressed,
    this.color,
    this.textColor = Colors.white,
    this.radius = 18.0,
    this.isLoading = false, // پیش‌فرض بارگذاری غیرفعال است
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? SafirColors.primaryGreen,
          foregroundColor: textColor,
          elevation: 2,
          shadowColor: (color ?? SafirColors.primaryGreen).withOpacity(0.4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        // اگر در حال بارگذاری بود، دکمه غیرفعال می‌شود
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Text(
                tr(context, textKey), // ترجمه متن با استفاده از کلید
                style: const TextStyle(
                  fontFamily: 'IranYekan',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
}
