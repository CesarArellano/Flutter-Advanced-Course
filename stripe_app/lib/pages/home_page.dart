import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:stripe_app/bloc/pay/pay_bloc.dart';
import 'package:stripe_app/data/cards.dart';
import 'package:stripe_app/helpers/helpers.dart';
import 'package:stripe_app/pages/card_page.dart';
import 'package:stripe_app/widgets/total_pay_button.dart';


class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Pay'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              // showLoading(context);
              // await Future.delayed(Duration(seconds: 1));
              // Navigator.pop(context);
              showAlert(context, 'Hello', 'This is a message');
            }, 
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            width: size.width,
            height: size.height,
            top: 200,
            child: PageView.builder(
              physics: BouncingScrollPhysics(),
              controller: PageController(
                viewportFraction: 0.85
              ),
              itemCount: cards.length,
              itemBuilder: (_ , i) {
                final card = cards[i];

                return GestureDetector(
                  onTap: () {
                    final payBloc = BlocProvider.of<PayBloc>(context);
                    payBloc.add( OnSelectedCard(card) );
                    Navigator.push(context, navigateFadeIn(context, CardPage()));
                  },
                  child: Hero(
                    tag: card.cardNumber,
                    child: CreditCardWidget(
                      cardNumber: card.cardNumber, 
                      expiryDate: card.expiracyDate, 
                      cardHolderName: card.cardHolderName, 
                      cvvCode: card.cvv, 
                      showBackView: false,  
                    ),
                  ),
                );
              },
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