import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ۱. دریافت قیمت لحظه‌ای از تنظیمات فایربیس (که قبلاً ساختیم)
  Future<double> calculateTripPrice(double distanceKm, String vehicleType) async {
    DocumentSnapshot config = await _db.collection('settings').doc('app_config').get();
    double baseFare = config['base_fare'] ?? 50.0;
    double perKm = config['price_per_km'] ?? 20.0;
    
    // اگر باربری بود، قیمت را بر اساس نوع موتر تغییر بده
    if(vehicleType == 'freight') {
      perKm = config['freight_per_km'] ?? 40.0;
    }
    
    return baseFare + (distanceKm * perKm);
  }

  // ۲. سیستم کیف پول پیشرفته (بررسی موجودی قبل از سفر)
  Future<bool> hasEnoughBalance(String userId, double tripFare) async {
    DocumentSnapshot userDoc = await _db.collection('users').doc(userId).get();
    double balance = (userDoc['wallet_balance'] ?? 0.0).toDouble();
    return balance >= tripFare;
  }

  // ۳. متد پرداخت دوگانه (نقد + کیف پول)
  Future<void> completePayment(String rideId, String userId, double fare, bool useWallet) async {
    if (useWallet) {
      // کسر از کیف پول
      await _db.collection('users').doc(userId).update({
        'wallet_balance': FieldValue.increment(-fare)
      });
    }
    // بروزرسانی وضعیت سفر
    await _db.collection('rides').doc(rideId).update({
      'status': 'completed',
      'payment_status': 'paid'
    });
  }

  // ۴. سیستم امتیازدهی و بازخورد (Rating)
  Future<void> submitReview(String rideId, String driverId, double rating, String comment) async {
    // ثبت نظر در سفر
    await _db.collection('rides').doc(rideId).update({
      'rating': rating,
      'comment': comment
    });
    
    // آپدیت میانگین امتیاز راننده (بسیار مهم برای راننده پسند شدن)
    await _db.collection('drivers').doc(driverId).update({
      'rating': FieldValue.increment(rating), // این یک منطق ساده است، بعداً باید میانگین بگیریم
    });
  }

  // ۵. سیستم امنیت SOS (ارسال موقعیت و مشخصات مسافر به ادمین)
  Future<void> triggerSOS(String rideId, String userId, GeoPoint currentLoc) async {
    await _db.collection('alerts').add({
      'ride_id': rideId,
      'user_id': userId,
      'location': currentLoc,
      'time': FieldValue.serverTimestamp(),
      'is_resolved': false
    });
  }
}
