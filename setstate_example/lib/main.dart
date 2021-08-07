import 'package:flutter/material.dart';

import 'view/home.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SetState Example',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: Home(),
    );
  }
}