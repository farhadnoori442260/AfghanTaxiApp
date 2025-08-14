class Driver {
  final String id;
  final String name;
  final String phoneNumber;
  final String carModel;
  final String carNumber;
  final bool isOnline;
  final double latitude;
  final double longitude;

  Driver({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.carModel,
    required this.carNumber,
    this.isOnline = false,
    this.latitude = 0.0,
    this.longitude = 0.0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'carModel': carModel,
      'carNumber': carNumber,
      'isOnline': isOnline,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory Driver.fromMap(Map<String, dynamic> map) {
    return Driver(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      carModel: map['carModel'] ?? '',
      carNumber: map['carNumber'] ?? '',
      isOnline: map['isOnline'] ?? false,
      latitude: (map['latitude'] ?? 0.0).toDouble(),
      longitude: (map['longitude'] ?? 0.0).toDouble(),
    );
  }
}
