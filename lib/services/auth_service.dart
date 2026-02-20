import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../utils/helper.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ۱. ثبت‌نام کاربر جدید در اپلیکیشن سفیر با کد معرف
  Future<void> signUpUser({
    required BuildContext context, // اضافه شده برای مدیریت زبان
    required String name,
    required String phone,
    String? friendReferralCode,
  }) async {
    User? user = _auth.currentUser;
    if (user != null) {
      // ساخت کد معرف اختصاصی (۳ حرف اول نام + ۴ رقم آخر شماره)
      String myNewReferralCode = (name.length >= 3 ? name.substring(0, 3).toUpperCase() : name.toUpperCase()) + 
                                 (phone.length >= 4 ? phone.substring(phone.length - 4) : "0000");

      // استفاده از UserModel برای یکپارچگی داده‌ها
      UserModel newUser = UserModel(
        id: user.uid,
        fullName: name,
        phone: phone,
        walletBalance: 0.0,
        rating: 5.0,
        referralCode: myNewReferralCode,
        appLanguage: Localizations.localeOf(context).languageCode,
      );

      try {
        await _db.collection('users').doc(user.uid).set(newUser.toMap());
        
        // اضافه کردن فیلد کمکی برای سیستم پاداش
        await _db.collection('users').doc(user.uid).update({
          'referred_by': friendReferralCode,
          'created_at': FieldValue.serverTimestamp(),
        });

        // ۲. اگر کد معرف دوست را زده بود
        if (friendReferralCode != null && friendReferralCode.isNotEmpty) {
          await _applyReferralBonus(friendReferralCode, user.uid);
        }

        // نمایش پیام موفقیت (بعداً کلید آن را به helper اضافه می‌کنیم)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(tr(context, 'reg_success'))),
        );
        
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(tr(context, 'error_occurred'))),
        );
      }
    }
  }

  // متد کمکی برای واریز پاداش دعوت به کیف پول
  Future<void> _applyReferralBonus(String code, String newUserId) async {
    var inviterQuery = await _db.collection('users').where('referral_code', isEqualTo: code).get();
    
    if (inviterQuery.docs.isNotEmpty) {
      String inviterId = inviterQuery.docs.first.id;
      double bonus = 20.0; // ۲۰ افغانی پاداش برای پروژه سفیر
      
      // آپدیت کیف پول هر دو نفر به صورت همزمان
      WriteBatch batch = _db.batch();
      
      batch.update(_db.collection('users').doc(inviterId), {'wallet_balance': FieldValue.increment(bonus)});
      batch.update(_db.collection('users').doc(newUserId), {'wallet_balance': FieldValue.increment(bonus)});
      
      await batch.commit();
    }
  }

  // خروج از حساب کاربری
  Future<void> signOut(BuildContext context) async {
    await _auth.signOut();
    // در صورت نیاز پیامی نمایش داده شود
  }
}
