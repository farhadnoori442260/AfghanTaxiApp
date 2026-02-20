import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../utils/helper.dart';

class LocationService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ۱. بررسی دسترسی و روشن بودن GPS با مدیریت زبان
  Future<bool> checkPermission(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    // بررسی روشن بودن لوکیشن گوشی
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(tr(context, 'gps_disabled'))),
      );
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(tr(context, 'location_denied'))),
        );
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(tr(context, 'location_permanently_denied'))),
      );
      return false;
    }

    return true;
  }

  // ۲. آپدیت زنده موقعیت راننده (سفیر) در دیتابیس
  void shareLiveLocation(String driverId) {
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 5, 
    );

    Geolocator.getPositionStream(locationSettings: locationSettings).listen(
      (Position position) {
        _db.collection('drivers').doc(driverId).update({
          'last_location': GeoPoint(position.latitude, position.longitude),
          'last_update': FieldValue.serverTimestamp(),
          'heading': position.heading, // اضافه شده برای چرخیدن آیکون ماشین روی نقشه
        });
      },
      onError: (error) {
        debugPrint("Location Stream Error: $error");
      }
    );
  }

  // ۳. گرفتن موقعیت فعلی با مدیریت خطا
  Future<Position?> getCurrentLocation(BuildContext context) async {
    try {
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(tr(context, 'error_getting_location'))),
      );
      return null;
    }
  }
}
