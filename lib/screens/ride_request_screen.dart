import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../services/location_service.dart';

class RideRequestScreen extends StatefulWidget {
  const RideRequestScreen({super.key});

  @override
  State<RideRequestScreen> createState() => _RideRequestScreenState();
}

class _RideRequestScreenState extends State<RideRequestScreen> {
  GoogleMapController? _mapController;
  LatLng? _pickupLocation;
  LatLng? _dropoffLocation;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadPickupLocation();
  }

  Future<void> _loadPickupLocation() async {
    final locationService = Provider.of<LocationService>(context, listen: false);
    final position = await locationService.getCurrentLocation();

    setState(() {
      _pickupLocation = LatLng(position.latitude, position.longitude);
      _loading = false;
    });
  }

  void _confirmRide() {
    if (_pickupLocation != null && _dropoffLocation != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("درخواست تاکسی شما ثبت شد"),
        ),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("لطفا مبدا و مقصد را انتخاب کنید"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'درخواست تاکسی',
          style: TextStyle(fontFamily: 'B_Nazanin'),
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: GoogleMap(
                    onMapCreated: (controller) => _mapController = controller,
                    initialCameraPosition: CameraPosition(
                      target: _pickupLocation!,
                      zoom: 14,
                    ),
                    myLocationEnabled: true,
                    markers: {
                      if (_pickupLocation != null)
                        Marker(
                          markerId: const MarkerId('pickup'),
                          position: _pickupLocation!,
                          infoWindow: const InfoWindow(title: 'مبدا'),
                        ),
                      if (_dropoffLocation != null)
                        Marker(
                          markerId: const MarkerId('dropoff'),
                          position: _dropoffLocation!,
                          infoWindow: const InfoWindow(title: 'مقصد'),
                        ),
                    },
                    onTap: (position) {
                      setState(() {
                        if (_dropoffLocation == null) {
                          _dropoffLocation = position;
                        } else {
                          _pickupLocation = position;
                          _dropoffLocation = null;
                        }
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: _confirmRide,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'تایید درخواست',
                      style: TextStyle(fontSize: 18, fontFamily: 'B_Nazanin'),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}