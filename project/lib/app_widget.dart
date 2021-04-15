import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/login_page.dart';
import 'package:project/register_page.dart';

// Provisorio
class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      routes: {'/register': (context) => RegisterPage()},
    );
  }
}
