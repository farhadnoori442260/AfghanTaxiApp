import 'dart:io';
import 'dart:convert';

class StorageService {
  // این متد عکس را برای ادمین سفیر آماده می‌کند
  Future<String?> processImageForAdmin(File file) async {
    try {
      // ۱. خواندن فایل
      List<int> imageBytes = await file.readAsBytes();
      
      // ۲. تبدیل به متن (Base64)
      String base64Image = base64Encode(imageBytes);
      
      // ۳. فرمت‌بندی برای اینکه در پنل مدیریت مستقیم به شکل عکس باز شود
      return "data:image/jpeg;base64,$base64Image";
    } catch (e) {
      print("خطا در پردازش تصویر مدارک: $e");
      return null;
    }
  }
}
