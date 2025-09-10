import 'package:edudibon_flutter_bloc/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/screen_util_helper.dart';

class RoomHeaderWidget extends StatelessWidget {
  final String roomNumber;
  final VoidCallback onTap;

  const RoomHeaderWidget({
    super.key,
    required this.roomNumber,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);

    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: ScreenUtilHelper.width(51),
            height: ScreenUtilHelper.height(30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(6)),
              color: AppColors.tertiaryLightest,
            ),
            child: Center(
              child: Text(
                roomNumber,
                style: AppStyles.body.copyWith(color: AppColors.black)
              ),
            ),
          ),
          SizedBox(height: ScreenUtilHelper.height(20)),
        ],
      ),
    );
  }
}