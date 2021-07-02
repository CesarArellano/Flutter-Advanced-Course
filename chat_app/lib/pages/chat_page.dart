import 'dart:io';

import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/chat_service.dart';
import 'package:chat_app/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:chat_app/widgets/chat_message.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textController = new TextEditingController();
  final _focusNode = new FocusNode();

  ChatService? chatService;
  SocketService? socketService;
  AuthService? authService;

  List<ChatMessage> _messages = [];

  bool isWriting = false;

  @override
  void initState() {
    super.initState();
    chatService = Provider.of<ChatService>(context, listen: false);
    socketService = Provider.of<SocketService>(context, listen: false);
    authService = Provider.of<AuthService>(context, listen: false);

    socketService!.socket!.on('personal-message', _listenMessages );
  }

  void _listenMessages( dynamic payload) {
    ChatMessage message = new ChatMessage(
      payload['message'],
      payload['from'],
      AnimationController(vsync: this, duration: Duration(milliseconds: 500))
    );
    setState(() {
      _messages.insert(0, message);
    });

    message.animationController.forward();
  }

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
              child: Text(chatService!.userTo!.name.substring(0,2), style: TextStyle(fontSize: 12)),
              backgroundColor: Colors.blueAccent,
            ),
            SizedBox(width: 10),
            Text(chatService!.userTo!.name, style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w400))
          ],
        )
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Flexible(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: _messages.length,
                itemBuilder: ( _ , i) => _messages[i],
                reverse: true,
              )
            ),
            Divider(height: 1.5),
            Container(
              height: 70,
              color: Colors.white,
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
                      highlightElevation: 3,
                      fillColor: Colors.white,
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

  void _handleSubmit(String text) {
    if(text.length == 0) return;

    _textController.clear();
    _focusNode.requestFocus();
    final newMessage = new ChatMessage(text,'123', AnimationController(vsync: this, duration: Duration(milliseconds: 500)));
    _messages.insert(0, newMessage);
    newMessage.animationController.forward();
    setState(() {
      isWriting = false;
    });
    socketService!.emit('personal-message', {
      'from': authService!.user!.uid,
      'to': chatService!.userTo!.uid,
      'message': text
    });
  }

  @override
  void dispose() {
    //TODO: Off del socket
    for(ChatMessage message in _messages) {
      message.animationController.dispose();
    }
    this.socketService!.socket!.off('personal-message');
    super.dispose();
  }
}