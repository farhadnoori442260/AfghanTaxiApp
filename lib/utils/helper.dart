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
    'next_step': {'fa': 'تایید و ادامه', 'ps': 'تایید او دوام', 'en': 'Confirm & Continue'},

    // --- بخش مسافر و سفر ---
    'where_to': {'fa': 'کجا می‌روید؟', 'ps': 'چیرته ځئ؟', 'en': 'Where to?'},
    'search': {'fa': 'جستجو', 'ps': 'پلټنه', 'en': 'Search'},
    'request_ride': {'fa': 'درخواست سفر', 'ps': 'د سفر غوښتنه', 'en': 'Request Ride'},
    'finding_driver': {'fa': 'در حال جستجوی سفیر...', 'ps': 'د سفیر لټون...', 'en': 'Finding Safir...'},
    'fare': {'fa': 'کرایه', 'ps': 'کرایه', 'en': 'Fare'},
    'afn': {'fa': 'افغانی', 'ps': 'افغانۍ', 'en': 'AFN'},

    // --- ثبت‌نام راننده ---
    'reg_title': {'fa': 'ثبت‌نام سفیر جدید', 'ps': 'د نوي سفیر نوم لیکنه', 'en': 'New Driver Registration'},
    'full_name': {'fa': 'نام و نام خانوادگی', 'ps': 'بشپړ نوم', 'en': 'Full Name'},
    'father_name': {'fa': 'نام پدر', 'ps': 'د پلار نوم', 'en': 'Father\'s Name'},
    'phone': {'fa': 'شماره تماس', 'ps': 'د اړیکې شمیره', 'en': 'Phone Number'},
    'id_card': {'fa': 'نمبر تذکره', 'ps': 'د تذکرې شمیره', 'en': 'ID Card Number'},
    'city_activity': {'fa': 'ولایت محل فعالیت', 'ps': 'د فعالیت ولایت', 'en': 'Working City'},
    'vehicle_type': {'fa': 'نوع وسیله نقلیه', 'ps': 'د واسطې ډول', 'en': 'Vehicle Type'},
    'referral_code': {'fa': 'کد معرف (اختیاری)', 'ps': 'د پیژندنې کوډ', 'en': 'Referral Code'},
    'upload_doc': {'fa': 'بارگذاری مدارک', 'ps': 'اسناد اپلوډ کړئ', 'en': 'Upload Documents'},

    // --- ولایات افغانستان ---
    'kabul': {'fa': 'کابل', 'ps': 'کابل', 'en': 'Kabul'},
    'herat': {'fa': 'هرات', 'ps': 'هرات', 'en': 'Herat'},
    'mazar': {'fa': 'مزار شریف', 'ps': 'مزار شریف', 'en': 'Mazar-i-Sharif'},
    'kandahar': {'fa': 'قندهار', 'ps': 'کندهار', 'en': 'Kandahar'},
    'jalalabad': {'fa': 'جلال‌آباد', 'ps': 'جلال‌اباد', 'en': 'Jalalabad'},
    'kunduz': {'fa': 'کندز', 'ps': 'کندز', 'en': 'Kunduz'},

    // --- وسایل نقلیه ---
    'safir_taxi': {'fa': 'سفیر سواری', 'ps': 'سوارلۍ سفیر', 'en': 'Safir Taxi'},
    'safir_cargo': {'fa': 'سفیر باربر', 'ps': 'بار وړونکی سفیر', 'en': 'Safir Cargo'},
    'safir_bike': {'fa': 'سفیر سریع (موتور)', 'ps': 'چټک سفیر', 'en': 'Safir Bike'},

    // --- باربری و بین‌شهری ---
    'cargo_title': {'fa': 'سفیر باربر', 'ps': 'بار وړونکی سفیر', 'en': 'Safir Cargo'},
    'cargo_type': {'fa': 'نوع بار', 'ps': 'د بار ډول', 'en': 'Cargo Type'},
    'weight': {'fa': 'وزن (تُن)', 'ps': 'وزن (ټن)', 'en': 'Weight (Tons)'},
    'intercity_title': {'fa': 'سفر بین‌شهری', 'ps': 'د ښارونو ترمنځ سفر', 'en': 'Intercity Travel'},
    'origin_city': {'fa': 'ولایت مبدأ', 'ps': 'د پیل ولایت', 'en': 'Origin City'},
    'dest_city': {'fa': 'ولایت مقصد', 'ps': 'د منزل ولایت', 'en': 'Destination City'},
    'select_date': {'fa': 'انتخاب تاریخ سفر', 'ps': 'د سفر نیټه غوره کړئ', 'en': 'Select Travel Date'},
    'passengers_count': {'fa': 'تعداد مسافرین', 'ps': 'د سپرلیو شمیر', 'en': 'Passengers Count'},

    // --- بخش جدید: تنظیمات و کرایه ---
    'language_settings': {'fa': 'تنظیمات زبان', 'ps': 'د ژبې تنظیمات', 'en': 'Language Settings'},
    'select_language': {'fa': 'زبان مورد نظر را انتخاب کنید', 'ps': 'خپله ژبه غوره کړئ', 'en': 'Select your language'},
    'calculate_fare': {'fa': 'محاسبه کرایه', 'ps': 'د کرایې محاسبه', 'en': 'Calculate Fare'},
    'total_fare': {'fa': 'کرایه نهایی', 'ps': 'وروستۍ کرایه', 'en': 'Final Fare'},
    'distance': {'fa': 'مسافت (کیلومتر)', 'ps': 'واټن (کیلومتر)', 'en': 'Distance (KM)'},
    
    // --- وضعیت‌ها ---
    'total_earned': {'fa': 'مجموع درآمد', 'ps': 'ټوله ګټه', 'en': 'Total Earned'},
    'active_rides': {'fa': 'سفرهای فعال', 'ps': 'فعال سفرونه', 'en': 'Active Rides'},
  };

  return words[key]?[lang] ?? key;
}
