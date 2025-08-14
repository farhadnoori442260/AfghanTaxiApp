import 'package:flutter_stripe/flutter_stripe.dart';

class PaymentService {
  Future<void> initStripe(String publishableKey) async {
    Stripe.publishableKey = publishableKey;
    await Stripe.instance.applySettings();
  }

  Future<void> makePayment(int amount, String currency) async {
    try {
      await Stripe.instance.presentPaymentSheet();
    } catch (e) {
      rethrow;
    }
  }
}