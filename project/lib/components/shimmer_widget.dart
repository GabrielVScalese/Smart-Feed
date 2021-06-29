import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final double width;
  final double height;
  final ShapeBorder shapeBorder;

  const ShimmerWidget.circular(
      {@required this.width,
      @required this.height,
      this.shapeBorder = const CircleBorder()});

  const ShimmerWidget.rectangular({
    @required this.width,
    @required this.height,
  }) : this.shapeBorder = const RoundedRectangleBorder();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[400],
      highlightColor: Colors.grey[300],
      child: Container(
        width: width,
        height: height,
        decoration:
            ShapeDecoration(color: Colors.grey[400], shape: shapeBorder),
      ),
    );
  }
}
