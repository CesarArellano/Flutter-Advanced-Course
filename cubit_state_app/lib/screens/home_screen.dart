import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cubit_state_app/bloc/user/user_cubit.dart';

class HomeScreen extends StatelessWidget {
  
  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (BuildContext context, UserState state) {
          return ( state is UserInitialState ) 
            ? const Center( 
              child: Text(
                'No User',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
              )
            )
            : const _UserData();
        },
      ),
        
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'detail');
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.person_add, color: Colors.white),
      ),
    );
  }
}

class _UserData extends StatelessWidget {
  const _UserData({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          final user = (state as ActiveUser).user;

          return ListView(
            children: [
              const SizedBox(height: 10),
              const Text('General', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const Divider(),
              ListTile(
                title: Text('Name: ${ user.name }'),
              ),
              ListTile(
                title: Text('Age: ${ user.age }'),
              ),
              const SizedBox(height: 10),
              const Text('Professions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const Divider(),
              ...user.professions.map(
                (e) => ListTile(
                  title: Text(e),
                )
              ),
            ],
          );
        }
      ),
    );
  }
}