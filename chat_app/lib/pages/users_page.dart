import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../models/user_model.dart';
import '../services/auth_service.dart';
import '../services/chat_service.dart';
import '../services/socket_service.dart';
import '../services/users_services.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key}) : super(key: key);


  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final usersService = UsersService();

  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  
  List<User> users = [];

  @override
  void initState() {
    _loadUsers();
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
        title: Text('${ user?.name }', style: const TextStyle(color: Colors.black87)),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          splashRadius: 24,
          tooltip: 'Logout',
          onPressed: (){
            socketService.disconnect();
            Navigator.pushReplacementNamed(context, 'login');
            AuthService.deleteToken();
          }, 
          icon: const Icon(Icons.exit_to_app, color: Colors.black87)
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10.0),
            child: (socketService.serverStatus == ServerStatus.online)
            ? Icon(Icons.check_circle, color: Colors.blue[400])
            : const Icon(Icons.wifi_lock, color: Colors.red)
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
      itemCount: users.length,
      itemBuilder: (_, i) => _usersListTitle(users[i]),
      separatorBuilder: (_, i) => const Divider(),
    );
  }

  Widget _usersListTitle(User user) {
    return ListTile(
        onTap: () {
          final chatService = Provider.of<ChatService>(context, listen: false);
          chatService.userTo = user;
          Navigator.pushNamed(context, 'chat');
        },
        title: Text(user.name),
        subtitle: Text(user.email ?? 'No Email'),
        leading: CircleAvatar(
          backgroundColor: Colors.blue[100],
          child: Text(user.name.substring(0,2)),
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