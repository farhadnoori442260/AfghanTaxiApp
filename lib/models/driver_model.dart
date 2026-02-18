class DriverModel {
  String? id;
  String? name;
  String? phone;
  String? vehicleType; // taxi, freight, motorcycle
  String? vehicleModel; // مثلا: Corolla 2020
  String? plateNumber;
  double? walletBalance;
  double? rating;
  bool? isOnline;

  DriverModel({
    this.id,
    this.name,
    this.phone,
    this.vehicleType,
    this.vehicleModel,
    this.plateNumber,
    this.walletBalance = 0.0,
    this.rating = 5.0,
    this.isOnline = false,
  });

  // تبدیل دیتای فایربیس به مدل دارت
  DriverModel.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    name = data['name'];
    phone = data['phone'];
    vehicleType = data['vehicle_type'];
    vehicleModel = data['vehicle_model'];
    plateNumber = data['plate_number'];
    walletBalance = (data['wallet_balance'] ?? 0.0).toDouble();
    rating = (data['rating'] ?? 5.0).toDouble();
    isOnline = data['is_online'] ?? false;
  }

  // تبدیل مدل به نقشه برای ذخیره در فایربیس
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'vehicle_type': vehicleType,
      'vehicle_model': vehicleModel,
      'plate_number': plateNumber,
      'wallet_balance': walletBalance,
      'rating': rating,
      'is_online': isOnline,
    };
  }
}
