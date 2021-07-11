import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:project/models/pet.dart';

class PetRepository {
  static findPetsByOwner(int userId, String token) async {
    var response = await http.get(
        Uri.parse(
            'https://smart-feed-app.herokuapp.com/pets/findByOwner/$userId'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": 'Bearer $token'
        });

    var map = await jsonDecode(response.body);

    var pets = [];
    for (var item in map)
      pets.add(Pet(item["id"], item["name"], item["animal"], item["ration"],
          item["size"], item["device"], item["image"]));

    return pets;
  }

  static insertPet(String userEmail, Pet pet) async {
    var body = json.encode({
      'userEmail': userEmail,
      'name': pet.getName(),
      'animal': pet.getAnimal(),
      'ration': pet.getRation(),
      'size': pet.getSize(),
      'device': pet.getDevice(),
      'image': pet.getImage(),
    });

    var response = await http.post(
        Uri.parse('https://smart-feed-api.herokuapp.com/api/insertPet'),
        headers: {"Content-Type": "application/json"},
        body: body);

    return response.statusCode;
  }

  static updatePet(Pet pet) async {
    var body = json.encode({
      'id': pet.getId(),
      'name': pet.getName(),
      'animal': pet.getAnimal(),
      'ration': pet.getRation(),
      'size': pet.getSize(),
      'device': pet.getDevice(),
      'image': pet.getImage(),
    });

    var response = await http.put(
        Uri.parse('https://smart-feed-api.herokuapp.com/api/updatePetById'),
        headers: {"Content-Type": "application/json"},
        body: body);

    return response.statusCode;
  }

  static deletePet(var id) async {
    var response = await http.delete(
        Uri.parse('https://smart-feed-api.herokuapp.com/api/deletePetById/' +
            id.toString()),
        headers: {"Content-Type": "application/json"});

    return response.statusCode;
  }
}
