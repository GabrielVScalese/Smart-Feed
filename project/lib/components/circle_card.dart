import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircleCard extends StatelessWidget {
  const CircleCard(
      {Key key, @required this.size, @required this.icon, @required this.color})
      : super(key: key);

  final Size size;
  final Icon icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(150),
        ),
        child: Container(
            child: icon,
            width: size.width * 0.14,
            height: size.width * 0.14,
            decoration: BoxDecoration(shape: BoxShape.circle, color: color)));
  }
}
