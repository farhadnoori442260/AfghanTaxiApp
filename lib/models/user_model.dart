class UserModel {
  final String id;
  final String fullName;
  final String phone;
  final double walletBalance; 
  final double rating;        
  final String? referralCode;  
  final String appLanguage;    

  UserModel({
    required this.id,
    required this.fullName,
    required this.phone,
    this.walletBalance = 0.0,
    this.rating = 5.0,
    this.referralCode,
    this.appLanguage = 'fa',
  });

  // تبدیل داده‌های فایربیس به مدل با مدیریت خطا
  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      id: data['id'] ?? '',
      fullName: data['full_name'] ?? data['name'] ?? '', // هماهنگی با هر دو نام قدیمی و جدید
      phone: data['phone'] ?? '',
      walletBalance: (data['wallet_balance'] ?? 0.0).toDouble(),
      rating: (data['rating'] ?? 5.0).toDouble(),
      referralCode: data['referral_code'],
      appLanguage: data['app_language'] ?? 'fa',
    );
  }

  // تبدیل برای ذخیره در فایربیس
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'full_name': fullName,
      'phone': phone,
      'wallet_balance': walletBalance,
      'rating': rating,
      'referral_code': referralCode,
      'app_language': appLanguage,
    };
  }
}
