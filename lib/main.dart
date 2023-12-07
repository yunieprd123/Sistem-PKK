import 'package:flutter/material.dart';
import 'package:kebaya_boutiq/login_page.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      theme:
          ThemeData(brightness: Brightness.light, primarySwatch: Colors.pink),
    );
  }
}
