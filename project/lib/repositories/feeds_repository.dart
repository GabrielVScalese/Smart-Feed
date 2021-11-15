import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:project/models/feed.dart';
import 'package:project/utils/custom_dio.dart';
import 'package:project/utils/refresh_token.dart';

class FeedsRepository {
  Dio _dio;

  FeedsRepository() {
    this._dio = CustomDio.withAuthentication().instance;
  }

  Future<int> updateByPetId(int petId, Feed feed) async {
    var response = await this._dio.put('/feeds/$petId', data: Feed.toMap(feed));

    if (response.statusCode == 401) {
      var refreshToken = new RefreshToken();
      var newResponse = await refreshToken.execute(response.requestOptions);

      return newResponse.statusCode;
    }

    return response.statusCode;
  }
}
