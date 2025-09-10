import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/screen_util_helper.dart';

class SectionDividerWidget extends StatelessWidget {
  const SectionDividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);

    return Column(
      children: [
        SizedBox(height: ScreenUtilHelper.height(20)),
        Divider(
          color: AppColors.cloud,
          thickness: ScreenUtilHelper.height(1.0),
        ),
        SizedBox(height: ScreenUtilHelper.height(20)),
      ],
    );
  }
}