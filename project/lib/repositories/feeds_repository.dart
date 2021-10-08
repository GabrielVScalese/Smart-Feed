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

  Future<List<Feed>> findByOwner(userId) async {
    var response = await this._dio.get(
          '/feeds/findByOwner/$userId',
        );

    var data = response.data;

    // Token is invalid
    if (response.statusCode == 401) {
      var refreshToken = new RefreshToken();

      var newResponse = await refreshToken.execute(response.requestOptions);
      data = newResponse.data;
    }

    return data.map<Feed>((f) => Feed.fromMap(f)).toList() as List<Feed>;
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
