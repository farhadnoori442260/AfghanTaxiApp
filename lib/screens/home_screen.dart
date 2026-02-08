import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showPanel = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("صفحه اصلی مسافر"),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              setState(() {
                showPanel = !showPanel;
              });
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          const Center(
            child: Text(
              "نقشه یا محتوای اصلی اینجاست",
              style: TextStyle(fontSize: 18),
            ),
          ),
          if (showPanel)
            Positioned(
              top: 20,
              right: 10,
              child: Container(
                width: 220,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(color: Colors.black26, blurRadius: 8),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("👤 مشخصات مسافر"),
                    SizedBox(height: 10),
                    Text("📞 مخاطبین"),
                    SizedBox(height: 10),
                    Text("⚙️ تنظیمات"),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}