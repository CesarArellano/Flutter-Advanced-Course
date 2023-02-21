import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/user/user_cubit.dart';
import 'screens/screens.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => UserCubit())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Bloc State App',
        initialRoute: 'home',
        theme: ThemeData.light(useMaterial3: true),
        routes: {
          'home': (_) => const HomeScreen(),
          'detail': (_) => const DetailScreen()
        },
      ),
    );
  }
}

