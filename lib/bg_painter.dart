import 'dart:ui';
import 'package:flutter/material.dart';

class BackgroundPainter extends CustomPainter {
  BackgroundPainter(this.shader);
  final FragmentShader shader;

  @override
  void paint(Canvas canvas, Size size) {
    shader.setFloat(0, size.width); 
    shader.setFloat(1, size.height);
    shader.setFloat(2, 1.0);
    shader.setFloat(3, 0);
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..shader = shader,
    );
  }

  @override
  bool shouldRepaint(covariant BackgroundPainter oldDelegate) {
    return true;
  }
}