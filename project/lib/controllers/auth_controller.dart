import 'package:flutter/material.dart';
import 'package:project/models/user.dart';
import 'package:project/pages/account/login_page.dart';
import 'package:project/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  setCredentials(BuildContext context, User user, String token,
      String refreshToken) async {
    if (user != null) {
      _saveUser(user);
      _saveAuthorization(token, refreshToken);

      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }

  _saveUser(User user) async {
    final instance = await SharedPreferences.getInstance();

    await instance.setString("user", user.toJson());
  }

  _saveAuthorization(String token, String refreshToken) async {
    final instance = await SharedPreferences.getInstance();

    await instance.setString('token', token);
    await instance.setString('refreshToken', refreshToken);
  }

  currentUser(BuildContext context) async {
    final instance = await SharedPreferences.getInstance();
    await Future.delayed(Duration(seconds: 2));

    if (instance.containsKey("user")) {
      var userJson = instance.get("user") as String;

      var token = instance.getString('token');
      var refreshToken = instance.getString('refreshToken');

      setCredentials(context, User.fromJson(userJson), token, refreshToken);
    } else {
      setCredentials(context, null, null, null);
    }
  }
}
