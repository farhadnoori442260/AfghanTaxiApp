class RideRequestModel {
  final String id;
  final String passengerId;
  final String? driverId;
  final String status; // searching, accepted, arrived, started, completed, cancelled
  final String pickupAddress;
  final String destinationAddress;
  final double fare;
  final bool isSosActive;

  RideRequestModel({
    required this.id,
    required this.passengerId,
    this.driverId,
    this.status = 'searching',
    required this.pickupAddress,
    required this.destinationAddress,
    required this.fare,
    this.isSosActive = false,
  });

  // تبدیل دیتای فایربیس به مدل (با تصحیح نام متد)
  factory RideRequestModel.fromMap(Map<String, dynamic> data) {
    return RideRequestModel(
      id: data['id'] ?? '',
      passengerId: data['passenger_id'] ?? '',
      driverId: data['driver_id'],
      status: data['status'] ?? 'searching',
      pickupAddress: data['pickup_address'] ?? '',
      destinationAddress: data['destination_address'] ?? '',
      fare: (data['fare'] ?? 0.0).toDouble(),
      isSosActive: data['is_sos_active'] ?? false,
    );
  }

  // متد toMap برای ذخیره در فایربیس
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'passenger_id': passengerId,
      'driver_id': driverId,
      'status': status,
      'pickup_address': pickupAddress,
      'destination_address': destinationAddress,
      'fare': fare,
      'is_sos_active': isSosActive,
    };
  }
}
