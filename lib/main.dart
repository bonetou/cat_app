import 'package:cat_app/pages/favorites.dart';
import 'package:cat_app/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
//import 'models/cats.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('favorite_cats');
  runApp(CatApp());
}

class CatApp extends StatefulWidget {
  CatApp({Key key}) : super(key: key);

  @override
  _CatAppState createState() => _CatAppState();
}

class _CatAppState extends State<CatApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cat Breeds App',
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/favorites': (context) => Favorites(),
      },
    );
  }
}
