import 'package:flutter/material.dart';

class BlueBtn extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const BlueBtn({
    Key? key,
    required this.onPressed,
    this.text = 'Ingresar',
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 2, 
        shape: const StadiumBorder(),
        disabledForegroundColor: Colors.grey,
        animationDuration: const Duration(milliseconds: 300),
        
      ),  
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: Center(
          child: Text(text, style: const TextStyle(fontSize: 16.0))
        )
      )
    );
  }
}