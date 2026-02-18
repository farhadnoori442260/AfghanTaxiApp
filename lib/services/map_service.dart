import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math' show cos, sqrt, asin;

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

  // ۲. تنظیم دوربین نقشه برای دیدن همزمان راننده و مسافر
  LatLngBounds getBounds(LatLng pickup, LatLng destination) {
    if (pickup.latitude > destination.latitude && pickup.longitude > destination.longitude) {
      return LatLngBounds(southwest: destination, northeast: pickup);
    } else if (pickup.longitude > destination.longitude) {
      return LatLngBounds(
          southwest: LatLng(pickup.latitude, destination.longitude),
          northeast: LatLng(destination.latitude, pickup.longitude));
    } else if (pickup.latitude > destination.latitude) {
      return LatLngBounds(
          southwest: LatLng(destination.latitude, pickup.longitude),
          northeast: LatLng(pickup.latitude, destination.longitude));
    } else {
      return LatLngBounds(southwest: pickup, northeast: destination);
    }
  }

  // ۳. استایل نقشه سفیر (Dark Mode یا استاندارد)
  String getMapStyle() {
    return "[]"; // اینجا می‌توانید استایل سفارشی نقشه را قرار دهید
  }
}
