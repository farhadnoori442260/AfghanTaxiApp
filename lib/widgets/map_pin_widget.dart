import 'package:flutter/material.dart';
import '../utils/helper.dart';

class MapPinWidget extends StatelessWidget {
  final String labelKey; // استفاده از کلید ترجمه برای نام مکان (مبدأ یا مقصد)
  final Color color;

  const MapPinWidget({
    Key? key,
    required this.labelKey,
    this.color = Colors.red,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // حباب بالای پین برای خوانایی بیشتر متن
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2))
            ],
          ),
          child: Text(
            tr(context, labelKey), // ترجمه سه‌زبانه برچسب پین
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              fontFamily: 'IranYekan',
              color: Colors.black87,
            ),
          ),
        ),
        // آیکون پین لوکیشن
        Icon(
          Icons.location_on, // استفاده از نسخه توپر برای وضوح بهتر
          color: color,
          size: 40,
        ),
      ],
    );
  }
}
