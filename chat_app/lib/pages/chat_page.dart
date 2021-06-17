import 'package:flutter/material.dart';


class ChatPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        title: Row(
          children: [
            CircleAvatar(  
              child: Text('ME', style: TextStyle(fontSize: 12)),
              backgroundColor: Colors.blueAccent,
            ),
            SizedBox(width: 10),
            Text('Melissa Arellano', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w400))
          ],
        )
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Flexible(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemBuilder: ( _ , i) => Text('$i'),
                reverse: true,
              )
            ),
            Divider(height: 1),
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
            )
          ],
        )
      )
    );
  }
}