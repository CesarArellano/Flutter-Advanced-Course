import 'package:calculadora/controllers/calculator_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:calculadora/widgets/line_separator.dart';
import 'package:calculadora/widgets/main_result.dart';
import 'package:calculadora/widgets/sub_result.dart';

class MathResults extends StatelessWidget {
  final calculatorCtrl = Get.find<CalculatorController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          SubResult( text: '${ calculatorCtrl.firstNumber }' ),
          SubResult( text: '${ calculatorCtrl.operation }' ),
          SubResult( text: '${ calculatorCtrl.secondNumber }' ),
          LineSeparator(),
          MainResultText( text: '${ calculatorCtrl.mathResult }' ),
        ],
      ),
    );
  }
}