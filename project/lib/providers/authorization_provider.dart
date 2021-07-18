import 'dart:convert';
import 'package:project/service/refresh_token_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthorizationProvider {
  static getAuthorization() async {
    var instance = await SharedPreferences.getInstance();
    var authorization = await jsonDecode(instance.get('authorization'));

    return authorization;
  }

  static generateToken() async {
    var instance = await SharedPreferences.getInstance();
    var authorization = await jsonDecode(instance.getString('authorization'));

    var response = await RefreshTokenRepository.generateToken(
        authorization['refreshToken']);
    var map = await jsonDecode(response.body);

    if (map.containsKey('refreshToken'))
      instance.setString(
          'authorization',
          jsonEncode(
              {'token': map['token'], 'refreshToken': map['refreshToken']}));
    else
      instance.setString(
          'authorization',
          jsonEncode({
            'token': map['token'],
            'refreshToken': authorization['refreshToken']
          }));
  }
}
