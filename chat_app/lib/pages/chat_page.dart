import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/message_response.dart';
import '../services/auth_service.dart';
import '../services/chat_service.dart';
import '../services/socket_service.dart';
import '../widgets/chat_message.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);


  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();

  ChatService? chatService;
  SocketService? socketService;
  AuthService? authService;

  final List<ChatMessage> _messages = [];

  bool isWriting = false;

  @override
  void initState() {
    super.initState();
    chatService = Provider.of<ChatService>(context, listen: false);
    socketService = Provider.of<SocketService>(context, listen: false);
    authService = Provider.of<AuthService>(context, listen: false);

    socketService?.socket?.on('personal-message', _listenMessages );
    
    _loadChatHistory(chatService!.userTo!.uid ?? '');
  }

  void _loadChatHistory(String uid) async {
    List<Message> chat = await chatService!.getChat(uid);
    final history = chat.map((m) => ChatMessage(
        text: m.message ?? '', 
        uid: m.from ?? '', 
        animationController: AnimationController(vsync: this, duration: const Duration(milliseconds: 0))..forward()
      )
    );

    setState(() {
      _messages.insertAll(0, history);
    });
  }

  void _listenMessages( dynamic payload) {
    ChatMessage message = ChatMessage(
      text: payload['message'],
      uid: payload['from'],
      animationController: AnimationController(vsync: this, duration: const Duration(milliseconds: 500))
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
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        title: Row(
          children: [
            CircleAvatar(  
              backgroundColor: Colors.blueAccent,  
              child: Text(chatService!.userTo!.name.substring(0,2), style: const TextStyle(fontSize: 12)),
            ),
            const SizedBox(width: 10),
            Text(chatService!.userTo!.name, style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w400))
          ],
        )
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: _messages.length,
              itemBuilder: ( _ , i) => _messages[i],
              reverse: true,
            )
          ),
          const Divider(height: 1.5),
          Container(
            height: 70,
            color: Colors.white,
            child: _inputChat()
          )
        ],
      )
    );
  }

  Widget _inputChat() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(left: 15),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmit,
                onChanged: (String text) {
                  setState(() {
                    if(text.trim().isNotEmpty) {
                      isWriting = true;
                    } else {
                      isWriting = false;
                    }

                  });
                },
                decoration: const InputDecoration.collapsed(
                  hintText: 'Enviar mensaje'
                ),
                focusNode: _focusNode,
              ),
            ),
            Container(
              child: Platform.isIOS
                ? CupertinoButton(
                  padding: const EdgeInsets.only(right: 25),
                  onPressed: (isWriting)
                    ? () => _handleSubmit(_textController.text.trim())
                    : null,
                  child: const Text('Send')
                )
                : IconTheme(
                  data: IconThemeData(
                    color: Colors.blue[400]
                  ),
                  child: RawMaterialButton(
                    highlightElevation: 3,
                    fillColor: Colors.white,
                    padding: const EdgeInsets.all(15),
                    shape: const CircleBorder(),
                    onPressed: (isWriting)
                      ? () => _handleSubmit(_textController.text.trim())
                      : null,
                    child: Icon(Icons.send, color: (isWriting) ? Colors.blue : Colors.grey)
                  ),
                )
            )
          ],
        )
      )
    );
  }

  void _handleSubmit(String text) {
    if(text.isEmpty) return;

    _textController.clear();
    _focusNode.requestFocus();
    final newMessage = ChatMessage(
      text: text,
      uid: authService!.user!.uid ?? '',
      animationController: AnimationController(vsync: this, duration: const Duration(milliseconds: 500))
    );
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
    for(ChatMessage message in _messages) {
      message.animationController.dispose();
    }
    socketService!.socket!.off('personal-message');
    super.dispose();
  }
}