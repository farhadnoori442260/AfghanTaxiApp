class RideModel {
  final String id;
  final String origin;
  final String destination;
  final double fare;
  final String status; // مثلا: searching, accepted, completed

  RideModel({required this.id, required this.origin, required this.destination, required this.fare, required this.status});
}
