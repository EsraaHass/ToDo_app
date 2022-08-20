import 'package:flutter/material.dart';
import 'package:todo/home_screen.dart';
import 'package:todo/my_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: HomeScreen.routeName,
      routes: {HomeScreen.routeName: (_) => HomeScreen()},
      theme: MyTheme.lightTheme,
    );
  }
}
