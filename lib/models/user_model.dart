class UserModel {
  final String id;
  final String fullName;
  final String phone;
  final double rating;
  final List<String> medals;

  UserModel({required this.id, required this.fullName, required this.phone, this.rating = 0.0, this.medals = const []});
}
