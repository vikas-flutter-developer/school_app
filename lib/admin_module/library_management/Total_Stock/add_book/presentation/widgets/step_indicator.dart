import 'package:flutter/material.dart';

import '../../../../../../core/utils/screen_util_helper.dart';

class StepIndicator extends StatelessWidget {
  final int currentStep;

  const StepIndicator({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);

    List<Widget> steps = [];

    for (int i = 1; i <= 3; i++) {
      bool isCompleted = i <= currentStep;

      steps.add(
        Container(
          width: ScreenUtilHelper.scaleWidth(24),   // Diameter = 2 * radius (12 * 2)
          height: ScreenUtilHelper.scaleWidth(24),
          decoration: BoxDecoration(
            color: Colors.transparent,   // No fill color
            shape: BoxShape.circle,
            border: Border.all(
              color: isCompleted ? Colors.deepPurple : Colors.grey,
              width: 2,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            "$i",
            style: TextStyle(
              color: isCompleted ? Colors.deepPurple : Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: ScreenUtilHelper.scaleText(12),
            ),
          ),
        ),
      );

      if (i < 3) {
        steps.add(
          Container(
            width: ScreenUtilHelper.scaleWidth(30),
            height: ScreenUtilHelper.scaleHeight(2),
            color: i < currentStep ? Colors.deepPurple : Colors.grey[300],
          ),
        );
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: steps,
    );
  }
}
