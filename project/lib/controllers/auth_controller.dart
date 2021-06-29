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
      print("entrou");
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
    final instance = await SharedPreferences
        .getInstance(); // acessa as informações do sharedPreferences
    await instance.setString(
        "user", user.toJson()); // coloca um Json do user na key "user"
  }

  Future<void> currentUser(BuildContext context) async {
    final instance = await SharedPreferences
        .getInstance(); // acessa as informações do sharedPreferences
    await Future.delayed(Duration(seconds: 2));
    if (instance.containsKey("user")) {
      // se tem algum user
      final json = instance.get("user") as String; //loga novamente

      setUser(context, User.fromJson(json)); //
      return;
    } else {
      // se não
      setUser(context,
          null); // passa um user null para o saveUser ir para a tela de login
    }
  }
}
