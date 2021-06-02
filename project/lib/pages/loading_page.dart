import 'dart:math';

import 'package:flutter/material.dart';

class LoadingPage {
  static var carregamentoMsg = [
    "Brincando com o pet virtual...",
    "Fazendo carinho na conexão...",
    "Passando pano no Wi-Fi...",
    "Jogando queimada com o algoritmo...",
    "Dando comida pro servidor...",
    "Dando mamadeira pros bits..."
  ];

  static Widget Build() {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Image(
              image: AssetImage('assets/images/logo.png'),
              height: 200,
            ),
            CircularProgressIndicator(
                valueColor:
                    new AlwaysStoppedAnimation<Color>(Colors.blueAccent)),
            Container(
              child: Text(
                carregamentoMsg[Random().nextInt(carregamentoMsg.length - 1)],
                style: TextStyle(fontSize: 20, color: Colors.blueAccent),
              ),
              margin: EdgeInsets.only(top: 10),
            )
          ],
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
        alignment: Alignment.center,
        color: Colors.white,
      ),
    );
  }
}
