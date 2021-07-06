import 'package:flutter/material.dart';

class PageOne extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page One'),
      ),
      body: UserInfo(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.chevron_right),
        onPressed: () => Navigator.pushNamed(context, 'pageTwo')
      ),
    );
  }
}

class UserInfo extends StatelessWidget {
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
          ListTile( title: Text('Name')),
          ListTile( title: Text('Age')),
          SizedBox(height: 20.0),
          Text('Professions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Divider(),
          ListTile( title: Text('Profession One')),
          ListTile( title: Text('Profession Two')),
          ListTile( title: Text('Profession Three')),
        ],
      )
    );
  }
}