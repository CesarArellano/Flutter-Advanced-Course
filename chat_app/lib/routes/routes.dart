import 'package:flutter/material.dart';

// Routes
import 'package:chat_app/pages/pages.dart';

final Map<String, WidgetBuilder> appRoutes = {
  'users'   : (_) => const UsersPage(),
  'chat'    : (_) => const ChatPage(),
  'login'   : (_) => const LoginPage(),
  'register': (_) => const RegisterPage(),
  'loading' : (_) => const LoadingPage()
};