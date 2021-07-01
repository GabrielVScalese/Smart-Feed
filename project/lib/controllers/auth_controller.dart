import 'package:flutter/material.dart';
import 'package:project/models/user.dart';
import 'package:project/pages/account/login_page.dart';
import 'package:project/pages/home_page.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  User _user;

  User getUser() {
    return this._user;
  }

  Future<void> setUser(BuildContext context, User user) async {
    if (user != null) {
      saveUser(user);
      this._user = user;
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }

  Future<void> saveUser(User user) async {
    final instance = await SharedPreferences.getInstance();
    await instance.setString("user", user.toJson());
  }

  Future<void> currentUser(BuildContext context) async {
    final instance = await SharedPreferences.getInstance();
    await Future.delayed(Duration(seconds: 2));
    if (instance.containsKey("user")) {
      final json = instance.get("user") as String;

      setUser(context, User.fromJson(json));
    } else {
      setUser(context, null);
    }
  }
}
