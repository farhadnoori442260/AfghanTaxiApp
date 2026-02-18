import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ۱. انتقال وجه از مسافر به راننده (در پایان سفر)
  Future<bool> transferRideFare({
    required String passengerId,
    required String driverId,
    required double amount,
  }) async {
    try {
      // کسر از کیف پول مسافر
      await _db.collection('users').doc(passengerId).update({
        'wallet_balance': FieldValue.increment(-amount),
      });

      // واریز به کیف پول راننده سفیر
      await _db.collection('drivers').doc(driverId).update({
        'wallet_balance': FieldValue.increment(amount),
      });

      return true;
    } catch (e) {
      return false;
    }
  }

  // ۲. شارژ کیف پول (مثلاً از طریق نمایندگی یا کارت شارژ)
  Future<void> rechargeWallet(String userId, double amount) async {
    return await _db.collection('users').doc(userId).update({
      'wallet_balance': FieldValue.increment(amount),
    });
  }
}
