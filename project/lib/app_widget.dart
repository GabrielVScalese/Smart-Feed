import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:project/pages/register_page.dart';
import 'package:project/pages/login_page.dart';

// Provisorio
class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
