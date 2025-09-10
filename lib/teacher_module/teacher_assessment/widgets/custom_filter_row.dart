import 'package:flutter/material.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/screen_util_helper.dart';

class CustomFilterButton extends StatelessWidget {
  const CustomFilterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtilHelper.scaleWidth(33),
      height: ScreenUtilHelper.scaleHeight(28),
      color: AppColors.linen,
      child: Center(
        child: Icon(
          Icons.filter_list,
          color: AppColors.ash,
          size: ScreenUtilHelper.scaleWidth(20),
        ),
      ),
    );
  }
}
