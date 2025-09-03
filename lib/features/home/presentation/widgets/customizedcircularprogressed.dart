import 'package:flutter/material.dart';

class GradientCircularProgressPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;

  GradientCircularProgressPainter({
    required this.progress,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final gradient = SweepGradient(
      colors: [
        Colors.purple,
        Colors.pink,
        Colors.orange,
        Colors.yellow,
        Colors.purple,
      ],
      stops: const [0.0, 0.25, 0.5, 0.75, 1.0],
    );

    final rect = Rect.fromCircle(center: center, radius: radius);
    final gradientShader = gradient.createShader(rect);

    final paint = Paint()
      ..shader = gradientShader
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final sweepAngle = 2 * 3.14159 * progress;

    canvas.drawArc(
      rect,
      -3.14159 / 2, // Start from top
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(GradientCircularProgressPainter oldDelegate) {
    return progress != oldDelegate.progress;
  }
}
