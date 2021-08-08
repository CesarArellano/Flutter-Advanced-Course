import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stripe_app/bloc/pay/pay_bloc.dart';
import 'package:stripe_app/helpers/helpers.dart';
import 'package:stripe_app/services/stripe_service.dart';
import 'package:stripe_payment/stripe_payment.dart';

class TotalPayButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final textStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
    final payBloc = BlocProvider.of<PayBloc>(context).state;

    return Container(
      width: width,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30)
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Total', style: textStyle),
              Text('${payBloc.paymentAmount} ${ payBloc.currency }', style: TextStyle(fontSize: 20))
            ],
          ),
          _BtnPay()
        ],
      )
    );
  }
}

class _BtnPay extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PayBloc,PayState>(
      builder: ( _, state ) {
        return (state.activeCard)
          ? buildCreditCardPay(context)
          : buildAppleAndGooglePay(context);
      }
    );
      
  }

  Widget buildAppleAndGooglePay(BuildContext context) {
    return MaterialButton(
      height: 45,
      minWidth: 150,
      shape: StadiumBorder(),
      elevation: 0,
      color: Colors.black,
      child: Row(
        children: [
          FaIcon( 
            Platform.isAndroid
            ? FontAwesomeIcons.google 
            : FontAwesomeIcons.apple,
            color: Colors.white
          ),
          SizedBox(width: 10),
          Text('Pay', style: TextStyle(color: Colors.white, fontSize: 22)),
        ],
      ),
      onPressed: () {
        
      },
    );
  }

  Widget buildCreditCardPay( BuildContext context ) {
    return MaterialButton(
      height: 45,
      minWidth: 150,
      shape: StadiumBorder(),
      elevation: 0,
      color: Colors.black,
      child: Row(
        children: [
          FaIcon(FontAwesomeIcons.creditCard, color: Colors.white ),
          SizedBox(width: 10),
          Text('Pay', style: TextStyle(color: Colors.white, fontSize: 22),),
        ],
      ),
      onPressed: () async {

        showLoading(context);

        final payBlocState = BlocProvider.of<PayBloc>(context).state;
        final stripeService = new StripeService();
        final card = payBlocState.card;
        final monthYear = card!.expiracyDate.split('/');

        final resp = await stripeService.payWithExistingCard(
          amount: payBlocState.paymentAmountString,
          currency: payBlocState.currency, 
          card: CreditCard(
            number: card.cardNumber,
            expMonth: int.parse( monthYear[0] ),
            expYear: int.parse( monthYear[1] ),
          )
        );

        Navigator.pop(context);
        
        if( resp.ok ) {
          showAlert( context, 'Tarjeta Ok', 'Todo correcto' );
        } else {
          showAlert( context, 'Algo salió mal', resp.msg );
        }
      },
    );
  }
}