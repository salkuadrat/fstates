import 'package:cubit_example/cubit/users_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'view/home.dart';

void main() {
  runApp(BlocProvider(
    create: (_) => UsersCubit(),
    child: App(),
  ));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cubit Example',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: Home(),
    );
  }
}
