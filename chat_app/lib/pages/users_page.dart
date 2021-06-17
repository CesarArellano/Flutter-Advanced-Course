import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:chat_app/models/user_model.dart';

class UsersPage extends StatefulWidget {

  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  
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
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _loadUsers,
        header: WaterDropHeader(
          complete: Icon( Icons.check, color: Colors.blue[400] ),
          waterDropColor: Colors.blue,
        ),     
        child: _usersListView()
      )
    );
  }

  ListView _usersListView() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemCount: users.length,
      itemBuilder: (_, i) => _usersListTitle(users[i]),
      separatorBuilder: (_, i) => Divider(),
    );
  }

  Widget _usersListTitle(User user) {
    return ListTile(
        title: Text(user.name),
        subtitle: Text(user.email ?? 'No Email'),
        leading: CircleAvatar(
          child: Text(user.name.substring(0,2)),
          backgroundColor: Colors.blue[100],
        ),
        trailing: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: (user.online) ? Colors.green[300] : Colors.red,
            borderRadius: BorderRadius.circular(100)
          ),
        ),
      );
  }

  void _loadUsers() async {
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}