import 'package:dio/dio.dart';
import 'package:project/models/user.dart';
import 'package:project/utils/custom_dio.dart';
import 'package:project/utils/refresh_token.dart';

class UsersRepository {
  Dio _dio;

  UsersRepository() {
    this._dio = CustomDio.withAuthentication().instance;
  }

  Future<int> register(User user) async {
    var response = await this._dio.post('/users', data: User.toMap(user));

    return response.statusCode;
  }

  Future<int> update(User user) async {
    var response =
        await this._dio.put('/users/${user.getId()}', data: User.toMap(user));

    // Token is invalid
    if (response.statusCode == 401) {
      var refreshToken = new RefreshToken();
      var newResponse = await refreshToken.execute(response.requestOptions);

      return newResponse.statusCode;
    }

    return response.statusCode;
  }

  Future<int> destroy(id) async {
    var response = await this._dio.delete('/users/$id');

    // Token is invalid
    if (response.statusCode == 401) {
      var refreshToken = new RefreshToken();
      var newResponse = await refreshToken.execute(response.requestOptions);

      return newResponse.statusCode;
    }

    print(response);
    return response.statusCode;
  }
}
