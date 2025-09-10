import 'package:edudibon_flutter_bloc/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/screen_util_helper.dart';

class ProfileInfoRowWidget extends StatelessWidget {
  final String text;
  final double bottomPadding;

  const ProfileInfoRowWidget(this.text, {super.key, this.bottomPadding = 6.0});

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);

    return Padding(
      padding: EdgeInsets.only(bottom: ScreenUtilHelper.height(bottomPadding)),
      child: Text(
        text,
        style: AppStyles.heading.copyWith(
            color: AppColors.black,
            height: 1.4),
        textAlign: TextAlign.left,
      ),
    );
  }
}