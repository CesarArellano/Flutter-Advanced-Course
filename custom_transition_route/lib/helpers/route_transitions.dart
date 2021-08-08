import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

enum AnimationType {
  material,
  cupertino,
  fadeIn,
}

class RouteTransitions {
  final BuildContext context;
  final Widget child;
  final AnimationType animation;

  RouteTransitions({
    required this.context, 
    required this.child, 
    this.animation = AnimationType.material,
  }) {
    Navigator.push(context, MaterialPageRoute( builder: (_) => child ));
  }
}