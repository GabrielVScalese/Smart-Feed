import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project/models/user.dart';
import 'package:project/providers/authorization_provider.dart';

class UserRepository {
  static insertUser(User user) async {
    var body = json.encode({
      'name': user.getName(),
      'email': user.getEmail(),
      'password': user.getPassword()
    });

    var response = await http.post(
        Uri.parse('https://smart-feed-api.herokuapp.com/users'),
        body: body,
        headers: {"Content-Type": "application/json"});

    return response.statusCode;
  }

  static update(User user) async {
    var body = jsonEncode({
      'name': user.getName(),
      'email': user.getEmail(),
      'password': user.getPassword()
    });

    var authorization = await AuthorizationProvider.execute();
    var response = await http.put(
        Uri.parse('https://smart-feed-app.herokuapp.com/users/${user.getId()}'),
        body: body,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${authorization['token']}"
        });

    return response.statusCode;
  }

  static authenticateUser(User user) async {
    try {
      var body = json
          .encode({'email': user.getEmail(), 'password': user.getPassword()});

      var response = await http.post(
          Uri.parse('https://smart-feed-app.herokuapp.com/users/authenticate'),
          body: body,
          headers: {"Content-Type": "application/json"});

      var map = await jsonDecode(response.body);
      map.addAll({'statusCode': response.statusCode});

      return map;
    } catch (err) {}
  }

  static destroy(int id) async {
    var authorization = await AuthorizationProvider.execute();
    var response = await http.delete(
        Uri.parse('https://smart-feed-app.herokuapp.com/users/$id'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${authorization['token']}"
        });

    return response.statusCode;
  }
}
