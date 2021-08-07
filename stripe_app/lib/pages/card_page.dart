import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:stripe_app/bloc/pay/pay_bloc.dart';

import 'package:stripe_app/widgets/total_pay_button.dart';

class CardPage extends StatelessWidget {
  
  
  @override
  Widget build(BuildContext context) {
    final card = BlocProvider.of<PayBloc>(context).state.card;

    return Scaffold(
      appBar: AppBar(
        title: Text('Pay'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            BlocProvider.of<PayBloc>(context).add( OnDeactivateCard() );
            Navigator.pop(context);
          },
        )
      ),
      body: Stack(
        children: <Widget>[
          Container(),

          Hero(
            tag: card!.cardNumber,
            child: CreditCardWidget(
              cardNumber: card.cardNumber, 
              expiryDate: card.expiracyDate, 
              cardHolderName: card.cardHolderName, 
              cvvCode: card.cvv, 
              showBackView: false,  
            ),
          ),
          Positioned(
            bottom: 0,
            child: TotalPayButton(),
          )
        ],
      )
    );
  }
}