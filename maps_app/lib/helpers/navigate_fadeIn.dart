part of 'helpers.dart';

navigateMapFadeIn( BuildContext context , Widget page ) {
  return PageRouteBuilder(
    pageBuilder: ( _, __, ____ ) => page,
    transitionDuration: Duration( milliseconds: 300 ),
    transitionsBuilder: ( context, animation, _, child ) {
      return FadeTransition(
        child: child,
        opacity: Tween<double>( begin: 0.0, end: 1.0 ).animate(
          CurvedAnimation(parent: animation, curve: Curves.easeOut ),
        ),
      );
    }
  );
}