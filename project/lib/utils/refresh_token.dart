import 'package:dio/dio.dart';
import 'package:project/repositories/refresh_token_repository.dart';
import 'custom_dio.dart';

class RefreshToken {
  Future<Response> execute(RequestOptions options) async {
    var refreshTokenRepository = new RefreshTokenRepository();
    await refreshTokenRepository.createToken(); // Update token

    var dio = CustomDio.withAuthentication().instance;
    var url = '${options.baseUrl}${options.path}';

    var response = await dio.request(url,
        data: options.data,
        queryParameters: options.queryParameters,
        options: Options(method: options.method));

    return response;
  }
}
