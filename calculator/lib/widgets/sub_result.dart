import 'package:flutter/material.dart';

class SubResult extends StatelessWidget {

  final String text;

  const SubResult({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.centerRight,
      child: Text( text , style: const TextStyle(fontSize: 30 ) ),
    );
  }
}