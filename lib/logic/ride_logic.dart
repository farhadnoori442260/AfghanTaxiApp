import 'package:cloud_firestore/cloud_firestore.dart';

class RideLogic {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // مدیریت وضعیت‌های سفر در اپلیکیشن سفیر
  // وضعیت‌ها: searching -> accepted -> arrived -> picked_up -> completed
  Future<void> updateRideStatus(String rideId, String newStatus) async {
    try {
      await _db.collection('rides').doc(rideId).update({
        'status': newStatus,
        'last_update': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print("خطا در تغییر وضعیت سفر: $e");
    }
  }

  // چک کردن اینکه آیا راننده تایید شده است یا خیر
  Future<bool> isDriverAllowed(String driverId) async {
    DocumentSnapshot doc = await _db.collection('drivers').doc(driverId).get();
    if (doc.exists) {
      return doc['is_verified'] ?? false;
    }
    return false;
  }
}