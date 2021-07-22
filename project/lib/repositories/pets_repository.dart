import 'package:project/models/pet.dart';
import 'package:project/utils/custom_dio.dart';
import 'package:project/utils/refresh_token.dart';

class PetsRepository {
  findByOwner(userId) async {
    var dio = CustomDio.withAuthentication().instance;

    var response = await dio.get(
      'https://smart-feed-app.herokuapp.com/pets/findByOwner/$userId',
    );

    var data = response.data;
    if (response.statusCode == 401) {
      var refreshToken = new RefreshToken();
      data = await refreshToken.execute(dio, response.requestOptions);
    }

    return data.map<Pet>((p) => Pet.fromMap(p)).toList() as List<Pet>;
  }
}
