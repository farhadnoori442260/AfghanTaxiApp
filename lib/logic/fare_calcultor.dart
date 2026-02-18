class FareCalculator {
  // نرخ‌های پایه برای اپلیکیشن سفیر (به پول افغانی)
  static const double baseFareTaxi = 50.0;
  static const double perKmTaxi = 20.0;
  
  static const double baseFareCargo = 150.0;
  static const double perKmCargo = 40.0;

  // محاسبه نهایی قیمت
  double calculateFare(double distanceInKm, String vehicleType) {
    if (vehicleType == 'cargo') {
      return baseFareCargo + (distanceInKm * perKmCargo);
    } else {
      // پیش‌فرض برای تکسی سفیر
      return baseFareTaxi + (distanceInKm * perKmTaxi);
    }
  }
}
