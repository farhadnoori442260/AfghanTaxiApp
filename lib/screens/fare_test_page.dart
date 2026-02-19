import 'package:flutter/material.dart';
import '../logic/fare_calculator.dart';
import '../utils/colors.dart';

class FareTestPage extends StatefulWidget {
  const FareTestPage({Key? key}) : super(key: key);

  @override
  _FareTestPageState createState() => _FareTestPageState();
}

class _FareTestPageState extends State<FareTestPage> {
  final TextEditingController _distanceController = TextEditingController();
  Map<String, double>? _result;

  // تنظیمات پایه قیمت‌گذاری سفیر
  final FareCalculator calculator = FareCalculator(
    basePrice: 50,      // قیمت پایه
    pricePerKm: 20,     // نرخ هر کیلومتر
    commissionPercent: 10, // کمیسیون سفیر
  );

  void _calculateFare() {
    double distance = double.tryParse(_distanceController.text) ?? 0;
    if (distance > 0) {
      setState(() {
        _result = calculator.calculate(distance);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAF9),
      appBar: AppBar(
        title: const Text('تست هوشمند کرایه سفیر', 
          style: TextStyle(fontFamily: 'IranYekan', fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: SafirColors.primaryGreen,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // کارت ورودی
            _buildInputCard(),
            
            const SizedBox(height: 25),
            
            // نمایش نتایج محاسبات
            if (_result != null) _buildResultSection()
            else _buildEmptyState(),
          ],
        ),
      ),
    );
  }

  Widget _buildInputCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 15)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("فاصله سفر را وارد کنید", 
            style: TextStyle(fontFamily: 'IranYekan', fontWeight: FontWeight.bold, color: Colors.black87)),
          const SizedBox(height: 15),
          TextField(
            controller: _distanceController,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: SafirColors.primaryGreen),
            decoration: InputDecoration(
              suffixText: 'کیلومتر',
              suffixStyle: const TextStyle(fontFamily: 'IranYekan', fontSize: 14),
              filled: true,
              fillColor: const Color(0xFFF1F5F9),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
              hintText: 'مثلاً ۵.۵',
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _calculateFare,
            style: ElevatedButton.styleFrom(
              backgroundColor: SafirColors.primaryGreen,
              minimumSize: const Size(double.infinity, 55),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              elevation: 0,
            ),
            child: const Text('محاسبه آنی کرایه', 
              style: TextStyle(fontFamily: 'IranYekan', fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildResultSection() {
    return Column(
      children: [
        _resultTile("کل کرایه مسافر", "${_result!['price']?.toInt()} AFN", SafirColors.primaryGreen, Icons.payments_outlined),
        const SizedBox(height: 12),
        _resultTile("سهم اپلیکیشن (۱۰٪)", "${_result!['commission']?.toInt()} AFN", Colors.blueGrey, Icons.account_balance_outlined),
        const SizedBox(height: 12),
        _resultTile("درآمد خالص راننده", "${_result!['driverEarn']?.toInt()} AFN", Colors.orange.shade700, Icons.wallet_outlined),
        
        const SizedBox(height: 30),
        // نمایش فرمول برای شفافیت
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(color: Colors.amber.withOpacity(0.1), borderRadius: BorderRadius.circular(15)),
          child: Row(
            children: const [
              Icon(Icons.info_outline, color: Colors.amber, size: 20),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  "فرمول: ۵۰ AFN پایه + هر کیلومتر ۲۰ AFN",
                  style: TextStyle(fontFamily: 'IranYekan', fontSize: 12, color: Colors.black54),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _resultTile(String title, String value, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withOpacity(0.1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 22),
              const SizedBox(width: 12),
              Text(title, style: const TextStyle(fontFamily: 'IranYekan', fontSize: 15, color: Colors.black87)),
            ],
          ),
          Text(value, style: TextStyle(fontFamily: 'IranYekan', fontSize: 18, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Column(
      children: [
        const SizedBox(height: 40),
        Icon(Icons.calculate_outlined, size: 80, color: Colors.grey.withOpacity(0.2)),
        const SizedBox(height: 10),
        const Text("هنوز محاسباتی انجام نشده است", 
          style: TextStyle(fontFamily: 'IranYekan', color: Colors.grey)),
      ],
    );
  }
}
