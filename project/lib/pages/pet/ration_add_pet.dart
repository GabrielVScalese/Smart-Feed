import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/components/add_pet_structure.dart';
import 'package:project/components/rectangle_card.dart';

class RationAddPet extends StatefulWidget {
  @override
  _RationAddPetState createState() => _RationAddPetState();
}

class _RationAddPetState extends State<RationAddPet> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    var cardList = [
      {'name': 'Premium', 'icon': Icons.restaurant_menu},
      {'name': 'S. Premium', 'icon': Icons.restaurant_menu},
      {'name': 'Uso Clínico', 'icon': Icons.restaurant_menu}
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
        title: 'Ração',
        subTitle: 'Premium, Super Premium ou uso clínico.',
        page: 2,
        cardSliders: cardSliders);
  }
}
