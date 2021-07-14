import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:states_app/pages/pageOne.dart';
import 'package:states_app/pages/pageTwo.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'pageOne',
      getPages: [
        GetPage(name: 'pageOne', page: () => PageOne()),
        GetPage(name: 'pageTwo', page: () => PageTwo()),
      ],
      // routes: {
      //   'pageOne': ( _ ) => PageOne(),
      //   'pageTwo': ( _ ) => PageTwo()
      // }
    );
  }
}