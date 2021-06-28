import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:project/components/add_pet_structure.dart';
import 'package:project/components/circle_card.dart';
import 'package:project/pages/home_page.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
