class FareCalculator {
  final double basePrice;        // کرایه پایه
  final double pricePerKm;       // قیمت هر کیلومتر
  final int commissionPercent;   // درصد کمیسیون

  FareCalculator({
    required this.basePrice,
    required this.pricePerKm,
    required this.commissionPercent,
  });

  Map<String, double> calculate(double distanceKm) {
    double price = basePrice + (distanceKm * pricePerKm);
    double commission = price * commissionPercent / 100;
    double driverEarn = price - commission;

    return {
      'price': price,
      'commission': commission,
      'driverEarn': driverEarn,
    };
  }
}
