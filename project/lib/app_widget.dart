import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:project/pages/configuration/user_page.dart';

// Provisorio
class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UserPage(),
    );
  }
}
