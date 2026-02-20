import 'package:flutter/material.dart';
import '../utils/helper.dart';
import '../utils/colors.dart';

class RideCard extends StatelessWidget {
  final String driverName;
  final String carModelKey; // استفاده از کلید ترجمه برای نوع خودرو
  final String plateNumber;
  final double price; // تغییر به double برای محاسبات دقیق‌تر مالی
  final VoidCallback onTap;

  const RideCard({
    Key? key,
    required this.driverName,
    required this.carModelKey,
    required this.plateNumber,
    required this.price,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 3,
        shadowColor: Colors.black12,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // تصویر سفیر (راننده) با حاشیه رنگی وضعیت
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: SafirColors.primaryGreen, width: 2),
                ),
                child: const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey,
                  backgroundImage: AssetImage('assets/images/driver_placeholder.png'),
                ),
              ),
              const SizedBox(width: 16),
              // اطلاعات خودرو و راننده
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      driverName,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'IranYekan',
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(Icons.directions_car, size: 16, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text(
                          '${tr(context, carModelKey)} | $plateNumber',
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 13,
                            fontFamily: 'IranYekan',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // نمایش قیمت به واحد افغانی (سه‌زبانه)
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    price.toStringAsFixed(0),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.black,
                      color: SafirColors.primaryGreen,
                    ),
                  ),
                  Text(
                    tr(context, 'afn'),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
