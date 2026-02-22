import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const MapScreen(),
};

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // بخش نقشه (فعلاً به صورت شبیه‌ساز)
          Container(color: Colors.grey[200], child: const Center(child: Icon(Icons.map, size: 100))),
          
          // دکمه‌های شناور در پایین سمت راست
          Positioned(
            bottom: 20,
            right: 20,
            child: Column(
              children: [
                FloatingActionButton(
                  onPressed: () {},
                  child: const Icon(Icons.my_location),
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  onPressed: () {},
                  backgroundColor: Colors.blueAccent,
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
