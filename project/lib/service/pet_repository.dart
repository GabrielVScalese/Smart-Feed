import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project/models/pet.dart';
import 'package:project/providers/authorization_provider.dart';

class PetRepository {
  static findPetsByOwner(int userId) async {
    var authorization = await AuthorizationProvider.getAuthorization();

    var response = await http.get(
        Uri.parse(
            'https://smart-feed-app.herokuapp.com/pets/findByOwner/$userId'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": 'Bearer ${authorization["token"]}'
        });

    if (response.statusCode == 401) {
      await AuthorizationProvider.generateToken();
      await findPetsByOwner(userId);
    }

    var map = await jsonDecode(response.body);
    var pets = [];

    for (var item in map)
      pets.add(Pet(item["id"], item["name"], item["animal"], item["ration"],
          item["size"], item["device"], item["image"]));

    return pets;
  }

  static create(Pet pet) async {
    var body = json.encode({
      'user_id': pet.getUserId(),
      'name': pet.getName(),
      'animal': pet.getAnimal(),
      'ration': pet.getRation(),
      'size': pet.getSize(),
      'device': pet.getDevice(),
      'image': pet.getImage(),
    });

    var authorization = await AuthorizationProvider.getAuthorization();
    var response =
        await http.post(Uri.parse('https://smart-feed-app.herokuapp.com/pets'),
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer ${authorization["token"]}"
            },
            body: body);

    if (response.statusCode == 401) {
      await AuthorizationProvider.generateToken();
      await create(pet);
    }

    return response.statusCode;
  }

  static update(Pet pet) async {
    var body = json.encode({
      'id': pet.getId(),
      'name': pet.getName(),
      'animal': pet.getAnimal(),
      'ration': pet.getRation(),
      'size': pet.getSize(),
      'device': pet.getDevice(),
      'image': pet.getImage(),
    });

    var authorization = await AuthorizationProvider.getAuthorization();
    var response = await http.put(
        Uri.parse('https://smart-feed-app.herokuapp.com/pets/${pet.getId()}'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${authorization["token"]}"
        },
        body: body);

    if (response.statusCode == 401) {
      await AuthorizationProvider.generateToken();
      await update(pet);
    }

    return response.statusCode;
  }

  static destroy(int id) async {
    var authorization = await AuthorizationProvider.getAuthorization();
    var response = await http.delete(
        Uri.parse('https://smart-feed-app.herokuapp.com/pets/$id'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${authorization["token"]}"
        });

    if (response.statusCode == 401) {
      await AuthorizationProvider.generateToken();
      await findPetsByOwner(id);
    }

    return response.statusCode;
  }
}
