class PaymentModel {
  final String id;
  final String rideId;
  final String passengerId;
  final String driverId;
  final double amount;
  final String method; // cash, card, wallet
  final String status; // اضافه شده: pending, completed, failed
  final DateTime createdAt;

  PaymentModel({
    required this.id,
    required this.rideId,
    required this.passengerId,
    required this.driverId,
    required this.amount,
    required this.method,
    this.status = 'completed',
    required this.createdAt,
  });

  factory PaymentModel.fromMap(Map<String, dynamic> map) {
    return PaymentModel(
      id: map['id'] ?? '',
      rideId: map['ride_id'] ?? map['rideId'] ?? '',
      passengerId: map['passenger_id'] ?? map['passengerId'] ?? '',
      driverId: map['driver_id'] ?? map['driverId'] ?? '',
      amount: (map['amount'] ?? 0.0).toDouble(),
      method: map['method'] ?? 'cash',
      status: map['status'] ?? 'completed',
      createdAt: map['created_at'] != null 
          ? DateTime.parse(map['created_at']) 
          : (map['createdAt'] != null ? DateTime.parse(map['createdAt']) : DateTime.now()),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ride_id': rideId,
      'passenger_id': passengerId,
      'driver_id': driverId,
      'amount': amount,
      'method': method,
      'status': status,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
