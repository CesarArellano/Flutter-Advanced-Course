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
  final Duration duration;
  
  RouteTransitions({
    required this.context, 
    required this.child, 
    this.animation = AnimationType.material,
    this.duration = const Duration( milliseconds:  300 )
  }) {
    switch (animation) {
      case AnimationType.material:
        _materialNavigation();
        break;
      case AnimationType.cupertino:
        _cupertinoNavigation();
        break;
      case AnimationType.fadeIn:
        _fadeInNavigation();
        break;
      default:
        _materialNavigation();
      break;
    }
    
    
  }

  void _materialNavigation() => Navigator.push(context, MaterialPageRoute( builder: (_) => child ));

  void _cupertinoNavigation() => Navigator.push(context, CupertinoPageRoute(builder: (_) => child ));

  void _fadeInNavigation() {

    final route = PageRouteBuilder(
      pageBuilder: ( _, __, ___ ) => this.child,
      transitionDuration: this.duration,
      transitionsBuilder: ( _, animation, __, child ) {
        return FadeTransition(
          child: child,
          opacity: Tween<double>( begin: 0.0, end: 1.0).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeOut )
          ),
        );
      }
    );

    Navigator.push(context, route);

  }
}