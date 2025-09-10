import 'package:edudibon_flutter_bloc/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/screen_util_helper.dart';

class SearchFilterBarWidget extends StatelessWidget {
  const SearchFilterBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtilHelper.width(16.0),
        vertical: ScreenUtilHelper.height(10.0),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 5, // Give more space to the search bar
            child: SizedBox(
              height: ScreenUtilHelper.height(40),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search by name, room',
                  hintStyle: TextStyle(
                    color: AppColors.silver,
                    fontSize: AppStyles.size.body,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppColors.cloud,
                    size: ScreenUtilHelper.scaleAll(22),
                  ),
                  suffixIcon: Icon(
                    Icons.mic,
                    color: AppColors.slate,
                    size: ScreenUtilHelper.scaleAll(22),
                  ),
                  filled: true,
                  fillColor: AppColors.transparent,
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  border: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(ScreenUtilHelper.radius(12.0)),
                    borderSide: const BorderSide(color: AppColors.info),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(ScreenUtilHelper.radius(12.0)),
                    borderSide: BorderSide(
                        color: AppColors.success,
                        width: ScreenUtilHelper.width(2.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(ScreenUtilHelper.radius(12.0)),
                    borderSide:  BorderSide(color: AppColors.cloud),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: ScreenUtilHelper.width(8)),
          Expanded(
            flex: 1, // Give less space to the filter button
            child: Container(
              height: ScreenUtilHelper.height(38),
              decoration: BoxDecoration(
                borderRadius:
                BorderRadius.circular(ScreenUtilHelper.radius(9)),
                border: Border.all(
                  color: AppColors.accentLight,
                  width: ScreenUtilHelper.width(1.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RotatedBox(
                    quarterTurns: 1,
                    child: Icon(
                      Icons.tune,
                      size: ScreenUtilHelper.scaleAll(20),
                      color: AppColors.secondaryContrast,
                    ),
                  ),
                  SizedBox(width: ScreenUtilHelper.width(5)),
                  Icon(
                    Icons.sort,
                    size: ScreenUtilHelper.scaleAll(20),
                    color: AppColors.secondaryContrast,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}