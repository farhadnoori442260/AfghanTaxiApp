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
          // لایه نقشه (شبیه‌ساز)
          Container(
            color: Colors.blue[50],
            child: const Center(child: Icon(Icons.map, size: 80, color: Colors.blue)),
          ),
          
          // دکمه‌های شناور هماهنگ شده در پایین سمت راست
          Positioned(
            bottom: 24,
            right: 24,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FloatingActionButton(
                  heroTag: "btn1",
                  onPressed: () {},
                  child: const Icon(Icons.my_location),
                ),
                const SizedBox(height: 12),
                FloatingActionButton(
                  heroTag: "btn2",
                  backgroundColor: Colors.blue,
                  onPressed: () {},
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
