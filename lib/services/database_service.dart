import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../utils/helper.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ۱. دریافت قیمت لحظه‌ای و محاسبه کرایه (سه‌زبانه و هوشمند)
  Future<double> calculateTripPrice(double distanceKm, String vehicleType) async {
    DocumentSnapshot config = await _db.collection('settings').doc('app_config').get();
    
    // مقادیر پیش‌فرض بر اساس واحد پول افغانی
    double baseFare = (config['base_fare'] ?? 50.0).toDouble();
    double perKm = (config['price_per_km'] ?? 20.0).toDouble();
    
    // هماهنگی با انواع وسایل نقلیه پروژه سفیر
    if(vehicleType == 'safir_cargo') {
      perKm = (config['freight_per_km'] ?? 40.0).toDouble();
    } else if (vehicleType == 'safir_bike') {
      perKm = (config['bike_per_km'] ?? 15.0).toDouble();
    }
    
    return baseFare + (distanceKm * perKm);
  }

  // ۲. بررسی موجودی کیف پول مسافر
  Future<bool> hasEnoughBalance(String userId, double tripFare) async {
    DocumentSnapshot userDoc = await _db.collection('users').doc(userId).get();
    double balance = (userDoc['wallet_balance'] ?? 0.0).toDouble();
    return balance >= tripFare;
  }

  // ۳. عملیات پرداخت و ثبت در تاریخچه (تکمیل مدل Payment)
  Future<void> completePayment(BuildContext context, String rideId, String userId, double fare, String method) async {
    try {
      if (method == 'wallet') {
        await _db.collection('users').doc(userId).update({
          'wallet_balance': FieldValue.increment(-fare)
        });
      }

      // بروزرسانی وضعیت سفر در کالکشن اصلی
      await _db.collection('rides').doc(rideId).update({
        'status': 'completed',
        'payment_status': 'paid',
        'payment_method': method,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(tr(context, 'payment_success'))),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(tr(context, 'payment_failed'))),
      );
    }
  }

  // ۴. سیستم امتیازدهی حرفه‌ای راننده
  Future<void> submitReview(String rideId, String driverId, double rating, String comment) async {
    // ثبت در سفر
    await _db.collection('rides').doc(rideId).update({
      'rating': rating,
      'comment': comment
    });
    
    // آپدیت راننده: در پروژه‌های بزرگ باید مجموع امتیاز بر تعداد تقسیم شود
    // فعلاً برای سادگی فیلد میانگین را آپدیت می‌کنیم
    DocumentSnapshot driverDoc = await _db.collection('drivers').doc(driverId).get();
    double currentRating = (driverDoc['rating'] ?? 5.0).toDouble();
    
    // فرمول ساده برای میانگین جدید
    double newRating = (currentRating + rating) / 2;

    await _db.collection('drivers').doc(driverId).update({
      'rating': newRating,
    });
  }

  // ۵. سیستم امنیت SOS سفیر
  Future<void> triggerSOS(BuildContext context, String rideId, String userId, GeoPoint currentLoc) async {
    await _db.collection('alerts').add({
      'ride_id': rideId,
      'user_id': userId,
      'location': currentLoc,
      'time': FieldValue.serverTimestamp(),
      'status': 'urgent',
      'is_resolved': false
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(tr(context, 'sos_sent_alert')),
      ),
    );
  }
}
