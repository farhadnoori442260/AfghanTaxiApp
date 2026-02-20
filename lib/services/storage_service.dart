import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import '../utils/helper.dart';

class StorageService {
  // این متد عکس را پردازش و حجم آن را کنترل می‌کند
  Future<String?> processImageForAdmin(BuildContext context, File file) async {
    try {
      // ۱. چک کردن حجم فایل (مثلاً حداکثر ۲ مگابایت برای بهینه‌سازی دیتابیس)
      int fileSizeInBytes = await file.length();
      double fileSizeInMB = fileSizeInBytes / (1024 * 1024);

      if (fileSizeInMB > 2.0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(tr(context, 'image_too_large'))),
        );
        return null;
      }

      // ۲. خواندن و تبدیل به Base64
      List<int> imageBytes = await file.readAsBytes();
      String base64Image = base64Encode(imageBytes);
      
      // ۳. فرمت‌بندی استاندارد برای نمایش در وب یا اپلیکیشن مدیریت سفیر
      return "data:image/jpeg;base64,$base64Image";
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(tr(context, 'error_processing_image'))),
      );
      return null;
    }
  }
}
