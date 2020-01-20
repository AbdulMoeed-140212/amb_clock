import 'package:flutter/material.dart';

class SeparaterPainter extends CustomPainter{
  final double animation;

  SeparaterPainter(this.animation);
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color =Color(0xFFffa300);
    double sizeBox = size.width*0.05;
    canvas.drawRect(Rect.fromLTWH(size.width/2-sizeBox/2, size.height/2 - sizeBox +(size.height/5*animation), sizeBox, sizeBox), paint);
    canvas.drawRect(Rect.fromLTWH(size.width/2-sizeBox/2, size.height/2 + sizeBox -(size.height/5*animation), sizeBox, sizeBox), paint);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

}