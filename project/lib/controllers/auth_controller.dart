import 'dart:convert';
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

    await instance.setString("authorization",
        jsonEncode({'token': token, 'refreshToken': refreshToken}));
  }

  currentUser(BuildContext context) async {
    final instance = await SharedPreferences.getInstance();
    await Future.delayed(Duration(seconds: 2));

    if (instance.containsKey("user")) {
      final userJson = instance.get("user") as String;

      final authorizationJson = instance.get('authorization') as String;
      var authorization = await jsonDecode(authorizationJson);

      setCredentials(context, User.fromJson(userJson), authorization['token'],
          authorization['refreshToken']);
    } else {
      setCredentials(context, null, null, null);
    }
  }
}
