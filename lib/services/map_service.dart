import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class MapService {
  final String apiKey = "GOOGLE_MAPS_API_KEY"; // اینجا کلید API افغانستانت رو بگذار

  Future<List<LatLng>> getRouteCoordinates(
      double startLat, double startLng, double endLat, double endLng) async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      apiKey,
      PointLatLng(startLat, startLng),
      PointLatLng(endLat, endLng),
    );

    if (result.points.isNotEmpty) {
      return result.points.map((point) => LatLng(point.latitude, point.longitude)).toList();
    }
    return [];
  }
}