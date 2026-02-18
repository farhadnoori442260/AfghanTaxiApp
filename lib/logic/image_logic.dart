import 'dart:io';
import 'dart:convert';
import 'package:image/image.dart' as img;

class ImageLogic {
  // فشرده‌سازی و تبدیل به متن برای دور زدن مشکل استوریج
  Future<String?> processAndConvert(File file) async {
    try {
      // ۱. خواندن فایل اصلی
      final bytes = await file.readAsBytes();
      final image = img.decodeImage(bytes);

      if (image == null) return null;

      // ۲. فشرده‌سازی تصویر برای اینکه دیتابیس سنگین نشود (کیفیت ۸۰٪)
      final compressedBytes = img.encodeJpg(image, quality: 80);
      
      // ۳. تبدیل به متن Base64
      String base64String = base64Encode(compressedBytes);
      
      return "data:image/jpeg;base64,$base64String";
    } catch (e) {
      print("خطا در پردازش تصویر سفیر: $e");
      return null;
    }
  }
}