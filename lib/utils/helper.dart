import 'package:flutter/material.dart';

String tr(BuildContext context, String key) {
  String lang = Localizations.localeOf(context).languageCode;

  final Map<String, Map<String, String>> words = {
    // --- عمومی و منوها ---
    'app_name': {'fa': 'سفیر', 'ps': 'سفیر', 'en': 'Safir'},
    'home': {'fa': 'صفحه اصلی', 'ps': 'اصلي صفحه', 'en': 'Home'},
    'settings': {'fa': 'تنظیمات', 'ps': 'تنظیمات', 'en': 'Settings'},
    'profile': {'fa': 'پروفایل', 'ps': 'پروفایل', 'en': 'Profile'},
    'support': {'fa': 'پشتیبانی', 'ps': 'ملاتړ', 'en': 'Support'},
    'exit': {'fa': 'خروج', 'ps': 'وتل', 'en': 'Logout'},
    'confirm': {'fa': 'تایید', 'ps': 'تایید', 'en': 'Confirm'},
    'cancel': {'fa': 'لغو', 'ps': 'لغوه', 'en': 'Cancel'},

    // --- بخش مسافر و سفر ---
    'where_to': {'fa': 'کجا می‌روید؟', 'ps': 'چیرته ځئ؟', 'en': 'Where to?'},
    'search': {'fa': 'جستجو', 'ps': 'پلټنه', 'en': 'Search'},
    'request_ride': {'fa': 'درخواست سفر', 'ps': 'د سفر غوښتنه', 'en': 'Request Ride'},
    'finding_driver': {'fa': 'در حال جستجوی سفیر...', 'ps': 'د سفیر لټون...', 'en': 'Finding Safir...'},
    'fare': {'fa': 'کرایه', 'ps': 'کرایه', 'en': 'Fare'},
    'afn': {'fa': 'افغانی', 'ps': 'افغانۍ', 'en': 'AFN'},

    // --- ثبت‌نام راننده (سفیر) ---
    'reg_title': {'fa': 'ثبت‌نام سفیر جدید', 'ps': 'د نوي سفیر نوم لیکنه', 'en': 'New Driver Registration'},
    'full_name': {'fa': 'نام و نام خانوادگی', 'ps': 'بشپړ نوم', 'en': 'Full Name'},
    'phone': {'fa': 'شماره تماس', 'ps': 'د اړیکې شمیره', 'en': 'Phone Number'},
    'id_card': {'fa': 'نمبر تذکره', 'ps': 'د تذکرې شمیره', 'en': 'ID Card Number'},
    'vehicle_info': {'fa': 'مشخصات موتر', 'ps': 'د موټر مشخصات', 'en': 'Vehicle Info'},
    'upload_doc': {'fa': 'آپلود مدارک', 'ps': 'اسناد اپلوډ کړئ', 'en': 'Upload Documents'},

    // --- باربری (Cargo) ---
    'cargo_title': {'fa': 'سفیر باربر', 'ps': 'بار وړونکی سفیر', 'en': 'Safir Cargo'},
    'cargo_type': {'fa': 'نوع بار', 'ps': 'د بار ډول', 'en': 'Cargo Type'},
    'weight': {'fa': 'وزن (تُن)', 'ps': 'وزن (ټن)', 'en': 'Weight (Tons)'},
    'intra_city': {'fa': 'داخل شهری', 'ps': 'د ښار دننه', 'en': 'Intra-city'},

    // --- سفر بین‌شهری (Intercity) ---
    'intercity_title': {'fa': 'سفر بین‌شهری', 'ps': 'د ښارونو ترمنځ سفر', 'en': 'Intercity Travel'},
    'origin_city': {'fa': 'ولایت مبدأ', 'ps': 'د پیل ولایت', 'en': 'Origin City'},
    'dest_city': {'fa': 'ولایت مقصد', 'ps': 'د منزل ولایت', 'en': 'Destination City'},
    'passengers_count': {'fa': 'تعداد مسافرین', 'ps': 'د سپرلیو شمیر', 'en': 'Passengers Count'},
    
    // --- داشبورد مدیریت (Admin/Status) ---
    'total_earned': {'fa': 'مجموع درآمد', 'ps': 'ټوله ګټه', 'en': 'Total Earned'},
    'active_rides': {'fa': 'سفرهای فعال', 'ps': 'فعال سفرونه', 'en': 'Active Rides'},
    'pending_approval': {'fa': 'در انتظار تایید', 'ps': 'تایید ته انتظار', 'en': 'Pending Approval'},
  };

  return words[key]?[lang] ?? key;
}
