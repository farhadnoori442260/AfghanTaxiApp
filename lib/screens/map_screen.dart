import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import '../services/location_service.dart';
import '../services/ride_service.dart';
import '../models/ride.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;
  LatLng? _currentPosition;
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    final position = await LocationService.getCurrentLocation();
    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
      _markers.add(
        Marker(
          markerId: const MarkerId('currentLocation'),
          position: _currentPosition!,
          infoWindow: const InfoWindow(title: 'موقعیت شما'),
        ),
      );
    });

    if (_mapController != null) {
      _mapController!.animateCamera(
        CameraUpdate.newLatLngZoom(_currentPosition!, 15),
      );
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _requestRide() {
    final rideService = Provider.of<RideService>(context, listen: false);
    if (_currentPosition != null) {
      rideService.createRide(
        Ride(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          pickupLocation: _currentPosition!,
          destinationLocation: LatLng(34.5553, 69.2075), // کابل به عنوان تست
          status: 'requested',
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('درخواست سفر ثبت شد')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('نقشه'),
        backgroundColor: Colors.green,
      ),
      body: _currentPosition == null
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _currentPosition!,
                zoom: 15,
              ),
              markers: _markers,
              polylines: _polylines,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _requestRide,
        backgroundColor: Colors.green,
        child: const Icon(Icons.local_taxi),
      ),
    );
  }
}