import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LocationService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ۱. اجازه گرفتن از کاربر برای دسترسی به لوکیشن
  Future<bool> checkPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return permission != LocationPermission.deniedForever;
  }

  // ۲. آپدیت زنده موقعیت راننده در دیتابیس سفیر
  void shareLiveLocation(String driverId) {
    // تنظیمات حساسیت حرکت (مثلاً هر ۵ متر تغییر)
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 5, 
    );

    Geolocator.getPositionStream(locationSettings: locationSettings).listen(
      (Position position) {
        _db.collection('drivers').doc(driverId).update({
          'last_location': GeoPoint(position.latitude, position.longitude),
          'last_update': FieldValue.serverTimestamp(),
        });
      },
    );
  }

  // ۳. گرفتن موقعیت فعلی برای شروع سفر
  Future<Position> getCurrentLocation() async {
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }
}
