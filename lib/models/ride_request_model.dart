class RideRequestModel {
  String id;
  String passengerId;
  String driverId;
  String pickupAddress;
  String dropOffAddress;
  double pickupLat;
  double pickupLng;
  double dropOffLat;
  double dropOffLng;
  String status; // waiting, accepted, completed, cancelled
  double fare;
  DateTime createdAt;

  RideRequestModel({
    required this.id,
    required this.passengerId,
    required this.driverId,
    required this.pickupAddress,
    required this.dropOffAddress,
    required this.pickupLat,
    required this.pickupLng,
    required this.dropOffLat,
    required this.dropOffLng,
    required this.status,
    required this.fare,
    required this.createdAt,
  });

  factory RideRequestModel.fromMap(Map<String, dynamic> map) {
    return RideRequestModel(
      id: map['id'],
      passengerId: map['passengerId'],
      driverId: map['driverId'],
      pickupAddress: map['pickupAddress'],
      dropOffAddress: map['dropOffAddress'],
      pickupLat: map['pickupLat'].toDouble(),
      pickupLng: map['pickupLng'].toDouble(),
      dropOffLat: map['dropOffLat'].toDouble(),
      dropOffLng: map['dropOffLng'].toDouble(),
      status: map['status'],
      fare: map['fare'].toDouble(),
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'passengerId': passengerId,
      'driverId': driverId,
      'pickupAddress': pickupAddress,
      'dropOffAddress': dropOffAddress,
      'pickupLat': pickupLat,
      'pickupLng': pickupLng,
      'dropOffLat': dropOffLat,
      'dropOffLng': dropOffLng,
      'status': status,
      'fare': fare,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}