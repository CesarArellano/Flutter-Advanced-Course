import 'package:dio/dio.dart';
import 'package:stripe_app/models/payment_intent_response.dart';
import 'package:stripe_app/models/stripe_custom_response.dart';
import 'package:stripe_payment/stripe_payment.dart';

class StripeService {
  // Singleton
  StripeService._privateConstructor();
  static final StripeService _instance = StripeService._privateConstructor();
  factory StripeService() => _instance;

  String _paymentApiUrl = 'https://api.stripe.com/v1/payment_intents';
  static String _secretKey = 'sk_test_51JM0pDKHJXm8xHtbIGir68wpge2LxIIMXfUV0EaNcY5Asv6xUPSmCtLQdRBTXjgOtC5zoc6TDsn9wlTMXYrdStUi00A6OO52yf';
  String _apiKey = 'pk_test_51JM0pDKHJXm8xHtbOA5IoPaq68kvFa6fZl7yU1FSR0Q2lTcKulqwUFKYrnWryYQBF5QLMqwqL3MO4Ux1hymiUg6x00G9vcdnt6';

  final headerOptions = new Options(
    contentType: Headers.formUrlEncodedContentType,
    headers: {
      'Authorization': 'Bearer ${ StripeService._secretKey }'
    }
  );

  void init() {
    StripePayment.setOptions(
      StripeOptions(
        publishableKey: this._apiKey,
        androidPayMode: 'test',
        merchantId: 'test'
      )
    );
  }

  Future<StripeCustomResponse> payWithExistingCard({
    required String amount,
    required String currency,
    required CreditCard card,
  }) async {
    try {
      final paymentMethod = await StripePayment.createPaymentMethod(
        PaymentMethodRequest(card: card)
      );
      
      final resp = await this._makePayment(
        amount: amount,
        currency: currency,
        paymentMethod: paymentMethod
      );

      return resp;

    } catch (e) {
      return StripeCustomResponse(
        ok: false,
        msg: e.toString()
      );
    }
  }

  Future<StripeCustomResponse> payWithNewCard({
    required String amount,
    required String currency
  }) async {
    try {
      final paymentMethod = await StripePayment.paymentRequestWithCardForm(
        CardFormPaymentRequest()
      );
      
      final resp = await this._makePayment(
        amount: amount,
        currency: currency,
        paymentMethod: paymentMethod
      );

      return resp;

    } catch (e) {
      return StripeCustomResponse(
        ok: false,
        msg: e.toString()
      );
    }
  }

  Future payApplePayGooglePay({
    required String amount,
    required String currency,
  }) async {

  }

  Future<PaymentIntentResponse> _createPaymentIntent({
    required String amount,
    required String currency,
  }) async {
    try {
      final dio = new Dio();
      
      final data = {
        'amount': amount,
        'currency': currency
      };

      final resp = await dio.post(
        _paymentApiUrl,
        data: data,
        options: headerOptions
      );

      return PaymentIntentResponse.fromJson( resp.data );

    } catch (e) {
      print('Error: ${ e.toString() }');
      return PaymentIntentResponse(status: '400');
    }
  }

  Future _makePayment({
    required String amount,
    required String currency,
    required PaymentMethod paymentMethod
  }) async {
    try {

      final paymentIntent = await this._createPaymentIntent(
        amount: amount,
        currency: currency
      );

      final confirmPayment = await StripePayment.confirmPaymentIntent(
        PaymentIntent( 
          clientSecret: paymentIntent.clientSecret,
          paymentMethodId: paymentMethod.id
        )
      );

      if( confirmPayment.status == 'succeeded' ) {
        return StripeCustomResponse(ok: true);
      } else {
        return StripeCustomResponse(ok: false, msg: 'Falló pago: ${ confirmPayment.status }');
      }


      
    } catch (e) {
      print('Error: ${ e.toString() }');
      return PaymentIntentResponse(status: '400');
    }
  }


}