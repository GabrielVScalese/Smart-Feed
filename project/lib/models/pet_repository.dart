import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:project/models/pet.dart';

class PetRepository {
  static findPetsByUserEmail(String userEmail) async {
    var response = await http.get(
        Uri.parse('https://smart-feed-api.herokuapp.com/api/pets/$userEmail'),
        headers: {"Content-Type": "application/json"});

    var map = jsonDecode(response.body);
    var pets = [];
    for (var item in map)
      pets.add(Pet(item["name"], item["animal"], item["ration"], item["size"],
          item["device"], item["img"]));

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
      'img': pet.getImg(),
    });

    var response = await http.post(
        Uri.parse('https://smart-feed-api.herokuapp.com/api/insertPet'),
        headers: {"Content-Type": "application/json"},
        body: body);

    return response.statusCode;
  }
}
