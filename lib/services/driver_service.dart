import 'package:cloud_firestore/cloud_firestore.dart';

class DriverService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ۱. تغییر وضعیت حضور راننده در اپلیکیشن سفیر
  Future<void> updateDriverStatus(String driverId, bool isOnline) async {
    return await _db.collection('drivers').doc(driverId).update({
      'is_online': isOnline,
      'last_update': FieldValue.serverTimestamp(),
    });
  }

  // ۲. دریافت لیست درخواست‌های سفر فعال که هنوز کسی قبول نکرده
  Stream<QuerySnapshot> getAvailableRideRequests() {
    return _db
        .collection('rides')
        .where('status', isEqualTo: 'searching') // فقط درخواست‌های در حال جستجو
        .snapshots();
  }

  // ۳. قبول سفر توسط راننده سفیر
  Future<void> acceptRideRequest(String rideId, String driverId, String driverName, String phone) async {
    return await _db.collection('rides').doc(rideId).update({
      'driver_id': driverId,
      'driver_name': driverName,
      'driver_phone': phone,
      'status': 'accepted', // تغییر وضعیت به تایید شده
      'accepted_at': FieldValue.serverTimestamp(),
    });
  }

  // ۴. پایان سفر و دریافت کرایه (بروزرسانی وضعیت نهایی)
  Future<void> completeRide(String rideId) async {
    return await _db.collection('rides').doc(rideId).update({
      'status': 'completed',
      'completed_at': FieldValue.serverTimestamp(),
    });
  }
}
