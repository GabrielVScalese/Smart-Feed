import 'package:dio/dio.dart';
import 'package:project/models/consumption.dart';
import 'package:project/models/statistics.dart';
import 'package:project/utils/custom_dio.dart';
import 'package:project/utils/refresh_token.dart';

class ConsumptionsRepository {
  Dio _dio;

  ConsumptionsRepository() {
    this._dio = CustomDio.withAuthentication().instance;
  }

  Future<List<Consumption>> findConsumptionByPet(int petId) async {
    var response = await this._dio.get('/consumptions/findByPet/$petId');

    var data = response.data;

    if (response.statusCode == 401) {
      var refreshToken = new RefreshToken();
      var newResponse = await refreshToken.execute(response.requestOptions);

      data = newResponse.data;
    }

    return data.map<Consumption>((c) => Consumption.fromMap(c)).toList()
        as List<Consumption>;
  }

  Future<Statistics> findStatisticsByPet(int petId) async {
    var response = await this._dio.get('/consumptions/statistics/$petId');

    var data = response.data;

    if (response.statusCode == 401) {
      var refreshToken = new RefreshToken();
      var newResponse = await refreshToken.execute(response.requestOptions);

      data = newResponse.data;
    }

    return Statistics.fromMap(data);
  }
}
