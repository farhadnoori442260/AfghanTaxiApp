import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../utils/colors.dart'; // فایل رنگ‌های سفیر
import '../widgets/safir_side_panel.dart';
import '../services/location_service.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;
  LatLng? _currentPosition;
  LatLng? _pickupLocation;
  LatLng? _destinationLocation;
  
  // مراحل سفر: 0: مبدأ، 1: مقصد، 2: انتخاب نوع موتر
  int _currentStep = 0; 
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      final position = await LocationService.getCurrentLocation();
      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
        _pickupLocation = _currentPosition; 
      });
    } catch (e) {
      // اگر لوکیشن غیرفعال بود، کابل را به عنوان مرکز در نظر بگیر
      setState(() {
        _currentPosition = const LatLng(34.5553, 69.2075);
      });
    }
  }

  void _onCameraMove(CameraPosition position) {
    setState(() {
      if (_currentStep == 0) _pickupLocation = position.target;
      if (_currentStep == 1) _destinationLocation = position.target;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      // منوی پروفایل سفیر که در سمت راست باز می‌شود
      endDrawer: const SafirSidePanel(yearsOfService: 1), 
      body: Stack(
        children: [
          // ۱. لایه نقشه گوگل
          _currentPosition == null
              ? const Center(child: CircularProgressIndicator(color: SafirColors.primaryGreen))
              : GoogleMap(
                  onMapCreated: (controller) => _mapController = controller,
                  initialCameraPosition: CameraPosition(target: _currentPosition!, zoom: 15),
                  onCameraMove: _onCameraMove,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                  mapType: MapType.normal,
                ),

          // ۲. پین هوشمند وسط نقشه
          if (_currentStep < 2)
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 35),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: _currentStep == 0 ? SafirColors.primaryGreen : Colors.redAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        _currentStep == 0 ? "تأیید مبدأ" : "تأیید مقصد",
                        style: const TextStyle(fontFamily: 'IranYekan', color: Colors.white, fontSize: 12),
                      ),
                    ),
                    Icon(
                      Icons.location_on_rounded, 
                      size: 50, 
                      color: _currentStep == 0 ? SafirColors.primaryGreen : Colors.redAccent,
                    ),
                  ],
                ),
              ),
            ),

          // ۳. دکمه منو (همبرگری) - استایل سفید مدرن
          Positioned(
            top: 50,
            right: 20,
            child: GestureDetector(
              onTap: () => _scaffoldKey.currentState!.openEndDrawer(),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
                ),
                child: const Icon(Icons.menu, color: SafirColors.primaryGreen, size: 28),
              ),
            ),
          ),

          // ۴. پنل پایین صفحه (Bottom UI)
          Align(
            alignment: Alignment.bottomCenter,
            child: _buildBottomUI(),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomUI() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        boxShadow: [BoxShadow(blurRadius: 20, color: Colors.black12)],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_currentStep == 0) ...[
            const Text(
              "کجا هستید؟",
              style: TextStyle(fontFamily: 'IranYekan', fontWeight: FontWeight.bold, fontSize: 18, color: SafirColors.primaryGreen),
            ),
            const SizedBox(height: 15),
            _buildActionButton("تأیید مکان مبدأ", SafirColors.primaryGreen, () {
              setState(() => _currentStep = 1);
            }),
          ] 
          else if (_currentStep == 1) ...[
            const Text(
              "مقصد سفر را مشخص کنید",
              style: TextStyle(fontFamily: 'IranYekan', fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 15),
            _buildActionButton(
              "تأیید مکان مقصد", 
              SafirColors.primaryGreen, 
              () => setState(() => _currentStep = 2)
            ),
            TextButton(
              onPressed: () => setState(() => _currentStep = 0),
              child: const Text("اصلاح مبدأ", style: TextStyle(fontFamily: 'IranYekan', color: Colors.grey)),
            )
          ] 
          else if (_currentStep == 2) ...[
            const Text(
              "انتخاب نوع سرویس سفیر",
              style: TextStyle(fontFamily: 'IranYekan', fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 15),
            _buildVehicleSelection(),
            const SizedBox(height: 20),
            _buildActionButton("درخواست سفیر", SafirColors.primaryGreen, () {
              // منطق نهایی درخواست
            }),
            TextButton(
              onPressed: () => setState(() => _currentStep = 1),
              child: const Text("تغییر مقصد", style: TextStyle(fontFamily: 'IranYekan', color: Colors.grey)),
            )
          ],
        ],
      ),
    );
  }

  Widget _buildActionButton(String label, Color color, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 0,
        ),
        onPressed: onPressed,
        child: Text(
          label, 
          style: const TextStyle(fontFamily: 'IranYekan', color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)
        ),
      ),
    );
  }

  Widget _buildVehicleSelection() {
    return SizedBox(
      height: 120,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _vehicleItem("سفیر اقتصادی", Icons.directions_car, "۱۲۰ AFN", SafirColors.primaryGreen),
          _vehicleItem("سفیر باربر", Icons.local_shipping, "۳۵۰ AFN", Colors.blueGrey),
          _vehicleItem("سفیر موتر", Icons.motorcycle, "۶۰ AFN", Colors.orange),
          _vehicleItem("سفیر VIP", Icons.workspace_premium, "۵۰۰ AFN", Colors.amber.shade700),
        ],
      ),
    );
  }

  Widget _vehicleItem(String name, IconData icon, String price, Color color) {
    return Container(
      width: 110,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.2), width: 2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 35),
          const SizedBox(height: 8),
          Text(name, style: const TextStyle(fontFamily: 'IranYekan', fontSize: 10, fontWeight: FontWeight.bold)),
          Text(price, style: TextStyle(fontFamily: 'IranYekan', color: color, fontSize: 13, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
