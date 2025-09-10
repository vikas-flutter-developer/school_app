import 'package:flutter/material.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/screen_util_helper.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtilHelper.scaleWidth(397),
      height: ScreenUtilHelper.scaleHeight(47),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleRadius(5)),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search',
          prefixIcon: Icon(
            Icons.search,
            size: ScreenUtilHelper.scaleWidth(22),
          ),
          suffixIcon: IconButton(
            icon: Icon(
              Icons.mic,
              size: ScreenUtilHelper.scaleWidth(22),
            ),
            onPressed: () {
              // Handle mic tap
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleRadius(5)),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleRadius(5)),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleRadius(5)),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: AppColors.linen,
        ),
      ),
    );
  }
}
