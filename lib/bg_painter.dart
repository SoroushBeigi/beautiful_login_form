import 'dart:ui';

import 'package:flutter/material.dart';

class BackgroundPainter extends CustomPainter {
  final FragmentShader shader;

  BackgroundPainter(this.shader);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..shader = shader,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}