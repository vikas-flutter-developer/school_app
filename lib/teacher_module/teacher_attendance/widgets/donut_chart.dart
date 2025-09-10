import 'dart:math';
import 'package:edudibon_flutter_bloc/core/utils/app_colors.dart';
import 'package:edudibon_flutter_bloc/core/utils/app_styles.dart' show AppStyles;
import 'package:edudibon_flutter_bloc/core/utils/screen_util_helper.dart'; // Import this
import 'package:flutter/material.dart';

class DonutChart extends StatelessWidget {
  final double percentage;
  final String centerText;
  final String label;

  const DonutChart({
    super.key,
    required this.percentage,
    required this.centerText,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(
        ScreenUtilHelper.scaleWidth(144), // ScreenUtilHelper
        ScreenUtilHelper.scaleHeight(144), // ScreenUtilHelper
      ),
      painter: DonutChartPainter(
        percentage: percentage,
        centerText: centerText,
        label: label,
      ),
    );
  }
}

class DonutChartPainter extends CustomPainter {
  final double percentage;
  final String centerText;
  final String label;

  DonutChartPainter({
    required this.percentage,
    required this.centerText,
    required this.label,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = ScreenUtilHelper.scaleWidth(24.0); // ScreenUtilHelper
    final center = size.center(Offset.zero);
    final radius = size.width / 2;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt;

    final segments = [
      {'color': AppColors.segmentLime, 'value': 0.05},
      {'color': AppColors.pending, 'value': 0.1},
      {'color': AppColors.barChartFailColor2, 'value': 0.15},
      {'color': AppColors.primaryBright, 'value': percentage},
    ];

    double startAngle = -pi / 2;

    for (var segment in segments) {
      final sweepAngle = (segment['value'] as double) * 2 * pi;
      paint.color = segment['color'] as Color;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
        startAngle,
        sweepAngle,
        false,
        paint,
      );

      startAngle += sweepAngle;
    }

    // Center text
    final percentageText = TextSpan(
      text: centerText,
      style: TextStyle(
        color: AppColors.black,
        fontSize: ScreenUtilHelper.scaleText(AppStyles.size.body), // ScreenUtilHelper
        fontWeight: AppStyles.weight.regular,
      ),
    );

    final percentagePainter = TextPainter(
      text: percentageText,
      textDirection: TextDirection.ltr,
    )..layout();

    percentagePainter.paint(
      canvas,
      center - Offset(percentagePainter.width / 2, percentagePainter.height),
    );

    // Label text
    final labelText = TextSpan(
      text: label,
      style: TextStyle(
        color: AppColors.black,
        fontSize: ScreenUtilHelper.scaleText(AppStyles.size.body), // ScreenUtilHelper
        fontWeight: AppStyles.weight.regular,
      ),
    );

    final labelPainter = TextPainter(
      text: labelText,
      textDirection: TextDirection.ltr,
    )..layout();

    labelPainter.paint(
      canvas,
      center + Offset(-labelPainter.width / 2, ScreenUtilHelper.scaleHeight(4)), // ScreenUtilHelper
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
