import 'package:edudibon_flutter_bloc/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/screen_util_helper.dart';

class AssignmentSearchBar extends StatelessWidget {
  const AssignmentSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtilHelper.scaleWidth(8.0),
      ),
      child: Container(
        width: ScreenUtilHelper.scaleWidth(397),
        height: ScreenUtilHelper.scaleHeight(47),
        decoration: BoxDecoration(
          color: AppColors.linen,
          borderRadius: BorderRadius.circular(
            ScreenUtilHelper.scaleRadius(5.0),
          ),
        ),
        child: TextField(
          style: TextStyle(
            fontSize: ScreenUtilHelper.scaleText(14),
          ),
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle: TextStyle(
              fontSize: ScreenUtilHelper.scaleText(14),
            ),
            prefixIcon: Icon(
              Icons.search,
              size: ScreenUtilHelper.scaleWidth(20),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                Icons.mic,
                size: ScreenUtilHelper.scaleWidth(20),
              ),
              onPressed: () {
                // Handle mic tap
              },
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                ScreenUtilHelper.scaleRadius(5),
              ),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                ScreenUtilHelper.scaleRadius(5),
              ),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                ScreenUtilHelper.scaleRadius(5),
              ),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: AppColors.linen,
            contentPadding: EdgeInsets.zero,
          ),
        ),
      ),
    );
  }
}
