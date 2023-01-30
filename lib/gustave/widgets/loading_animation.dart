import 'dart:math';
import 'package:flutter/material.dart';

class LoadingAnimation extends AnimatedWidget {
  LoadingAnimation({Key? key, required Animation<double> animation})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Center(
      child: Container(
        height: 400,
        width: 400,
        child: CustomPaint(
          painter: LoadingAnimationPainter(animation.value),
        ),
      ),
    );
  }
}

class LoadingAnimationPainter extends CustomPainter {
  final double angle;
  LoadingAnimationPainter(this.angle);

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);
    var trianglePaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;
    var circlePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, size.width / 3, circlePaint);
    canvas.drawPath(
      getTrianglePath(center, size.width / 4, this.angle),
      trianglePaint,
    );
  }

  Path getTrianglePath(Offset center, double R, double angle) {
    var angleRad = angle / 180 * pi;

    var path = Path()
      ..moveTo(R * sin(angleRad), R * cos(angleRad))
      ..lineTo(R * sin(2 * pi / 3 + angleRad), R * cos(2 * pi / 3 + angleRad))
      ..lineTo(R * sin(4 * pi / 3 + angleRad), R * cos(4 * pi / 3 + angleRad))
      ..close();
    path = path.shift(center);

    return path;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
