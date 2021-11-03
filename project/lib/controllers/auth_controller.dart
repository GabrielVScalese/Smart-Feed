import 'package:flutter/material.dart';
import 'package:project/pages/account/login_page.dart';
import 'package:project/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  currentUser(BuildContext context) async {
    final instance = await SharedPreferences.getInstance();
    await Future.delayed(Duration(seconds: 2));

    if (instance.containsKey("user")) {
      print(instance.getString('user'));

      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }
}
