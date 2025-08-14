import 'package:flutter/material.dart';

class MapPinWidget extends StatelessWidget {
  final String label;
  final Color color;

  const MapPinWidget({
    Key? key,
    required this.label,
    this.color = Colors.red,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(Icons.location_pin, color: color, size: 40),
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}