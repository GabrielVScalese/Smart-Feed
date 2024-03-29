import 'package:flutter/cupertino.dart';

class CircleImage extends StatelessWidget {
  const CircleImage(
      {Key key, this.margin, @required this.scale, @required this.srcImage})
      : super(key: key);

  final EdgeInsetsGeometry margin;
  final double scale;
  final String srcImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: scale,
      width: scale,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              fit: BoxFit.cover, image: NetworkImage(srcImage))),
    );
  }
}
