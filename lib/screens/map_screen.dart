import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../services/location_service.dart';
import '../services/ride_service.dart';
import '../models/ride.dart';
import '../widgets/safir_side_panel.dart'; // وارد کردن پنل شیشه‌ای

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
  
  int _currentStep = 0; // 0: انتخاب مبدأ, 1: انتخاب مقصد, 2: انتخاب موتر
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    final position = await LocationService.getCurrentLocation();
    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
      _pickupLocation = _currentPosition; // به صورت پیش‌فرض مبدأ کجاست
    });
  }

  void _onCameraMove(CameraPosition position) {
    // وقتی کاربر نقشه را تکان می‌دهد، مرکز نقشه لوکیشن ما می‌شود
    setState(() {
      if (_currentStep == 0) _pickupLocation = position.target;
      if (_currentStep == 1) _destinationLocation = position.target;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: SafirSidePanel(yearsOfService: 3), // اتصال پنل شیشه‌ای سمت راست
      body: Stack(
        children: [
          // ۱. نقشه اصلی
          _currentPosition == null
              ? const Center(child: CircularProgressIndicator())
              : GoogleMap(
                  onMapCreated: (controller) => _mapController = controller,
                  initialCameraPosition: CameraPosition(target: _currentPosition!, zoom: 15),
                  onCameraMove: _onCameraMove,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                ),

          // ۲. آیکون وسط نقشه (برای انتخاب دقیق لوکیشن)
          if (_currentStep < 2)
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 35),
                child: Icon(Icons.location_on, size: 50, color: _currentStep == 0 ? Colors.blue : Colors.red),
              ),
            ),

          // ۳. دکمه منوی پروفایل (سمت راست بالا)
          Positioned(
            top: 50,
            right: 20,
            child: InkWell(
              onTap: () => _scaffoldKey.currentState!.openEndDrawer(),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black12)]),
                child: const Icon(Icons.menu, color: Colors.black87),
              ),
            ),
          ),

          // ۴. پنل پایینی هوشمند سفیر
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
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        boxShadow: [BoxShadow(blurRadius: 20, color: Colors.black12)],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_currentStep == 0) ...[
            const Text("مبدأ سفر را مشخص کنید", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 20),
            _buildCustomButton("تأیید مبدأ سفیر", Colors.blue, () => setState(() => _currentStep = 1)),
          ] else if (_currentStep == 1) ...[
            const Text("مقصد سفر را مشخص کنید", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 20),
            _buildCustomButton(
              "تأیید مقصد و مشاهده قیمت", 
              _destinationLocation == null ? Colors.grey : Colors.green, 
              _destinationLocation == null ? null : () => setState(() => _currentStep = 2)
            ),
          ] else if (_currentStep == 2) ...[
            _buildVehicleSelection(), // نمایش لیست موترهای ۳ بعدی
            const SizedBox(height: 20),
            _buildCustomButton("درخواست سفیر", Colors.orangeAccent, () => print("سفر ثبت شد!")),
          ],
        ],
      ),
    );
  }

  Widget _buildCustomButton(String text, Color color, VoidCallback? onPressed) {
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
        child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildVehicleSelection() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _vehicleItem("تکسی", "assets/taxi.png", "80 AFN"),
          _vehicleItem("باربری", "assets/truck.png", "200 AFN"),
          _vehicleItem("موتور", "assets/bike.png", "40 AFN"),
          _vehicleItem("لوکس", "assets/luxury.png", "350 AFN"),
        ],
      ),
    );
  }

  Widget _vehicleItem(String name, String img, String price) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(border: Border.all(color: Colors.black12), borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          const Icon(Icons.directions_car, size: 40), // اینجا بعداً عکس‌های ۳ بعدی را می‌گذاریم
          Text(name),
          Text(price, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
        ],
      ),
    );
  }
}
