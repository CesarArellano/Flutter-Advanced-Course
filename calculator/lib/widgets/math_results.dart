import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/calculator_controller.dart';
import 'line_separator.dart';
import 'main_result.dart';
import 'sub_result.dart';

class MathResults extends StatelessWidget {
  final calculatorCtrl = Get.find<CalculatorController>();

  MathResults({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          SubResult( text: '${ calculatorCtrl.firstNumber }' ),
          SubResult( text: '${ calculatorCtrl.operation }' ),
          SubResult( text: '${ calculatorCtrl.secondNumber }' ),
          const LineSeparator(),
          MainResultText( text: '${ calculatorCtrl.mathResult }' ),
        ],
      ),
    );
  }
}