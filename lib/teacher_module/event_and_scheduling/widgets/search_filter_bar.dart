import 'package:flutter/material.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_styles.dart';
import '../../../core/utils/screen_util_helper.dart';

class SearchFilterBar extends StatelessWidget {
  const SearchFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: ScreenUtilHelper.scaleHeight(5),
      ),
      child: Column(
        children: [
          Container(
            height: ScreenUtilHelper.scaleHeight(40),
            decoration: BoxDecoration(
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(
                  fontSize: ScreenUtilHelper.scaleText(AppStyles.size.bodySmall),
                  color: AppColors.ash,
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
                    // TODO: Voice search
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    ScreenUtilHelper.scaleRadius(8),
                  ),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: AppColors.parchment,
                contentPadding: EdgeInsets.symmetric(
                  vertical: ScreenUtilHelper.scaleHeight(0),
                  horizontal: ScreenUtilHelper.scaleWidth(10),
                ),
              ),
            ),
          ),
          SizedBox(height: ScreenUtilHelper.scaleHeight(10)),
          Row(
            children: [
              InkWell(
                onTap: () {
                  print('Filter icon tapped!');
                },
                child: Container(
                  width: ScreenUtilHelper.scaleWidth(35),
                  height: ScreenUtilHelper.scaleHeight(30),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius:
                    BorderRadius.circular(ScreenUtilHelper.scaleRadius(5)),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.filter_alt_outlined,
                      color: AppColors.slate,
                      size: ScreenUtilHelper.scaleWidth(20),
                    ),
                  ),
                ),
              ),
              SizedBox(width: ScreenUtilHelper.scaleWidth(8)),
              InkWell(
                onTap: () {
                  print('Date Dropdown tapped!');
                },
                borderRadius:
                BorderRadius.circular(ScreenUtilHelper.scaleRadius(5)),
                child: Container(
                  height: ScreenUtilHelper.scaleHeight(30),
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtilHelper.scaleWidth(12),
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius:
                    BorderRadius.circular(ScreenUtilHelper.scaleRadius(5)),
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Date',
                        style: TextStyle(
                          fontSize:
                          ScreenUtilHelper.scaleText(AppStyles.size.small),
                          color: AppColors.slate,
                        ),
                      ),
                      SizedBox(width: ScreenUtilHelper.scaleWidth(5)),
                      Icon(
                        Icons.arrow_drop_down,
                        size: ScreenUtilHelper.scaleWidth(20),
                        color: AppColors.slate,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
