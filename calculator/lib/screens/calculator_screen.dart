import 'package:calculadora/theme/app_theme.dart';
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
                    textColor: Colors.black,
                    bgColor: AppTheme.darkGrayButtonColor,
                    onPressed: () => calculatorCtrl.resetAll(),
                  ),
                  CalculatorButton( 
                    text: '+/-',
                    textColor: Colors.black,
                    bgColor: AppTheme.darkGrayButtonColor,
                    onPressed: () => calculatorCtrl.changeNegativePositive(),
                  ),
                  CalculatorButton( 
                    text: 'del',
                    textColor: Colors.black,
                    bgColor: AppTheme.darkGrayButtonColor,
                    onPressed: () => calculatorCtrl.deleteLastEntry(),
                  ),
                  CalculatorButton( 
                    text: '÷',
                    bgColor: AppTheme.orangeButtonColor,
                    onPressed: () => calculatorCtrl.selectOperation('÷'),
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
                    bgColor: AppTheme.orangeButtonColor,
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
                    bgColor: AppTheme.orangeButtonColor,
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
                    bgColor: AppTheme.orangeButtonColor,
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
                    bgColor: AppTheme.orangeButtonColor,
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