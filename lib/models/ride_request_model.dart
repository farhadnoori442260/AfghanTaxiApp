class RideRequestModel {
  String? id;
  String? passengerId;
  String? driverId;
  String? status; // searching, accepted, arrived, started, completed, cancelled
  double? fare;
  bool? isSosActive; // برای دکمه امنیت

  RideRequestModel({
    this.id,
    this.passengerId,
    this.driverId,
    this.status = 'searching',
    this.fare,
    this.isSosActive = false,
  });

  UserModel.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    passengerId = data['passenger_id'];
    driverId = data['driver_id'];
    status = data['status'];
    fare = (data['fare'] ?? 0.0).toDouble();
    isSosActive = data['is_sos_active'] ?? false;
  }
  // متد toMap را هم مشابه مدل قبلی بر اساس این فیلدها اصلاح کن
}
