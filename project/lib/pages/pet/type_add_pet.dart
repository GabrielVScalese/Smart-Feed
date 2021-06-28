import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/components/add_pet_structure.dart';
import 'package:project/components/rectangle_card.dart';

class TypeAddPet extends StatefulWidget {
  @override
  _TypeAddPetState createState() => _TypeAddPetState();
}

class _TypeAddPetState extends State<TypeAddPet> {
  // Fazer tamanho máximo e tamanho mínimo
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    var cardList = [
      {'name': 'Cão', 'icon': Icons.pets},
      {'name': 'Gato', 'icon': Icons.pets}
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
      title: 'Novo Pet',
      subTitle: 'Cão ou gato.',
      page: 1,
      cardSliders: cardSliders,
      child: null,
      buttonText: 'Próximo',
    );
  }
}
