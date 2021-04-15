import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:project/models/user.dart';

class UserRepository {
  static insertUser(User user) async {
    var body = json.encode({
      'name': user.getName(),
      'email': user.getEmail(),
      'password': user.getPassword()
    });

    var response = await http.post('http://192.168.0.12:5000/api/insertUser',
        body: body, headers: {"Content-Type": "application/json"});

    return response.statusCode;
  }
}