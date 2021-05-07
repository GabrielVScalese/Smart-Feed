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
          item["device"]));

    return pets;
  }
}
