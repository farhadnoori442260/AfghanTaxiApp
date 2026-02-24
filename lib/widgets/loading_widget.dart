import 'package:flutter/material.dart';
import '../utils/colors.dart';

class LoadingWidget extends StatelessWidget {
  final String message;
  const LoadingWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(color: SafirColors.primaryGreen),
          const SizedBox(height: 15),
          Text(message, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
