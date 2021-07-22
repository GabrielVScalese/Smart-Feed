import 'package:dio/dio.dart';
import 'package:project/models/pet.dart';
import 'package:project/utils/custom_dio.dart';
import 'package:project/utils/refresh_token.dart';

class PetsRepository {
  Dio _dio;

  PetsRepository() {
    this._dio = CustomDio.withAuthentication().instance;
  }

  Future findByOwner(userId) async {
    var response = await this._dio.get(
          '/pets/findByOwner/$userId',
        );

    var data = response.data;
    if (response.statusCode == 401) {
      var refreshToken = new RefreshToken();
      data = await refreshToken.execute(this._dio, response.requestOptions);
    }

    return data.map<Pet>((p) => Pet.fromMap(p)).toList() as List<Pet>;
  }

  Future create(Pet pet) async {
    var response = await this._dio.post('/pets', data: Pet.toMap(pet));

    if (response.statusCode == 401) {
      var refreshToken = new RefreshToken();
      await refreshToken.execute(this._dio, response.requestOptions);
    }

    return response.statusCode;
  }

  Future destroy(id) async {
    var response = await this._dio.delete('/pets', data: {'id': id});

    if (response.statusCode == 401) {
      var refreshToken = new RefreshToken();
      await refreshToken.execute(this._dio, response.requestOptions);
    }

    return response.statusCode;
  }
}
