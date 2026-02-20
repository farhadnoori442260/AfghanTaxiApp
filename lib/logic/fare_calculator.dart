import 'package:flutter/material.dart';
import '../utils/helper.dart';

class FareCalculator {
  // نرخ‌های پایه بروز شده (پول افغانی) برای پروژه سفیر
  static const double baseFareTaxi = 50.0;
  static const double perKmTaxi = 20.0;
  
  static const double baseFareCargo = 150.0;
  static const double perKmCargo = 40.0;

  static const double baseFareBike = 20.0; 
  static const double perKmBike = 10.0;

  static const double baseFareLuxury = 100.0; 
  static const double perKmLuxury = 35.0;

  static const double commissionPercent = 10.0; // کمیسیون ثابت سفیر

  // متد اصلی با قابلیت دریافت Context برای مدیریت زبان در نمایش قیمت
  Map<String, double> calculate(double distance, {String vehicleType = 'safir_taxi'}) {
    double price = calculateFare(distance, vehicleType);
    double commission = (price * commissionPercent) / 100;
    double driverEarn = price - commission;

    return {
      'price': price,
      'commission': commission,
      'driverEarn': driverEarn,
    };
  }

  double calculateFare(double distanceInKm, String vehicleType) {
    // هماهنگ شده با کلیدهای استاندارد سفیر
    switch (vehicleType) {
      case 'safir_cargo': 
        return baseFareCargo + (distanceInKm * perKmCargo);
      case 'safir_bike': 
        return baseFareBike + (distanceInKm * perKmBike);
      case 'safir_luxury': 
        return baseFareLuxury + (distanceInKm * perKmLuxury);
      default: 
        return baseFareTaxi + (distanceInKm * perKmTaxi);
    }
  }

  // متد کمکی برای نمایش قیمت همراه با واحد پول (AFN) به صورت سه‌زبانه
  static String getFormattedPrice(BuildContext context, double amount) {
    return "${amount.toStringAsFixed(0)} ${tr(context, 'afn')}";
  }

  double applyDiscount(double originalFare, String promoCode) {
    if (promoCode == "SAFIR2026") return originalFare * 0.8;
    return originalFare;
  }
}
