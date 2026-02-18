import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ۱. ثبت‌نام کاربر جدید در اپلیکیشن سفیر با کد معرف
  Future<void> signUpUser({
    required String name,
    required String phone,
    String? friendReferralCode, // کد دوستی که کاربر را دعوت کرده
  }) async {
    User? user = _auth.currentUser;
    if (user != null) {
      // ساخت کد معرف اختصاصی برای خودِ این کاربر جدید
      String myNewReferralCode = name.substring(0, 3).toUpperCase() + phone.substring(phone.length - 4);

      await _db.collection('users').doc(user.uid).set({
        'id': user.uid,
        'name': name,
        'phone': phone,
        'wallet_balance': 0.0,
        'rating': 5.0,
        'referral_code': myNewReferralCode,
        'referred_by': friendReferralCode,
        'app_name': 'Safir', // نام پروژه: سفیر
        'created_at': FieldValue.serverTimestamp(),
      });

      // ۲. اگر کد معرف دوست را زده بود، به هر دو پاداش بده
      if (friendReferralCode != null && friendReferralCode.isNotEmpty) {
        await _applyReferralBonus(friendReferralCode, user.uid);
      }
    }
  }

  // متد کمکی برای واریز پاداش دعوت به کیف پول
  Future<void> _applyReferralBonus(String code, String newUserId) async {
    // پیدا کردن شخصی که دعوت کرده
    var inviterQuery = await _db.collection('users').where('referral_code', isEqualTo: code).get();
    
    if (inviterQuery.docs.isNotEmpty) {
      String inviterId = inviterQuery.docs.first.id;
      
      // واریز مثلاً ۲۰ افغانی به کیف پول هر دو نفر
      double bonus = 20.0; 
      
      // آپدیت کیف پول دعوت‌کننده
      await _db.collection('users').doc(inviterId).update({
        'wallet_balance': FieldValue.increment(bonus)
      });
      
      // آپدیت کیف پول کاربر جدید (سفیر جدید)
      await _db.collection('users').doc(newUserId).update({
        'wallet_balance': FieldValue.increment(bonus)
      });
    }
  }

  // خروج از حساب کاربری سفیر
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
