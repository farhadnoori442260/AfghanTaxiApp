class DriverModel {
  final String id;
  final String fullName;
  final String phone;
  final String vehicleType;  // safir_taxi, safir_cargo, safir_bike
  final String vehicleModel; 
  final String plateNumber;
  final String? city;        // ولایت محل فعالیت
  final double walletBalance;
  final double rating;
  final bool isOnline;
  final bool isApproved;     // وضعیت تایید توسط مدیریت

  DriverModel({
    required this.id,
    required this.fullName,
    required this.phone,
    required this.vehicleType,
    required this.vehicleModel,
    required this.plateNumber,
    this.city,
    this.walletBalance = 0.0,
    this.rating = 5.0,
    this.isOnline = false,
    this.isApproved = false,
  });

  factory DriverModel.fromMap(Map<String, dynamic> data) {
    return DriverModel(
      id: data['id'] ?? '',
      fullName: data['full_name'] ?? data['name'] ?? '',
      phone: data['phone'] ?? '',
      vehicleType: data['vehicle_type'] ?? 'safir_taxi',
      vehicleModel: data['vehicle_model'] ?? '',
      plateNumber: data['plate_number'] ?? '',
      city: data['city'],
      walletBalance: (data['wallet_balance'] ?? 0.0).toDouble(),
      rating: (data['rating'] ?? 5.0).toDouble(),
      isOnline: data['is_online'] ?? false,
      isApproved: data['is_approved'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'full_name': fullName,
      'phone': phone,
      'vehicle_type': vehicleType,
      'vehicle_model': vehicleModel,
      'plate_number': plateNumber,
      'city': city,
      'wallet_balance': walletBalance,
      'rating': rating,
      'is_online': isOnline,
      'is_approved': isApproved,
    };
  }
}
