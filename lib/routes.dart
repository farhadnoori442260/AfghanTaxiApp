import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/map': (context) => const MapScreen(),
};

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: const Color(0xFFF5F5F5),
            child: const Center(child: Icon(Icons.map, size: 80, color: Color(0xFF145A41))),
          ),
          Positioned(
            bottom: 24,
            right: 24,
            child: Column(
              children: [
                FloatingActionButton(
                  heroTag: "btn_loc",
                  backgroundColor: Colors.white,
                  onPressed: () {},
                  child: const Icon(Icons.my_location, color: Color(0xFF145A41)),
                ),
                const SizedBox(height: 12),
                FloatingActionButton(
                  heroTag: "btn_add",
                  backgroundColor: const Color(0xFF145A41),
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
