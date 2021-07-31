import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDio {
  Dio _dio;
  String baseUrl = 'https://smart-feed-app.herokuapp.com';

  CustomDio() {
    _dio = Dio();
    _dio.options.baseUrl = baseUrl;

    // Ignore bad requests
    _dio.options.followRedirects = false;
    _dio.options.validateStatus = (status) {
      return status < 500;
    };
  }

  CustomDio.withAuthentication() {
    _dio = Dio();
    _dio.options.baseUrl = baseUrl;

    // Ignore bad requests
    _dio.options.followRedirects = false;
    _dio.options.validateStatus = (status) {
      return status < 500;
    };

    _dio.interceptors.add(
        InterceptorsWrapper(onRequest: _onRequest, onResponse: _onResponse));
  }

  Dio get instance => _dio;

  _onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get('token');

    options.headers['Authorization'] = 'Bearer $token';
    options.followRedirects = false;

    return handler.next(options);
  }

  _onResponse(Response e, ResponseInterceptorHandler handler) async {
    return handler.next(e);
  }
}
