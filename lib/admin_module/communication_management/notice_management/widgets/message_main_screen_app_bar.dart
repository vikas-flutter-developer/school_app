import 'package:edudibon_flutter_bloc/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/screen_util_helper.dart';

class MessageMainScreenAppBar extends StatelessWidget {
  const MessageMainScreenAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);

    return Container(
      width: ScreenUtilHelper.width(378),
      height: ScreenUtilHelper.height(40),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(4)),
        color: AppColors.accentLight,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: ()=>GoRouter.of(context).pop(),
          ),
          SizedBox(width: ScreenUtilHelper.width(5)),
          Text(
            'Notice',
            style: TextStyle(
              fontSize: ScreenUtilHelper.fontSize(16),
              fontWeight: AppStyles.weight.emphasis,
              color: AppColors.graphite,
            ),
          ),
        ],
      ),
    );
  }
}