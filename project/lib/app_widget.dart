import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:project/pages/account/login_page.dart';
import 'package:project/pages/addPet/name_add_pet.dart';
import 'package:project/pages/addPet/photo_add_pet.dart';
import 'package:project/pages/addPet/ration_add_pet.dart';
import 'package:project/pages/addPet/size_add_pet.dart';
import 'package:project/pages/addPet/type_add_pet.dart';
import 'package:project/pages/configurations/user_page.dart';
import 'package:project/pages/splash_page.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
      routes: {
        '/userPage': (context) => UserPage(),
        '/login': (context) => LoginPage(),
        '/type': (context) => TypeAddPet(),
        '/size': (context) => SizeAddPet(),
        '/ration': (context) => RationAddPet(),
        '/photo': (context) => PhotoAddPet(),
        '/name': (context) => NameAddPet()
      },
    );
  }
}
