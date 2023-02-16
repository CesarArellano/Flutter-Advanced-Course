import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {

  final Color bgColor;
  final bool big;
  final String text;
  final Color textColor;

  final Function onPressed;

  const CalculatorButton({
    Key? key, 
    bgColor,
    this.big = false, 
    required this.text, 
    required this.onPressed,
    this.textColor = Colors.white
  }): bgColor = bgColor ?? const Color(0xff313131),
      super(key: key);
      

  @override
  Widget build(BuildContext context) {
    // Button
    final buttonStyle = TextButton.styleFrom(
        backgroundColor: bgColor,
        foregroundColor: Colors.white,
    );

    return Container(
      margin: const EdgeInsets.only( bottom: 10, right: 5, left: 5 ),
      child: TextButton(
        style: buttonStyle,
        child: SizedBox(
          width: big ? 150 : 65,
          height: 65,
          child: Center(
            child: Text(
              text, 
              style: TextStyle(
                color: textColor,
                fontSize: 34,
                fontWeight: FontWeight.w500 
              ), 
              textAlign: TextAlign.left,
            ),
          ),
        ),
        onPressed: () => onPressed(),
      ),
    );
  }
}