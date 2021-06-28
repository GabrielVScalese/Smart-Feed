import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:project/pages/account/login_page.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
