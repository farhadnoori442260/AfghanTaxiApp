import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ذخیره سفر جدید
  Future<void> createRide(Map<String, dynamic> rideData) async {
    await _db.collection('rides').add(rideData);
  }

  // دریافت اطلاعات سفر
  Stream<QuerySnapshot> getRides() {
    return _db.collection('rides').snapshots();
  }

  // بروزرسانی وضعیت سفر
  Future<void> updateRide(String rideId, Map<String, dynamic> updates) async {
    await _db.collection('rides').doc(rideId).update(updates);
  }
}