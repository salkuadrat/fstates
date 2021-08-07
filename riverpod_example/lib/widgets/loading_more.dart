import 'package:flutter/material.dart';

class LoadingMore extends StatelessWidget {
  const LoadingMore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 25,
        height: 25,
        margin: EdgeInsets.symmetric(vertical: 10),
        child: CircularProgressIndicator(strokeWidth: 3),
      ),
    );
  }
}