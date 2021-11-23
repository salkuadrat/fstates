import 'package:flutter/material.dart';

import '../models/user.dart';

class UserItem extends StatelessWidget {
  final User user;

  const UserItem(this.user, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 20,
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 12,
        ),
        leading: ClipOval(
          child: Container(
            color: Colors.grey.withOpacity(0.25),
            padding: EdgeInsets.all(10),
            child: Icon(Icons.person),
          ),
        ),
        title: Text(user.name),
        subtitle: Text(user.email),
        trailing: user.isActive ? Icon(Icons.check) : null,
      ),
    );
  }
}
