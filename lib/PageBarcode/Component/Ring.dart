import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Ring extends CustomPainter {

  final Color borderColor;

  final double progress;

  Ring({super.repaint, required this.borderColor,required this.progress});

  @override
  void paint(Canvas canvas, Size size) {

    final y = size.height;
    final x = size.width;

    final border = Path()
      ..addArc(Rect.fromPoints(Offset(0,0), Offset(x, y)), -pi/2, progress*2*pi)
    ;

    final paintBorder = Paint()
      ..style = PaintingStyle.stroke
      ..color = borderColor
      ..strokeWidth = 15
      ..strokeCap = StrokeCap.round
    ;

    final paintBorderShadow = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.black26
      ..strokeWidth = 20
      ..strokeCap = StrokeCap.round
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 5)
    ;

    canvas.drawPath(border, paintBorderShadow);
    canvas.drawPath(border, paintBorder);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

}