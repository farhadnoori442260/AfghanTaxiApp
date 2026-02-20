import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../utils/helper.dart';

class DriverService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ۱. تغییر وضعیت حضور راننده با چک کردن وضعیت تایید (سفیر)
  Future<void> updateDriverStatus(BuildContext context, String driverId, bool isOnline) async {
    try {
      // ابتدا چک می‌کنیم که آیا راننده توسط مدیریت تایید شده است یا خیر
      DocumentSnapshot driverDoc = await _db.collection('drivers').doc(driverId).get();
      bool isApproved = driverDoc['is_approved'] ?? false;

      if (!isApproved && isOnline) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(tr(context, 'not_approved_yet'))),
        );
        return;
      }

      await _db.collection('drivers').doc(driverId).update({
        'is_online': isOnline,
        'last_update': FieldValue.serverTimestamp(),
      });

      String message = isOnline ? tr(context, 'you_are_online') : tr(context, 'you_are_offline');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
      
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(tr(context, 'error_occurred'))),
      );
    }
  }

  // ۲. دریافت لیست درخواست‌های سفر فعال (مخصوص سفیر)
  Stream<QuerySnapshot> getAvailableRideRequests() {
    return _db
        .collection('rides')
        .where('status', isEqualTo: 'searching')
        .orderBy('created_at', descending: true) // نمایش جدیدترین‌ها در ابتدا
        .snapshots();
  }

  // ۳. قبول سفر توسط راننده سفیر با ثبت دقیق اطلاعات
  Future<void> acceptRideRequest(BuildContext context, String rideId, String driverId, String driverName, String phone) async {
    try {
      await _db.collection('rides').doc(rideId).update({
        'driver_id': driverId,
        'driver_name': driverName,
        'driver_phone': phone,
        'status': 'accepted',
        'accepted_at': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(tr(context, 'ride_accepted'))),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(tr(context, 'error_accepting_ride'))),
      );
    }
  }

  // ۴. پایان سفر و تکمیل وضعیت مالی
  Future<void> completeRide(BuildContext context, String rideId) async {
    try {
      await _db.collection('rides').doc(rideId).update({
        'status': 'completed',
        'completed_at': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(tr(context, 'ride_completed_success'))),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(tr(context, 'error_occurred'))),
      );
    }
  }
}
