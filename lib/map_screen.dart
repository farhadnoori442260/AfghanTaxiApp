import 'package:flutter/material.dart';
import 'utils/colors.dart';
import 'utils/helper.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  int _currentStep = 0; // 0: مبدأ، 1: مقصد، 2: انتخاب سرویس

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ۱. شبیه‌ساز نقشه
          Container(
            color: Colors.grey[200],
            child: const Center(
              child: Icon(Icons.map, size: 100, color: Colors.grey),
            ),
          ),

          // ۲. پین هوشمند وسط نقشه (متصل به Helper)
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
                        _currentStep == 0 ? tr(context, 'origin') : tr(context, 'destination'),
                        style: const TextStyle(color: Colors.white, fontSize: 12),
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

          // ۳. دکمه بازگشت
          Positioned(
            top: 50,
            left: 20,
            child: FloatingActionButton(
              mini: true,
              backgroundColor: Colors.white,
              onPressed: () => Navigator.pop(context),
              child: const Icon(Icons.arrow_back, color: SafirColors.primaryGreen),
            ),
          ),

          // ۴. پنل پایین صفحه
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
            Text(tr(context, 'where_to'), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: SafirColors.primaryGreen)),
            const SizedBox(height: 15),
            _buildActionButton("${tr(context, 'confirm')} ${tr(context, 'origin')}", SafirColors.primaryGreen, () => setState(() => _currentStep = 1)),
          ] 
          else if (_currentStep == 1) ...[
            Text(tr(context, 'destination'), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 15),
            _buildActionButton("${tr(context, 'confirm')} ${tr(context, 'destination')}", SafirColors.primaryGreen, () => setState(() => _currentStep = 2)),
            TextButton(onPressed: () => setState(() => _currentStep = 0), child: Text(tr(context, 'origin'), style: const TextStyle(color: Colors.grey)))
          ] 
          else if (_currentStep == 2) ...[
            Text(tr(context, 'vehicle_type'), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 15),
            _buildVehicleSelection(),
            const SizedBox(height: 20),
            _buildActionButton(tr(context, 'request_ride'), SafirColors.primaryGreen, () {
              // نمایش لودینگ جستجوی راننده
            }),
            TextButton(onPressed: () => setState(() => _currentStep = 1), child: Text(tr(context, 'cancel'), style: const TextStyle(color: Colors.grey)))
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
        style: ElevatedButton.styleFrom(backgroundColor: color, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
        onPressed: onPressed,
        child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildVehicleSelection() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _vehicleItem(tr(context, 'safir_taxi'), Icons.directions_car, "120 ${tr(context, 'afn')}", SafirColors.primaryGreen),
          _vehicleItem(tr(context, 'safir_cargo'), Icons.local_shipping, "350 ${tr(context, 'afn')}", Colors.blueGrey),
          _vehicleItem(tr(context, 'safir_bike'), Icons.motorcycle, "60 ${tr(context, 'afn')}", Colors.orange),
        ],
      ),
    );
  }

  Widget _vehicleItem(String name, IconData icon, String price, Color color) {
    return Container(
      width: 110,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: color.withOpacity(0.05), borderRadius: BorderRadius.circular(20), border: Border.all(color: color.withOpacity(0.2))),
      child: Column(
        children: [
          Icon(icon, color: color, size: 30),
          Text(name, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
          Text(price, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
