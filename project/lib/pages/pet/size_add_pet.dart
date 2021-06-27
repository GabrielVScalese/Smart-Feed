import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/components/add_pet_structure.dart';
import 'package:project/components/rectangle_card.dart';

class SizeAddPet extends StatefulWidget {
  @override
  _SizeAddPetState createState() => _SizeAddPetState();
}

class _SizeAddPetState extends State<SizeAddPet> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    var cardList = [
      {'name': 'Pequeno', 'icon': Icons.aspect_ratio},
      {'name': 'Médio', 'icon': Icons.aspect_ratio},
      {'name': 'Grande', 'icon': Icons.aspect_ratio},
    ];

    var cardSliders = cardList
        .map((item) => RectangleCard(
            size: size,
            scale: size.height * 0.25,
            icon: item['icon'],
            content: item['name']))
        .toList();

    return AddPetStructure(
        size: size,
        title: 'Porte',
        subTitle: 'Pequeno, médio ou grande',
        page: 3,
        cardSliders: cardSliders);
  }
}
