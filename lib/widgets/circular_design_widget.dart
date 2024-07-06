import 'package:admin/constants/colors.dart';
import 'package:flutter/material.dart';

class CircularDesign extends StatelessWidget {
  final double x;
  final double y;
  final double z;
  final double radius;
  final double opacity;
  final Color color;
  const CircularDesign({
    super.key,
    required this.radius,
    this.x = 0,
    this.y = 0,
    this.z = 0,
    this.opacity = 0.1,
    this.color = MyColors.Navy2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: radius,
      width: radius,
      transform: Matrix4.translationValues(x, y, z),
      decoration: BoxDecoration(
        color: color.withOpacity(opacity),
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
