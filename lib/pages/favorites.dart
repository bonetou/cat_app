import 'package:flutter/material.dart';

class Favorites extends StatelessWidget {
  const Favorites({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Text('My Favorites'),
      )),
    );
  }
}
