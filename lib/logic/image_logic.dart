import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import '../utils/helper.dart';

class ImageLogic {
  // فشرده‌سازی و تبدیل به متن برای بهینه‌سازی دیتابیس سفیر
  Future<String?> processAndConvert(BuildContext context, File file) async {
    try {
      // ۱. خواندن فایل اصلی
      final bytes = await file.readAsBytes();
      final image = img.decodeImage(bytes);

      if (image == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(tr(context, 'invalid_image_format'))),
        );
        return null;
      }

      // ۲. فشرده‌سازی هوشمند (کیفیت ۸۰٪ برای تعادل بین وضوح و حجم)
      final compressedBytes = img.encodeJpg(image, quality: 80);
      
      // ۳. تبدیل به متن Base64 برای ذخیره‌سازی سریع
      String base64String = base64Encode(compressedBytes);
      
      return "data:image/jpeg;base64,$base64String";
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(tr(context, 'error_processing_image'))),
      );
      return null;
    }
  }
}
