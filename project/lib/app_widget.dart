import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:project/pages/configurations/user_page.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UserPage(),
    );
  }
}
