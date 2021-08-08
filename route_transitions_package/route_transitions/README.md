# Page Transitions

This package helps to handle the animations of the screen transitions in an elegant and simple way.

## Usage Example
```
PageTransitions(
  context: context, // BuildContext
  child: Page2(), // Widget
  animation: AnimationType.material, // AnimationType (package enum)
  duration: Duration( milliseconds:  300 ), // Duration
  reverseDuration: Duration( milliseconds:  300), // Duration
  curve: Curves.easeOut, // bool
  fullscreenDialog: false, // bool
  replacement: false, // bool 
  settings: RouteSettings() // RouteSettings 
);
```

## Params Explain
```
[context] is the BuildContext of the App, is required.
[child] is the screen/Widget to navigate, is required.
[animation] with this param it could change the animation, is optional.
[duration] is the animation duration, is optional.
[reverseDuration] is the reverse animation duration, is optional.
[settings] is the typical RouteSettings to send arguments, is optional.
[replacement] is the flag to navigate with pushReplacement, is optional.
[fullscreenDialog] is the flag that indicates if this new screen will be a full dialog, is optional.
[curve] is the typical Curves animation, is optional.
```
