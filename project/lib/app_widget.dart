import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:project/pages/account/login_page.dart';
import 'package:project/pages/home_page.dart';
import 'package:project/pages/loader/loader_page.dart';
import 'package:project/pages/pet/ration_add_pet.dart';
import 'package:project/pages/pet/size_add_pet.dart';
import 'package:project/pages/pet/type_add_pet.dart';
import 'package:project/pages/splash_page.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
