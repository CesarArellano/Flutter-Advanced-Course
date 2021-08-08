import 'package:stripe_payment/stripe_payment.dart';

class StripeService {
  // Singleton
  StripeService._privateConstructor();
  static final StripeService _instance = StripeService._privateConstructor();
  factory StripeService() => _instance;

  String _paymentApiUrl = 'https://api.stripe.com/v1/payment_intents';
  String secretKey = 'sk_test_51JM0pDKHJXm8xHtbIGir68wpge2LxIIMXfUV0EaNcY5Asv6xUPSmCtLQdRBTXjgOtC5zoc6TDsn9wlTMXYrdStUi00A6OO52yf';

  void init() {

  }

  Future payWithExistingCard({
    required String amount,
    required String currency,
    required CreditCard card,
  }) async {

  }

  Future payWithNewCard({
    required String amount,
    required String currency
  }) async {

  }

  Future payApplePayGooglePay({
    required String amount,
    required String currency,
  }) async {

  }

  Future _createPaymentIntent({
    required String amount,
    required String currency,
  }) async {

  }

  Future _makePayment({
    required String amount,
    required String currency,
    required PaymentMethod paymentMethod
  }) async {

  }


}