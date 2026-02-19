import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../services/location_service.dart';
import '../services/ride_service.dart';
import '../models/ride.dart';
import '../widgets/safir_side_panel.dart'; // پنل پروفایلی که با هم ساختیم

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
  
  // مراحل سفر: 0: مبدأ، 1: مقصد، 2: انتخاب نوع موتر سفیر
  int _currentStep = 0; 
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
      _pickupLocation = _currentPosition; 
    });
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
      endDrawer: SafirSidePanel(yearsOfService: 3), // منوی پروفایل مدرن در سمت راست
      body: Stack(
        children: [
          // ۱. لایه نقشه
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

          // ۲. آیکون انتخابگر وسط نقشه (تغییر رنگ بر اساس مرحله)
          if (_currentStep < 2)
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 35),
                child: Icon(
                  Icons.location_on_rounded, 
                  size: 50, 
                  color: _currentStep == 0 ? Colors.blueAccent : Colors.redAccent
                ),
              ),
            ),

          // ۳. دکمه منوی همبرگری برای باز کردن پروفایل
          Positioned(
            top: 50,
            right: 20,
            child: FloatingActionButton(
              mini: true,
              backgroundColor: Colors.white,
              onPressed: () => _scaffoldKey.currentState!.openEndDrawer(),
              child: const Icon(Icons.menu, color: Colors.black87),
            ),
          ),

          // ۴. بخش هوشمند پایین صفحه (UX مورد نظر تو)
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
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        boxShadow: [BoxShadow(blurRadius: 15, color: Colors.black12)],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // مرحله اول: تایید مبدأ
          if (_currentStep == 0) ...[
            const Text("مبدأ سفر «سفیر» را تنظیم کنید", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 15),
            _buildActionButton("تأیید مبدأ", Colors.blueAccent, () {
              setState(() => _currentStep = 1);
            }),
          ] 
          // مرحله دوم: تایید مقصد (با قابلیت پنهان/کمرنگ بودن دکمه)
          else if (_currentStep == 1) ...[
            const Text("مقصد نهایی را انتخاب کنید", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 15),
            _buildActionButton(
              "تأیید مقصد", 
              _destinationLocation == null ? Colors.grey.shade400 : Colors.green, 
              _destinationLocation == null ? null : () => setState(() => _currentStep = 2)
            ),
            TextButton(
              onPressed: () => setState(() => _currentStep = 0),
              child: const Text("تغییر مبدأ", style: TextStyle(color: Colors.grey)),
            )
          ] 
          // مرحله سوم: انتخاب نوع موتر با استایل مدرن
          else if (_currentStep == 2) ...[
            const Text("نوع سرویس سفیر را انتخاب کنید", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 10),
            _buildVehicleSelection(),
            const SizedBox(height: 15),
            _buildActionButton("درخواست نهایی سفیر", Colors.orangeAccent, () {
              // اینجا کد ارسال درخواست به راننده قرار می‌گیرد
            }),
            TextButton(
              onPressed: () => setState(() => _currentStep = 1),
              child: const Text("بازگشت به انتخاب مقصد", style: TextStyle(color: Colors.grey)),
            )
          ],
        ],
      ),
    );
  }

  Widget _buildActionButton(String label, Color color, VoidCallback? onPressed) {
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
        child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildVehicleSelection() {
    return SizedBox(
      height: 140,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _vehicleItem("سفیر اقتصادی", "assets/taxi.png", "85 AFN", Colors.orange),
          _vehicleItem("سفیر باربر", "assets/truck.png", "210 AFN", Colors.blue),
          _vehicleItem("سفیر موتر", "assets/bike.png", "40 AFN", Colors.green),
          _vehicleItem("سفیر لوکس", "assets/vip.png", "380 AFN", Colors.purple),
        ],
      ),
    );
  }

  Widget _vehicleItem(String name, String img, String price, Color color) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 10, top: 5, bottom: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.directions_car_filled, color: color, size: 40), // موقت تا عکس‌ها را بگذاری
          const SizedBox(height: 5),
          Text(name, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
          Text(price, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
