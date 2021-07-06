import 'package:flutter/material.dart';


class PageTwo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page Two'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
              child: Text('Set User', style: TextStyle(color: Colors.white)),
              color: Colors.blue,
              onPressed: () {}
            ),
            SizedBox(height: 10.0),
            MaterialButton(
              child: Text('Change Age', style: TextStyle(color: Colors.white)),
              color: Colors.red,
              onPressed: () {}
            ),
            SizedBox(height: 10.0),
            MaterialButton(
              child: Text('Add profession', style: TextStyle(color: Colors.white)),
              color: Colors.green,
              onPressed: () {}
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        child: Icon(Icons.close),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}