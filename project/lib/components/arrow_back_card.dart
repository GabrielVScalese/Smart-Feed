import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ArrowBackCard extends StatelessWidget {
  const ArrowBackCard({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: size.width * 0.05),
      child: Card(
          elevation: 20,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(150),
          ),
          child: Container(
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: size.height * 0.03,
              ),
              width: size.width * 0.14,
              height: size.width * 0.14,
              decoration: BoxDecoration(shape: BoxShape.circle))),
    );
  }
}
