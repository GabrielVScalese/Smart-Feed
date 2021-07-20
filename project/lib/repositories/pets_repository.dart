import 'package:project/models/pet.dart';
import 'package:project/utils/custom_dio.dart';

class PetsRepository {
  findByOwner(userId) async {
    try {
      var dio = CustomDio.withAuthentication().instance;
      var response = await dio.get(
        'https://smart-feed-app.herokuapp.com/pets/findByOwner/${userId.toString()}',
      );

      return response.data.map<Pet>((p) => Pet.fromMap(p)).toList()
          as List<Pet>;
    } catch (err) {
      print(err.toString());
    }
  }
}
