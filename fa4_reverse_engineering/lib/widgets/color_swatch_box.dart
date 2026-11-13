import  'package:flutter/material.dart';
import '../constants/app_constants.dart';

class ColorSwatchBox extends StatelessWidget {
  final Color color;
  final double size;

  const ColorSwatchBox({
    super.key,
    required this.color,
    this.size = AppSizes.swatch,  
  });

  @override
  Widget build(BuildContext context) {
    return Container(width: size, height: size, color: color);
  }
}
