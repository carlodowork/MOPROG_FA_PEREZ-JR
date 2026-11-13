import 'dart:math';

import 'package:flutter/material.dart';

import '../constants/app_constants.dart';


class ColorWheel extends StatelessWidget {
  final Color color;
  final ValueChanged<Color> onChanged;
  final double size;

  const ColorWheel({
    super.key,
    required this.color,
    required this.onChanged,
    this.size =  AppSizes.wheel,
  });

  void _update(Offset position) {
    final radius = size / 2;
    final delta = position - Offset(radius, radius);
    final dist = min(delta.distance, radius);
    var hue = atan2(delta.dy, delta.dx)  * 180 / pi;
    if (hue < 0) hue += 360;
    onChanged(HSVColor.fromAHSV(1, hue, dist / radius, 1).toColor());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown:  (d) => _update(d.localPosition),
      onPanStart: (d) => _update(d.localPosition),
      onPanUpdate: (d) => _update(d.localPosition), 
      child: CustomPaint(
        size: Size.square(size),
        painter: _WheelPainter(color),
      ),
    );
  }
}

class _WheelPainter extends CustomPainter {
  final Color color;
  _WheelPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final  center = size.center(Offset.zero);
    final radius = size.width / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    final hueColors = [
      for (var h = 0; h <= 360; h += 60)
        HSVColor.fromAHSV(1, h.toDouble(), 1, 1).toColor(),
    ];
    canvas.drawCircle(
      center,
      radius,
      Paint()..shader = SweepGradient(colors: hueColors).createShader(rect),
    );
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..shader =  const RadialGradient(
          colors: [Colors.white, Color(0x00FFFFFF)],
        ).createShader(rect),
    );

    final hsv = HSVColor.fromColor(color);
    final angle = hsv.hue * pi / 180;
    final pos = center +
        Offset(cos(angle), sin(angle)) * (hsv.saturation * radius);
    canvas.drawCircle(
      pos,
      AppSizes.wheelSelector / 2,
      Paint()
        ..color =  Colors.black26
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3),
    );
    canvas.drawCircle(pos, AppSizes.wheelSelector / 2 - 2, Paint()..color = color);
    canvas.drawCircle(
      pos,
      AppSizes.wheelSelector / 2 - 1,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3,
    );
  }

  @override
  bool shouldRepaint(_WheelPainter old) => old.color   !=  color;
}
