import 'package:project/utils/custom_dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RefreshTokenRepository {
  createToken() async {
    var dio = CustomDio().instance;

    var prefs = await SharedPreferences.getInstance();
    var refreshToken = prefs.getString('refreshToken');

    var response = await dio.post('/refreshToken', data: {'id': refreshToken});

    await prefs.setString('token', response.data['token']);

    if (response.data.containsKey('refreshToken'))
      await prefs.setString(
          'refreshToken', response.data['refreshToken']['id']);

    return response.data['token'];
  }
}
