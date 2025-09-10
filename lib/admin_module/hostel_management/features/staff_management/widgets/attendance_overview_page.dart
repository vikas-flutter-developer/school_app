import 'package:edudibon_flutter_bloc/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/screen_util_helper.dart';

class AttendanceOverviewPage extends StatelessWidget {
  const AttendanceOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);

    return Container(
      width: double.infinity,
      decoration:
      BoxDecoration(borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(16))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Feb 2025',
            style: AppStyles.heading.copyWith(color: AppColors.black),
          ),
          SizedBox(height: ScreenUtilHelper.height(30)),
          const _AttendanceProgressBar(),
          SizedBox(height: ScreenUtilHelper.height(40)),
          const Divider(),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: ScreenUtilHelper.width(16),
            runSpacing: ScreenUtilHelper.height(8),
            children: const [
              _LegendItem(color: Color(0xFF0073E6), label: 'Credited'),
              _LegendItem(color: Color(0xFF7DE3F2), label: 'Pending'),
              _LegendItem(color: Color(0xFFFF7B7B), label: 'On Hold'),
            ],
          ),
        ],
      ),
    );
  }
}

class _AttendanceProgressBar extends StatelessWidget {
  const _AttendanceProgressBar();

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);

    return SizedBox(
      height: ScreenUtilHelper.scaleAll(150),
      width: ScreenUtilHelper.scaleAll(150),
      child: SfRadialGauge(
        axes: <RadialAxis>[
          RadialAxis(
            startAngle: 270,
            endAngle: 270 + 360,
            showTicks: false,
            showLabels: false,
            axisLineStyle: const AxisLineStyle(
              thickness: 0.12,
              thicknessUnit: GaugeSizeUnit.factor,
              color: AppColors.transparent,
            ),
            ranges: <GaugeRange>[
              GaugeRange(
                startValue: 0,
                endValue: 76,
                color: AppColors.infoDark,
                startWidth: 0.12,
                endWidth: 0.12,
                sizeUnit: GaugeSizeUnit.factor,
              ),
              GaugeRange(
                startValue: 76,
                endValue: 91,
                color: AppColors.chapterTile1Bg,
                startWidth: 0.12,
                endWidth: 0.12,
                sizeUnit: GaugeSizeUnit.factor,
              ),
              GaugeRange(
                startValue: 91,
                endValue: 100,
                color: AppColors.barChartFailColor1,
                startWidth: 0.12,
                endWidth: 0.12,
                sizeUnit: GaugeSizeUnit.factor,
              ),
            ],
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                widget: Text(
                  '76%',
                  style: AppStyles.display.copyWith(color: AppColors.black),
                ),
                angle: 90,
                positionFactor: 0,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: ScreenUtilHelper.scaleAll(10),
          height: ScreenUtilHelper.scaleAll(10),
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: ScreenUtilHelper.width(6)),
        Text(
          label,
          style: AppStyles.small,
        ),
      ],
    );
  }
}