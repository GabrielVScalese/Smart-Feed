import 'package:dio/dio.dart';
import 'package:project/repositories/refresh_token_repository.dart';

class RefreshToken {
  execute(Dio dio, RequestOptions options) async {
    var refreshTokenRepository = new RefreshTokenRepository();
    await refreshTokenRepository.createToken();
    var response = await dio.request(options.path,
        data: options.data,
        queryParameters: options.queryParameters,
        options: Options(headers: options.headers));

    return response.data;
  }
}
