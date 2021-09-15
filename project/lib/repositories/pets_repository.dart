import 'package:dio/dio.dart';
import 'package:project/models/pet.dart';
import 'package:project/utils/custom_dio.dart';
import 'package:project/utils/refresh_token.dart';

class PetsRepository {
  Dio _dio;

  PetsRepository() {
    this._dio = CustomDio.withAuthentication().instance;
  }

  Future<List<Pet>> findByOwner(userId) async {
    var response = await this._dio.get(
          '/pets/findByOwner/$userId',
        );

    var data = response.data;

    // Token is invalid
    if (response.statusCode == 401) {
      var refreshToken = new RefreshToken();
      var newResponse = await refreshToken.execute(response.requestOptions);
      data = newResponse.data;
    }

    return data.map<Pet>((p) => Pet.fromMap(p)).toList() as List<Pet>;
  }

  Future<int> create(Pet pet) async {
    var response = await this._dio.post('/pets', data: Pet.toMap(pet));

    // Token is invalid
    if (response.statusCode == 401) {
      var refreshToken = new RefreshToken();
      var newResponse = await refreshToken.execute(response.requestOptions);

      return newResponse.statusCode;
    }

    return response.statusCode;
  }

  Future<int> destroy(id) async {
    try {
      var response = await this._dio.delete('/pets/$id');

      // Token is invalid
      if (response.statusCode == 401) {
        var refreshToken = new RefreshToken();
        var newResponse = await refreshToken.execute(response.requestOptions);

        return newResponse.statusCode;
      }
      print(response);
      return response.statusCode;
    } catch (e) {}
  }
}
