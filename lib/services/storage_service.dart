import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // آپلود عکس
  Future<String> uploadImage(File file, String path) async {
    TaskSnapshot snapshot = await _storage.ref(path).putFile(file);
    return await snapshot.ref.getDownloadURL();
  }

  // حذف عکس
  Future<void> deleteImage(String path) async {
    await _storage.ref(path).delete();
  }
}