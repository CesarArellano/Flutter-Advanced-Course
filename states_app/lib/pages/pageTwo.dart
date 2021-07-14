import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:states_app/controllers/user_controller.dart';
import 'package:states_app/models/user.dart';

class PageTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // print(Get.arguments['age']);
    final userCtrl = Get.find<UserController>();

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
              onPressed: () {
                final newUser = new User(
                  name: 'César',
                  age: 21,
                  professions: [
                    'Fullstack Developer',
                    'Gamer'
                  ]
                );
                userCtrl.loadUser(newUser);
                Get.snackbar(
                  'Seter User', 
                  'César is the user name',
                  backgroundColor: Colors.white,
                  boxShadows: [
                    BoxShadow(
                      color: Colors.black38,
                      blurRadius: 10
                    )
                  ]
                );
              }
            ),
            SizedBox(height: 10.0),
            MaterialButton(
              child: Text('Change Age', style: TextStyle(color: Colors.white)),
              color: Colors.red,
              onPressed: () => userCtrl.changeAge(31)
            ),
            SizedBox(height: 10.0),
            MaterialButton(
              child: Text('Add profession', style: TextStyle(color: Colors.white)),
              color: Colors.green,
              onPressed: () => userCtrl.addProfession('Profession #${ userCtrl.professionsCount + 1 }')
            ),
            SizedBox(height: 10.0),
            MaterialButton(
              child: Text('Change Theme', style: TextStyle(color: Colors.white)),
              color: Colors.purple,
              onPressed: () => Get.changeTheme(Get.isDarkMode ? ThemeData.light() : ThemeData.dark()),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        child: Icon(Icons.close),
        onPressed: () => Get.back(),
      ),
    );
  }
}