import 'package:flutter/material.dart';
import 'package:custom_page_transitions/custom_page_transitions.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Custom Page Transitions App',
      initialRoute: 'page1',
      routes:  {
        'page1': (_) => Page1(),
        'page2': (_) => Page2(),
      },
    );
  }
}

class Page1 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page 1'),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.blue,
      body: Center(
        child: MaterialButton(
          child: Text('Go to page 2'),
          color: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          onPressed: () {
            PageTransitions(
              context: context,
              child: Page2(),
              animation: AnimationType.slideLeft,
              duration: Duration( milliseconds:  400 ),
              reverseDuration: Duration( milliseconds:  400),
              curve: Curves.decelerate,
              fullscreenDialog: false,
              replacement: false,
              settings: RouteSettings( arguments: 'argument' )
            );
          },
        )
      ),
    );
  }
}

class Page2 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    print(args);
    return Scaffold(
      appBar: AppBar(
        title: Text('Page 2'),
      ),
      body: Center(
        child: Text('Page 2'),
      ),
    );
  }
  
}