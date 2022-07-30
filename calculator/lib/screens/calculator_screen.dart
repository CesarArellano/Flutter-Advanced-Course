import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/calculator_controller.dart';
import '../widgets/calc_button.dart';
import '../widgets/math_results.dart';

class CalculatorScreen extends StatelessWidget {


  CalculatorScreen({Key? key}) : super(key: key);
  final calculatorCtrl = Get.put( CalculatorController() );
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric( horizontal: 10 ),
          child: Column(
            children: [
              Expanded(
                child: Container(),
              ),
              MathResults(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CalculatorButton( 
                    text: 'AC',
                    bgColor: const Color(0xffA5A5A5 ),
                    onPressed: () => calculatorCtrl.resetAll(),
                  ),
                  CalculatorButton( 
                    text: '+/-',
                    bgColor: const Color(0xffA5A5A5 ),
                    onPressed: () => calculatorCtrl.changeNegativePositive(),
                  ),
                  CalculatorButton( 
                    text: 'del',
                    bgColor: const Color(0xffA5A5A5 ),
                    onPressed: () => calculatorCtrl.deleteLastEntry(),
                  ),
                  CalculatorButton( 
                    text: '/',
                    bgColor: const Color(0xffF0A23B ),
                    onPressed: () => calculatorCtrl.selectOperation('/'),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CalculatorButton( 
                    text: '7',
                    onPressed: () => calculatorCtrl.addNumber('7'),
                  ),
                  CalculatorButton( 
                    text: '8',
                    onPressed: () => calculatorCtrl.addNumber('8'),
                  ),
                  CalculatorButton( 
                    text: '9',
                    onPressed: () => calculatorCtrl.addNumber('9'),
                  ),
                  CalculatorButton( 
                    text: 'X',
                    bgColor: const Color(0xffF0A23B ),
                    onPressed: () => calculatorCtrl.selectOperation('X'),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CalculatorButton( 
                    text: '4', 
                    onPressed: () => calculatorCtrl.addNumber('4'),
                  ),
                  CalculatorButton( 
                    text: '5', 
                    onPressed: () => calculatorCtrl.addNumber('5'),
                  ),
                  CalculatorButton( 
                    text: '6', 
                    onPressed: () => calculatorCtrl.addNumber('6'),
                  ),
                  CalculatorButton( 
                    text: '-',
                    bgColor: const Color(0xffF0A23B ),
                    onPressed: () => calculatorCtrl.selectOperation('-'),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CalculatorButton( 
                    text: '1', 
                    onPressed: () => calculatorCtrl.addNumber('1'),
                  ),
                  CalculatorButton( 
                    text: '2', 
                    onPressed: () => calculatorCtrl.addNumber('2'),
                  ),
                  CalculatorButton( 
                    text: '3', 
                    onPressed: () => calculatorCtrl.addNumber('3'),
                  ),
                  CalculatorButton(
                    text: '+',  
                    bgColor: const Color(0xffF0A23B ),
                    onPressed: () => calculatorCtrl.selectOperation('+'),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CalculatorButton( 
                    text: '0', 
                    big: true,
                    onPressed: () => calculatorCtrl.addNumber('0'),
                  ),
                  CalculatorButton( 
                    text: '.', 
                    onPressed: () => calculatorCtrl.addDecimalPoint(),
                  ),
                  CalculatorButton( 
                    text: '=',
                    bgColor: const Color(0xffF0A23B ),
                    onPressed: () => calculatorCtrl.calculateResult(),
                  ),
                ],
              ),
            ],
          ),
        ),
      )
   );
  }
}