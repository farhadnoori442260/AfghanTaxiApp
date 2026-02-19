class FareCalculator {
  // نرخ‌های پایه بروز شده (پول افغانی)
  static const double baseFareTaxi = 50.0;
  static const double perKmTaxi = 20.0;
  
  static const double baseFareCargo = 150.0;
  static const double perKmCargo = 40.0;

  static const double baseFareBike = 20.0; 
  static const double perKmBike = 10.0;

  static const double baseFareLuxury = 100.0; 
  static const double perKmLuxury = 35.0;

  static const double commissionPercent = 10.0; // کمیسیون ثابت سفیر

  // متد اصلی برای استفاده در صفحه تست کرایه
  Map<String, double> calculate(double distance, {String vehicleType = 'taxi'}) {
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
    switch (vehicleType) {
      case 'cargo': return baseFareCargo + (distanceInKm * perKmCargo);
      case 'bike': return baseFareBike + (distanceInKm * perKmBike);
      case 'luxury': return baseFareLuxury + (distanceInKm * perKmLuxury);
      default: return baseFareTaxi + (distanceInKm * perKmTaxi);
    }
  }

  double applyDiscount(double originalFare, String promoCode) {
    if (promoCode == "SAFIR2026") return originalFare * 0.8;
    return originalFare;
  }
}
