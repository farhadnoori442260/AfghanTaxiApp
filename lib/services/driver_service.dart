import '../models/driver_model.dart';

class DriverService {
  List<Driver> _drivers = [];

  // اضافه کردن راننده جدید
  void addDriver(Driver driver) {
    _drivers.add(driver);
  }

  // گرفتن لیست همه راننده‌ها
  List<Driver> getAllDrivers() {
    return _drivers;
  }

  // تغییر وضعیت آنلاین/آفلاین
  void updateDriverStatus(String driverId, bool isOnline) {
    for (var driver in _drivers) {
      if (driver.id == driverId) {
        driver = Driver(
          id: driver.id,
          name: driver.name,
          phoneNumber: driver.phoneNumber,
          carModel: driver.carModel,
          carNumber: driver.carNumber,
          isOnline: isOnline,
          latitude: driver.latitude,
          longitude: driver.longitude,
        );
      }
    }
  }

  // آپدیت لوکیشن راننده
  void updateDriverLocation(String driverId, double lat, double lng) {
    for (var driver in _drivers) {
      if (driver.id == driverId) {
        driver = Driver(
          id: driver.id,
          name: driver.name,
          phoneNumber: driver.phoneNumber,
          carModel: driver.carModel,
          carNumber: driver.carNumber,
          isOnline: driver.isOnline,
          latitude: lat,
          longitude: lng,
        );
      }
    }
  }
}