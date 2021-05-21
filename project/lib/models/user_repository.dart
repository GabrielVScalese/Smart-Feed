import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:project/models/user.dart';

class UserRepository {
  static findUserByEmail(String email) async {
    var response = await http.get(
        Uri.parse('https://smart-feed-api.herokuapp.com/api/users/$email'),
        headers: {"Content-Type": "application/json"});

    var map = jsonDecode(response.body);
    var user = User.fromLogin(map["email"], map["name"]);

    return user;
  }

  static insertUser(User user) async {
    var body = json.encode({
      'name': user.getName(),
      'email': user.getEmail(),
      'password': user.getPassword()
    });

    var response = await http.post(
        Uri.parse('https://smart-feed-api.herokuapp.com/api/insertUser'),
        body: body,
        headers: {"Content-Type": "application/json"});

    return response.statusCode;
  }

  static authenticateUser(User user) async {
    var body =
        json.encode({'email': user.getEmail(), 'password': user.getPassword()});

    var response = await http.post(
        Uri.parse('https://smart-feed-api.herokuapp.com/api/authenticateUser'),
        body: body,
        headers: {"Content-Type": "application/json"});

    return response.statusCode;
  }
}
