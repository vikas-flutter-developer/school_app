import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/screen_util_helper.dart';

class AttendanceOverviewDialog extends StatelessWidget {
  const AttendanceOverviewDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      backgroundColor: AppColors.greyLight,
      child: SizedBox(
        width: ScreenUtilHelper.scaleWidth(321), // ScreenUtilHelper
        height: ScreenUtilHelper.scaleHeight(430), // ScreenUtilHelper
        child: Column(
          children: [
            // Top bar with title and close icon
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtilHelper.scaleWidth(16),
                vertical: ScreenUtilHelper.scaleHeight(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Attendance Overview",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  InkWell(
                    onTap: () => context.pop(),
                    child: const Icon(Icons.close, size: 24),
                  ),
                ],
              ),
            ),

            SizedBox(height: ScreenUtilHelper.scaleHeight(10)),

            // Circular Chart
            SizedBox(
              width: ScreenUtilHelper.scaleWidth(188),
              height: ScreenUtilHelper.scaleHeight(188),
              child: CustomPaint(
                painter: SegmentedCirclePainter(
                  segments: [
                    SegmentData(
                      percent: 0.6,
                      color: AppColors.attendanceBlue,
                    ),
                    SegmentData(
                      percent: 0.25,
                      color: AppColors.leaveCyan,
                    ),
                    SegmentData(
                      percent: 0.15,
                      color: AppColors.halfDayRed,
                    ),
                  ],
                  strokeWidth: 14,
                  gapSizeDegrees: 5, // smaller gap
                ),
                child: Center(
                  child: Text(
                    "76%",
                    style: TextStyle(
                      fontSize: ScreenUtilHelper.scaleText(28),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: ScreenUtilHelper.scaleHeight(24)),

            Container(
              width: ScreenUtilHelper.scaleWidth(285),
              height: 1,
              color: Colors.grey.shade300,
            ),

            SizedBox(height: ScreenUtilHelper.scaleHeight(20)),

            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtilHelper.scaleWidth(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Indicator(
                    color: AppColors.attendanceBlue,
                    label: "Attendance",
                  ),
                  Indicator(
                    color: AppColors.leaveCyan,
                    label: "Leaves",
                  ),
                  Indicator(
                    color: AppColors.halfDayRed,
                    label: "Half days",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SegmentData {
  final double percent;
  final Color color;

  SegmentData({required this.percent, required this.color});
}

class SegmentedCirclePainter extends CustomPainter {
  final List<SegmentData> segments;
  final double strokeWidth;
  final double gapSizeDegrees;

  SegmentedCirclePainter({
    required this.segments,
    this.strokeWidth = 10,
    this.gapSizeDegrees = 4,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double startAngle = -90 * 3.1415926535897932 / 180;
    final rect = Offset.zero & size;
    final totalGap = gapSizeDegrees * segments.length;
    final totalSweepDegrees = 360 - totalGap;

    for (var segment in segments) {
      final sweepAngleDegrees = segment.percent * totalSweepDegrees;
      final sweepAngle = sweepAngleDegrees * 3.1415926535897932 / 180;

      final paint = Paint()
        ..color = segment.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        rect.deflate(strokeWidth / 2),
        startAngle,
        sweepAngle,
        false,
        paint,
      );

      startAngle += sweepAngle + gapSizeDegrees * 3.1415926535897932 / 180;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class Indicator extends StatelessWidget {
  final Color color;
  final String label;

  const Indicator({Key? key, required this.color, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(radius: 5, backgroundColor: color),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(fontSize: ScreenUtilHelper.scaleText(13)),
        ),
      ],
    );
  }
}
