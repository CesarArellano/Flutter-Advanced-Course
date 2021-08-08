import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

enum AnimationType {
  material,
  cupertino,
  fadeIn,
  slideUp,
  slideDown,
  slideLeft,
  slideRight,
  rotation,
  zoomIn,
}

class PageTransitions {
  
  final BuildContext context;
  final Widget child;
  final AnimationType animation;
  final Duration duration;
  final Duration reverseDuration;
  final RouteSettings? settings;
  final bool replacement;
  final bool fullscreenDialog;
  final Curve curve;
  
  PageTransitions({
    required this.context, 
    required this.child,
    this.animation = AnimationType.material,
    this.duration = const Duration( milliseconds: 300 ),
    this.reverseDuration = const Duration( milliseconds: 300 ),
    this.settings,
    this.replacement = false,
    this.fullscreenDialog = false,
    this.curve = Curves.easeOut
  }) {

    Route route;

    switch (animation) {
      case AnimationType.material:
        route = _materialNavigation();
        break;
      case AnimationType.cupertino:
        route = _cupertinoNavigation();
        break;
      case AnimationType.fadeIn:
        route = _transitiontNavigation( _fadeInTransition );
        break;
      case AnimationType.slideUp:
        route = _transitiontNavigation( _slideUpTransition );
        break;
      case AnimationType.slideDown:
        route = _transitiontNavigation( _slideDownTransition );
        break;
      case AnimationType.slideLeft:
        route = _transitiontNavigation( _slideLeftTransition );
        break;
      case AnimationType.slideRight:
        route = _transitiontNavigation( _slideRightTransition );
        break;
      case AnimationType.rotation:
        route = _transitiontNavigation( _rotationTransition );
        break;
      case AnimationType.zoomIn:
        route = _transitiontNavigation( _zoomInTransition );
        break;
      default:
        route = _materialNavigation();
      break;
    }

    (this.replacement ) 
      ? Navigator.pushReplacement(context, route)
      : Navigator.push(context, route);
  }

  Route _materialNavigation() => MaterialPageRoute( 
    builder: (_) => this.child,
    fullscreenDialog: this.fullscreenDialog,
    settings: this.settings 
  );

  Route _cupertinoNavigation() => CupertinoPageRoute( 
    builder: (_) => this.child,
    fullscreenDialog: this.fullscreenDialog,
    settings: this.settings 
  );

  Route _transitiontNavigation( Function transitionType ) {
    return PageRouteBuilder(
      settings: this.settings,
      fullscreenDialog: this.fullscreenDialog, 
      pageBuilder: ( _, __, ___ ) => this.child,
      transitionDuration: this.duration,
      reverseTransitionDuration: this.reverseDuration,
      transitionsBuilder: ( _, animation, __, child ) {
        final curveAnimation = CurvedAnimation(parent: animation, curve: this.curve);
        return transitionType(curveAnimation);
      }
    );
  }

  Widget _fadeInTransition(Animation<double> curveAnimation) {
    return FadeTransition(
      opacity: Tween<double>(begin: 0.0, end: 1.0).animate(curveAnimation),
      child: child,
    );
  }

  Widget _slideUpTransition( Animation<double> curveAnimation ) {
    return SlideTransition(
      position: Tween<Offset>( begin: Offset(0.0, 1.0), end: Offset.zero ).animate(curveAnimation),
      child: child,
    );
  }

  Widget _slideDownTransition( Animation<double> curveAnimation ) {
    return SlideTransition(
      position: Tween<Offset>( begin: Offset(0.0, - 1.0), end: Offset.zero ).animate(curveAnimation),
      child: child,
    );
  }

  Widget _slideLeftTransition( Animation<double> curveAnimation ) {
    return SlideTransition(
      position: Tween<Offset>( begin: Offset(-1.0, 0.0), end: Offset.zero ).animate(curveAnimation),
      child: child,
    );
  }

  Widget _slideRightTransition( Animation<double> curveAnimation ) {
    return SlideTransition(
      position: Tween<Offset>( begin: Offset(1.0, 0.0), end: Offset.zero ).animate(curveAnimation),
      child: child,
    );
  }

  Widget _rotationTransition( Animation<double> curveAnimation ) {
    return RotationTransition(  
      turns: Tween<double>(begin: 0.5, end: 1.0).animate(curveAnimation),
      child: FadeTransition(
        opacity: Tween<double>(begin: 0.0, end: 1.0).animate(curveAnimation),
        child: child,
      ),
    );
  }

  Widget _zoomInTransition( Animation<double> curveAnimation ) {
    return ScaleTransition(
      scale: Tween<double>(begin: 0.0, end: 1.0).animate(curveAnimation),
      child: child,
    );
  }

}