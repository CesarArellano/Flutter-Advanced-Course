import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ChatPage extends StatefulWidget {

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _textController = new TextEditingController();
  final _focusNode = new FocusNode();
  bool isWriting = false;

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
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: _inputChat()
            )
          ],
        )
      )
    );
  }

  Widget _inputChat() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(left: 15),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmit,
                onChanged: (String text) {
                  setState(() {
                    if(text.trim().length > 0) {
                      isWriting = true;
                    } else {
                      isWriting = false;
                    }

                  });
                },
                decoration: InputDecoration.collapsed(
                  hintText: 'Enviar mensaje'
                ),
                focusNode: _focusNode,
              ),
            ),
            Container(
              child: Platform.isIOS
                ? CupertinoButton(
                  padding: EdgeInsets.only(right: 25),
                  child: Text('Send'),
                  onPressed: (isWriting)
                    ? () => _handleSubmit(_textController.text.trim())
                    : null
                )
                : Container(
                  child: IconTheme(
                    data: IconThemeData(
                      color: Colors.blue[400]
                    ),
                    child: RawMaterialButton(
                      padding: EdgeInsets.all(15),
                      shape: CircleBorder(),
                      child: Icon(Icons.send, color: (isWriting) ? Colors.blue : Colors.grey),
                      onPressed: (isWriting)
                        ? () => _handleSubmit(_textController.text.trim())
                        : null
                    ),
                  )
                )
            )
          ],
        )
      )
    );
  }

  void _handleSubmit(String value) {
    print('hola');
    _textController.clear();
    _focusNode.requestFocus();
    setState(() {
      isWriting = false;
    });
  }
}