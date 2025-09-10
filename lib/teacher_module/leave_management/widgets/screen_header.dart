import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:edudibon_flutter_bloc/core/utils/screen_util_helper.dart';

class ScreenHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onBackPressed;

  const ScreenHeader({super.key, required this.title, this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: ScreenUtilHelper.scaleWidth(20),
          ),
          onPressed: onBackPressed ?? () => GoRouter.of(context).pop(),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: ScreenUtilHelper.scaleText(21),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
