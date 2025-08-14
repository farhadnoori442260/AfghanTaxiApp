import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ثبت‌نام کاربر
  Future<User?> signUp(String email, String password, String name, String role) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;

      await _firestore.collection('users').doc(user!.uid).set({
        'name': name,
        'email': email,
        'role': role, // driver یا passenger
        'createdAt': DateTime.now(),
      });

      return user;
    } catch (e) {
      rethrow;
    }
  }

  // ورود کاربر
  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } catch (e) {
      rethrow;
    }
  }

  // خروج کاربر
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // کاربر فعلی
  User? get currentUser => _auth.currentUser;
}