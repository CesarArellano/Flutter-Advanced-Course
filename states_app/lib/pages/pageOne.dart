import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:states_app/controllers/user_controller.dart';
import 'package:states_app/models/user.dart';

class PageOne extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final userCtrl = Get.put( UserController() );
    return Scaffold(
      appBar: AppBar(
        title: Text('Page One'),
      ),
      body: Obx(() => userCtrl.existUser.value
        ? UserInfo(user: userCtrl.user.value)
        : NoInfo()
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.chevron_right),
        onPressed: () => Get.toNamed('pageTwo', arguments: {
          'name': 'César',
          'age': 21
        })
      ),
    );
  }
}

class NoInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('No user info'),
    );
  }

}

class UserInfo extends StatelessWidget {
  final User user;
  
  UserInfo({ required this.user });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('General', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Divider(),
          ListTile( title: Text('Name ${ user.name }')),
          ListTile( title: Text('Age ${ user.age }')),
          SizedBox(height: 20.0),
          Text('Professions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Divider(),
          ...user.professions.map((profession) => ListTile(title: Text(profession)) ).toList()
        ],
      )
    );
  }
}