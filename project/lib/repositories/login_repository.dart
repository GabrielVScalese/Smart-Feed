import 'dart:convert';
import 'package:project/models/user.dart';
import 'package:project/utils/custom_dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginRepository {
  Future<Map> login(User user) async {
    var dio = CustomDio().instance;

    var response = await dio.post('/users/authenticate', data: {
      'email': user.getEmail(),
      'password': user.getPassword(),
    });

    if (response.statusCode == 200) {
      var prefs = await SharedPreferences.getInstance();
      await prefs.setString('user', jsonEncode(response.data['user']));
      await prefs.setString('token', response.data['token']);
      await prefs.setString(
          'refreshToken', response.data['refreshToken']['id']);
    }

    return {"statusCode": response.statusCode, "data": response.data};
  }
}
