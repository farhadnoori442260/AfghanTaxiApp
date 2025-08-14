class PaymentModel {
  String id;
  String rideId;
  String passengerId;
  String driverId;
  double amount;
  String method; // cash, card, wallet
  DateTime createdAt;

  PaymentModel({
    required this.id,
    required this.rideId,
    required this.passengerId,
    required this.driverId,
    required this.amount,
    required this.method,
    required this.createdAt,
  });

  factory PaymentModel.fromMap(Map<String, dynamic> map) {
    return PaymentModel(
      id: map['id'],
      rideId: map['rideId'],
      passengerId: map['passengerId'],
      driverId: map['driverId'],
      amount: map['amount'].toDouble(),
      method: map['method'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'rideId': rideId,
      'passengerId': passengerId,
      'driverId': driverId,
      'amount': amount,
      'method': method,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}