class FareCalculator {
  // نرخ‌های پایه بروز شده برای اپلیکیشن سفیر (به پول افغانی)
  static const double baseFareTaxi = 50.0;
  static const double perKmTaxi = 20.0;
  
  static const double baseFareCargo = 150.0;
  static const double perKmCargo = 40.0;

  static const double baseFareBike = 20.0; // جدید: برای سفیر سریع (موتور)
  static const double perKmBike = 10.0;

  static const double baseFareLuxury = 100.0; // جدید: برای سفیر لوکس
  static const double perKmLuxury = 35.0;

  // محاسبه نهایی قیمت بر اساس نوع وسیله در سفیر
  double calculateFare(double distanceInKm, String vehicleType) {
    switch (vehicleType) {
      case 'cargo':
      case 'سفیر باربر':
        return baseFareCargo + (distanceInKm * perKmCargo);
        
      case 'bike':
      case 'سفیر سریع':
        return baseFareBike + (distanceInKm * perKmBike);
        
      case 'luxury':
      case 'سفیر لوکس':
        return baseFareLuxury + (distanceInKm * perKmLuxury);
        
      default:
        // پیش‌فرض برای تکسی اقتصادی سفیر
        return baseFareTaxi + (distanceInKm * perKmTaxi);
    }
  }

  // اضافه کردن سیستم کد تخفیف که قبلاً صحبت کردیم
  double applyDiscount(double originalFare, String promoCode) {
    if (promoCode == "SAFIR2026") {
      return originalFare * 0.8; // ۲۰ درصد تخفیف ویژه
    }
    return originalFare;
  }
}
