import 'package:flutter/material.dart';
import 'models/driver_model.dart';
import 'services/driver_service.dart';

void main() {
  runApp(const TestApp());
}

class TestApp extends StatelessWidget {
  const TestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DriverTestScreen(),
    );
  }
}

class DriverTestScreen extends StatefulWidget {
  @override
  _DriverTestScreenState createState() => _DriverTestScreenState();
}

class _DriverTestScreenState extends State<DriverTestScreen> {
  final DriverService _driverService = DriverService();

  @override
  void initState() {
    super.initState();
    // راننده تستی اضافه کنیم
    _driverService.addDriver(
      Driver(
        id: "1",
        name: "Ahmad",
        phone: "+9370000000",
        carNumber: "KBL-1234",
        isOnline: false,
        location: "Kabul",
      ),
    );

    // راننده رو آنلاین کنیم
    _driverService.updateDriverStatus("1", true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Driver Test")),
      body: ListView(
        children: _driverService.getAllDrivers().map((driver) {
          return ListTile(
            title: Text(driver.name),
            subtitle: Text("Car: ${driver.carNumber} | Phone: ${driver.phone}"),
            trailing: Icon(
              driver.isOnline ? Icons.circle : Icons.circle_outlined,
              color: driver.isOnline ? Colors.green : Colors.red,
            ),
          );
        }).toList(),
      ),
    );
  }
}