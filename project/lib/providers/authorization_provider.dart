import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AuthorizationProvider {
  static execute() async {
    var instance = await SharedPreferences.getInstance();
    var authorization = await jsonDecode(instance.get('authorization'));

    return authorization;
  }
}
