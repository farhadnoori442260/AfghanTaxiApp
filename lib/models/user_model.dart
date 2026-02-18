class UserModel {
  String? id;
  String? name;
  String? phone;
  double? walletBalance; // اضافه شده برای کیف پول
  double? rating;        // اضافه شده برای امتیاز
  String? referralCode;  // اضافه شده برای سیستم پاداش
  String? appLanguage;   // اضافه شده برای تنظیم زبان

  UserModel({
    this.id,
    this.name,
    this.phone,
    this.walletBalance = 0.0,
    this.rating = 5.0,
    this.referralCode,
    this.appLanguage = 'fa',
  });

  // تبدیل داده‌های فایربیس (Map) به مدل کدنویسی
  UserModel.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    name = data['name'];
    phone = data['phone'];
    walletBalance = (data['wallet_balance'] ?? 0.0).toDouble();
    rating = (data['rating'] ?? 5.0).toDouble();
    referralCode = data['referral_code'];
    appLanguage = data['app_language'] ?? 'fa';
  }

  // تبدیل مدل کدنویسی به Map برای ذخیره در فایربیس
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'wallet_balance': walletBalance,
      'rating': rating,
      'referral_code': referralCode,
      'app_language': appLanguage,
    };
  }
}
