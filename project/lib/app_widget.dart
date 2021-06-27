import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:project/pages/pet/ration_add_pet.dart';
import 'package:project/pages/pet/size_add_pet.dart';
import 'package:project/pages/pet/type_add_pet.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SizeAddPet(),
    );
  }
}
