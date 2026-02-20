import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math' show cos, sqrt, asin;
import 'package:flutter/material.dart';

class MapService {
  // ۱. محاسبه فاصله بین دو نقطه (فرمول Haversine) برای تعیین کرایه در سفیر
  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) *
            (1 - c((lon2 - lon1) * p)) / 2;
    
    // بازگشت فاصله به کیلومتر
    return 12742 * asin(sqrt(a));
  }

  // ۲. تنظیم هوشمند دوربین نقشه برای دیدن همزمان راننده و مسافر
  LatLngBounds getBounds(LatLng pickup, LatLng destination) {
    double minLat = (pickup.latitude < destination.latitude) ? pickup.latitude : destination.latitude;
    double maxLat = (pickup.latitude > destination.latitude) ? pickup.latitude : destination.latitude;
    double minLng = (pickup.longitude < destination.longitude) ? pickup.longitude : destination.longitude;
    double maxLng = (pickup.longitude > destination.longitude) ? pickup.longitude : destination.longitude;

    return LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );
  }

  // ۳. استایل نقشه سفیر (امکان تغییر بر اساس تم برنامه)
  Future<void> setMapStyle(GoogleMapController controller, BuildContext context) async {
    // می‌توانید بر اساس تم روشن یا تاریک گوشی، استایل را تغییر دهید
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    if (isDarkMode) {
      // استایل دارک برای رانندگی راحت‌تر در شب
      String darkStyle = "[]"; // کد JSON استایل را اینجا قرار دهید
      controller.setMapStyle(darkStyle);
    } else {
      controller.setMapStyle(null); // استایل استاندارد گوگل
    }
  }

  // ۴. متد کمکی برای ساخت مارکر (Marker)
  Marker createMarker(String id, LatLng position, String title, BitmapDescriptor icon) {
    return Marker(
      markerId: MarkerId(id),
      position: position,
      infoWindow: InfoWindow(title: title),
      icon: icon,
    );
  }
}
