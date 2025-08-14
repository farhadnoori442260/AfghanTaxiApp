class UserModel {
  String uid;
  String name;
  String email;
  String phone;
  String role; // driver یا passenger
  String? profileImageUrl;
  double? lat;
  double? lng;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    this.profileImageUrl,
    this.lat,
    this.lng,
  });

  // تبدیل داده از Firebase
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      role: map['role'],
      profileImageUrl: map['profileImageUrl'],
      lat: map['lat'] != null ? map['lat'].toDouble() : null,
      lng: map['lng'] != null ? map['lng'].toDouble() : null,
    );
  }

  // تبدیل به Map برای ذخیره در Firebase
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'phone': phone,
      'role': role,
      'profileImageUrl': profileImageUrl,
      'lat': lat,
      'lng': lng,
    };
  }
}