import 'package:chat_app/models/user_model.dart';
import 'package:flutter/material.dart';


class UsersPage extends StatefulWidget {

  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final users = [
    User(uid: '1', name: 'Jaqueline', email: 'jaqui@gmail.com', online: true),
    User(uid: '2', name: 'Víctor', email: 'victor@gmail.com', online: false),
    User(uid: '3', name: 'Patricia', email: 'paty@gmail.com', online: true),
    User(uid: '4', name: 'Melissa', email: 'meli@gmail.com', online: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Mi nombre', style: TextStyle(color: Colors.black87)),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){}, 
          icon: Icon(Icons.exit_to_app, color: Colors.black87)
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10.0),
            child: Icon(Icons.check_circle, color: Colors.blue[400])
          )
        ],
      ),
      body: ListView.separated(
        physics: BouncingScrollPhysics(),
        itemCount: users.length,
        itemBuilder: (_, i) => ListTile(
          title: Text(users[i].name),
          leading: CircleAvatar(
            child: Text(users[i].name.substring(0,2))
          ),
          trailing: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: (users[i].online) ? Colors.green[300] : Colors.red,
              borderRadius: BorderRadius.circular(100)
            ),
          ),
        ),
        separatorBuilder: (_, i) => Divider(),
      )
    );
  }
}