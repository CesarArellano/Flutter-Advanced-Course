import 'package:flutter/material.dart';

class BlueBtn extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  BlueBtn({
    @required this.onPressed,
    this.text = 'Ingresar',
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: this.onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 2, 
        shape: StadiumBorder(),
        animationDuration: Duration(milliseconds: 300)
      ),  
      child: Container(
        width: double.infinity,
        height: 50,
        child: Center(
          child: Text(this.text, style: TextStyle(fontSize: 16.0))
        )
      )
    );
  }
}