import 'package:chat_app/services/socket_service.dart';
import 'package:chat_app/services/users_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/models/user_model.dart';

class UsersPage extends StatefulWidget {

  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final usersService = new UsersService();

  RefreshController _refreshController = RefreshController(initialRefresh: false);
  
  List<User> users = [];

  @override
  void initState() {
    this._loadUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);
    final authService = Provider.of<AuthService>(context);
    final user = authService.user;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(user!.name, style: TextStyle(color: Colors.black87)),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){
            socketService.disconnect();
            Navigator.pushReplacementNamed(context, 'login');
            AuthService.deleteToken();
          }, 
          icon: Icon(Icons.exit_to_app, color: Colors.black87)
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10.0),
            child: (socketService.serverStatus == ServerStatus.Online)
            ? Icon(Icons.check_circle, color: Colors.blue[400])
            : Icon(Icons.wifi_lock, color: Colors.red)
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
        onTap: () {
          Navigator.pushNamed(context, 'chat');
        },
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
    
    users = await usersService.getUsers();
    setState(() {});
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}