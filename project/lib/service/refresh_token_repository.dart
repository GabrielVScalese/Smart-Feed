import 'dart:convert';

import 'package:http/http.dart' as http;

class RefreshTokenRepository {
  generateToken(refreshToken) async {
    var body = jsonEncode({'id': refreshToken});

    var response = await http.post(
        Uri.parse('https://smart-feed-app.herokuapp.com/refresh-token'),
        headers: {"Content-Type": "application/json"},
        body: body);

    var map = jsonDecode(response.body);

    return map;
  }
}
