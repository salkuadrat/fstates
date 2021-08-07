import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'state/users_state.dart';
import 'view/home.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UsersState()),
      // you can add more providers here
    ],
    child: App(),
  ));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Provider Example',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: Home(),
    );
  }
}
