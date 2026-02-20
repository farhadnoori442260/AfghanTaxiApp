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
    'error_occurred': {'fa': 'خطایی رخ داده است', 'ps': 'تیروتنه رامنځته شوه', 'en': 'An error occurred'},

    // --- بخش مسافر و سفر ---
    'where_to': {'fa': 'کجا می‌روید؟', 'ps': 'چیرته ځئ؟', 'en': 'Where to?'},
    'search': {'fa': 'جستجو', 'ps': 'پلټنه', 'en': 'Search'},
    'request_ride': {'fa': 'درخواست سفر', 'ps': 'د سفر غوښتنه', 'en': 'Request Ride'},
    'finding_driver': {'fa': 'در حال جستجوی سفیر...', 'ps': 'د سفیر لټون...', 'en': 'Finding Safir...'},
    'fare': {'fa': 'کرایه', 'ps': 'کرایه', 'en': 'Fare'},
    'afn': {'fa': 'افغانی', 'ps': 'افغانۍ', 'en': 'AFN'},

    // --- ثبت‌نام راننده و اسناد ---
    'reg_title': {'fa': 'ثبت‌نام سفیر جدید', 'ps': 'د نوي سفیر نوم لیکنه', 'en': 'New Driver Registration'},
    'reg_success': {'fa': 'ثبت‌نام با موفقیت انجام شد', 'ps': 'نوم لیکنه بریالۍ وه', 'en': 'Registration successful'},
    'full_name': {'fa': 'نام و نام خانوادگی', 'ps': 'بشپړ نوم', 'en': 'Full Name'},
    'father_name': {'fa': 'نام پدر', 'ps': 'د پلار نوم', 'en': 'Father\'s Name'},
    'phone': {'fa': 'شماره تماس', 'ps': 'د اړیکې شمیره', 'en': 'Phone Number'},
    'id_card': {'fa': 'نمبر تذکره', 'ps': 'د تذکرې شمیره', 'en': 'ID Card Number'},
    'city_activity': {'fa': 'ولایت محل فعالیت', 'ps': 'د فعالیت ولایت', 'en': 'Working City'},
    'vehicle_type': {'fa': 'نوع وسیله نقلیه', 'ps': 'د واسطې ډول', 'en': 'Vehicle Type'},
    'referral_code': {'fa': 'کد معرف (اختیاری)', 'ps': 'د پیژندنې کوډ', 'en': 'Referral Code'},
    'upload_doc': {'fa': 'بارگذاری مدارک', 'ps': 'اسناد اپلوډ کړئ', 'en': 'Upload Documents'},
    'plate_number': {'fa': 'نمبر پلیت', 'ps': 'د پلیټ شمیره', 'en': 'Plate Number'},
    'image_too_large': {'fa': 'حجم عکس زیاد است (حداکثر ۲ مگ)', 'ps': 'د عکس اندازه لویه ده', 'en': 'Image too large (Max 2MB)'},

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

    // --- وضعیت‌های سفر و سفیر ---
    'searching': {'fa': 'در جستجوی راننده', 'ps': 'د ډرایور په لټه کې', 'en': 'Searching'},
    'accepted': {'fa': 'تایید شده', 'ps': 'تایید شوی', 'en': 'Accepted'},
    'ride_accepted': {'fa': 'سفر با موفقیت قبول شد', 'ps': 'سفر په بریالیتوب سره قبول شو', 'en': 'Ride accepted successfully'},
    'arrived': {'fa': 'سفیر رسید', 'ps': 'سفیر راورسید', 'en': 'Arrived'},
    'started': {'fa': 'سفر آغاز شد', 'ps': 'سفر پیل شو', 'en': 'Started'},
    'completed': {'fa': 'تکمیل شده', 'ps': 'بشپړ شوی', 'en': 'Completed'},
    'ride_completed_success': {'fa': 'سفر با موفقیت به پایان رسید', 'ps': 'سفر په بریالیتوب پای ته ورسید', 'en': 'Ride completed successfully'},
    'cancelled': {'fa': 'لغو شده', 'ps': 'لغوه شوی', 'en': 'Cancelled'},
    'is_approved': {'fa': 'وضعیت تایید', 'ps': 'د تایید حالت', 'en': 'Verification Status'},
    'not_approved': {'fa': 'منتظر تایید', 'ps': 'تایید ته انتظار', 'en': 'Pending'},
    'not_approved_yet': {'fa': 'حساب شما هنوز تایید نشده است', 'ps': 'ستاسو حساب لا نه دی تایید شوی', 'en': 'Account not approved yet'},

    // --- بخش مالی و کیف پول ---
    'total_earned': {'fa': 'مجموع درآمد', 'ps': 'ټوله ګټه', 'en': 'Total Earned'},
    'wallet_balance': {'fa': 'موجودی کیف پول', 'ps': 'د بکس موجودي', 'en': 'Wallet Balance'},
    'payment_method': {'fa': 'روش پرداخت', 'ps': 'د تادیې طریقه', 'en': 'Payment Method'},
    'payment_success': {'fa': 'پرداخت با موفقیت انجام شد', 'ps': 'تادیه په بریالیتوب سره ترسره شوه', 'en': 'Payment successful'},
    'payment_failed': {'fa': 'پرداخت ناموفق بود', 'ps': 'تادیه ناکامه شوه', 'en': 'Payment failed'},
    'wallet_recharged': {'fa': 'کیف پول با موفقیت شارژ شد', 'ps': 'بکس په بریالیتوب سره چارج شو', 'en': 'Wallet recharged successfully'},
    'cash': {'fa': 'نقد', 'ps': 'نغدې', 'en': 'Cash'},
    'wallet': {'fa': 'کیف پول', 'ps': 'بکس (والټ)', 'en': 'Wallet'},

    // --- مکان‌یابی و امنیت ---
    'gps_disabled': {'fa': 'لطفاً جی‌پی‌اس گوشی را روشن کنید', 'ps': 'مهرباني وکړئ GPS چالان کړئ', 'en': 'Please enable GPS'},
    'location_denied': {'fa': 'اجازه دسترسی به مکان داده نشد', 'ps': 'ځای ته د لاسرسي اجازه ورنکړل شوه', 'en': 'Location access denied'},
    'sos_sent_alert': {'fa': 'پیام اضطراری به مرکز ارسال شد', 'ps': 'بېړنی پیغام مرکز ته واستول شو', 'en': 'SOS alert sent to center'},
    'is_sos_active': {'fa': 'وضعیت اضطراری', 'ps': 'بیړنی حالت', 'en': 'SOS Active'},
    'distance': {'fa': 'مسافت (کیلومتر)', 'ps': 'واټن (کیلومتر)', 'en': 'Distance (KM)'},
    'rating': {'fa': 'امتیاز', 'ps': 'امتیاز', 'en': 'Rating'},
  };

  return words[key]?[lang] ?? key;
}
