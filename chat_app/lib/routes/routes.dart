import 'package:flutter/material.dart';

// Routes
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/loading_page.dart';
import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:chat_app/pages/users_page.dart';

final Map<String, WidgetBuilder> appRoutes = {
  'users'   : (_) => UsersPage(),
  'chat'    : (_) => ChatPage(),
  'login'   : (_) => LoginPage(),
  'register': (_) => RegisterPage(),
  'loading' : (_) => LoadingPage()
};