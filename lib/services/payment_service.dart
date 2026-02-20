import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../utils/helper.dart';
import '../models/payment_model.dart';

class PaymentService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ۱. انتقال وجه امن با استفاده از Transaction و ثبت تاریخچه
  Future<bool> transferRideFare({
    required BuildContext context,
    required String rideId,
    required String passengerId,
    required String driverId,
    required double amount,
  }) async {
    try {
      await _db.runTransaction((transaction) async {
        // ۱. کسر از کیف پول مسافر
        transaction.update(_db.collection('users').doc(passengerId), {
          'wallet_balance': FieldValue.increment(-amount),
        });

        // ۲. واریز به کیف پول راننده سفیر
        transaction.update(_db.collection('drivers').doc(driverId), {
          'wallet_balance': FieldValue.increment(amount),
        });

        // ۳. ثبت رسید دیجیتالی در تاریخچه تراکنش‌ها
        DocumentReference paymentRef = _db.collection('payments').doc();
        PaymentModel payment = PaymentModel(
          id: paymentRef.id,
          rideId: rideId,
          passengerId: passengerId,
          driverId: driverId,
          amount: amount,
          method: 'wallet',
          status: 'completed',
          createdAt: DateTime.now(),
        );
        transaction.set(paymentRef, payment.toMap());
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(tr(context, 'payment_success'))),
      );
      return true;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(tr(context, 'payment_failed'))),
      );
      return false;
    }
  }

  // ۲. شارژ کیف پول (توسط ادمین یا کارت شارژ) با ثبت رسید
  Future<void> rechargeWallet(BuildContext context, String userId, double amount, String userType) async {
    try {
      String collection = (userType == 'driver') ? 'drivers' : 'users';
      
      await _db.collection(collection).doc(userId).update({
        'wallet_balance': FieldValue.increment(amount),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(tr(context, 'wallet_recharged'))),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(tr(context, 'error_occurred'))),
      );
    }
  }
}
