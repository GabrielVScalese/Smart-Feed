import 'package:dio/dio.dart';
import 'package:project/repositories/refresh_token_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDio {
  var _dio;

  CustomDio() {
    _dio = Dio();
  }

  CustomDio.withAuthentication() {
    _dio = Dio();
    _dio.interceptors.add(InterceptorsWrapper(
        onRequest: _onRequest, onResponse: _onResponse, onError: _onError));
  }

  Dio get instance => _dio;

  _onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get('token');

    options.headers['Authorization'] = 'Bearer $token';

    return handler.next(options);
  }

  _onError(DioError e, ErrorInterceptorHandler handler) async {
    if (e.response.statusCode == 401) {
      _dio.interceptors.requestLock.lock();
      _dio.interceptors.responseLock.lock();

      var refreshTokenRepository = new RefreshTokenRepository();
      var token = await refreshTokenRepository.createToken();

      RequestOptions options = e.response.requestOptions;
      options.headers["Authorization"] = "Bearer $token";

      _dio.interceptors.requestLock.unlock();
      _dio.interceptors.responseLock.unlock();

      return _dio.request(options.path, options: options);
    }
  }

  _onResponse(Response e, ResponseInterceptorHandler handler) {
    print('############### Dio');
    print(e.data);
    print('############### Finish');

    return handler.next(e);
  }
}
