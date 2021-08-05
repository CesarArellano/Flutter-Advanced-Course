import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:stripe_app/data/cards.dart';
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
            onPressed: () {  }, 
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
                    print(card.brand);
                  },
                  child: CreditCardWidget(
                    cardNumber: card.cardNumber, 
                    expiryDate: card.expiracyDate, 
                    cardHolderName: card.cardHolderName, 
                    cvvCode: card.cvv, 
                    showBackView: false,
                    
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