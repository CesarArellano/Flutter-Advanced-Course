import 'package:chat_app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'routes/routes.dart';
import 'services/auth_service.dart';
import 'services/chat_service.dart';
import 'services/socket_service.dart';

void main() => runApp( const MyApp() );

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => SocketService()),
        ChangeNotifierProvider(create: (_) => ChatService())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chat App',
        initialRoute: 'loading',
        theme: AppTheme.lightTheme,
        routes: appRoutes,
      ),
    );
  }
}