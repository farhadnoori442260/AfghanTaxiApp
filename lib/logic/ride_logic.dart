import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../utils/helper.dart';

class RideLogic {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // مدیریت وضعیت‌های سفر در اپلیکیشن سفیر با اطلاع‌رسانی سه‌زبانه
  Future<void> updateRideStatus(BuildContext context, String rideId, String newStatus) async {
    try {
      await _db.collection('rides').doc(rideId).update({
        'status': newStatus,
        'last_update': FieldValue.serverTimestamp(),
      });

      // نمایش پیام موفقیت آمیز تغییر وضعیت (اختیاری)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(tr(context, 'status_updated'))),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(tr(context, 'error_occurred'))),
      );
    }
  }

  // چک کردن تاییدیه راننده با استفاده از فیلد مدل جدید (is_approved)
  Future<bool> isDriverAllowed(BuildContext context, String driverId) async {
    try {
      DocumentSnapshot doc = await _db.collection('drivers').doc(driverId).get();
      if (doc.exists) {
        bool isApproved = doc['is_approved'] ?? false;
        
        if (!isApproved) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(tr(context, 'not_approved_yet'))),
          );
        }
        return isApproved;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
