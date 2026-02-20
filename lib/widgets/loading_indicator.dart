import 'package:flutter/material.dart';
import '../utils/helper.dart';
import '../utils/colors.dart';

class LoadingIndicator extends StatelessWidget {
  final String? textKey; // کلید ترجمه (مثلاً 'finding_driver')
  final Color? color;

  const LoadingIndicator({
    Key? key, 
    this.textKey, // اگر مقدار داده نشود، متن پیش‌فرض نمایش می‌یابد
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // استفاده از رنگ اختصاصی سفیر برای چرخ‌دنده لودینگ
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(color ?? SafirColors.primaryGreen),
            strokeWidth: 3,
          ),
          const SizedBox(height: 16),
          Text(
            // اگر کلیدی فرستاده نشده بود، از یک متن عمومی استفاده می‌کند
            textKey != null ? tr(context, textKey!) : tr(context, 'please_wait'),
            style: TextStyle(
              fontSize: 15,
              fontFamily: 'IranYekan',
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
