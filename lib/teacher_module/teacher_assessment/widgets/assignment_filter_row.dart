import 'package:edudibon_flutter_bloc/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/app_styles.dart';
import '../../../core/utils/screen_util_helper.dart';

class AssignmentFilterRow extends StatelessWidget {
  const AssignmentFilterRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtilHelper.scaleWidth(8),
      ),
      child: Row(
        children: [
          Container(
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
          ),
          SizedBox(width: ScreenUtilHelper.scaleWidth(5)),
          _buildFilterDropdown('Subject'),
          SizedBox(width: ScreenUtilHelper.scaleWidth(5)),
          _buildFilterDropdown('Class'),
          SizedBox(width: ScreenUtilHelper.scaleWidth(5)),
          _buildFilterDropdown('Date'),
        ],
      ),
    );
  }

  Widget _buildFilterDropdown(String text) {
    return InkWell(
      onTap: () {
        print('$text Dropdown tapped!');
      },
      child: Container(
        width: ScreenUtilHelper.scaleWidth(94),
        height: ScreenUtilHelper.scaleHeight(28),
        padding: EdgeInsets.symmetric(
          horizontal: ScreenUtilHelper.scaleWidth(8),
        ),
        decoration: BoxDecoration(
          color: AppColors.linen,
          borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleRadius(2.0)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(text, style: AppStyles.font14),
            Icon(Icons.arrow_drop_down, size: ScreenUtilHelper.scaleWidth(20)),
          ],
        ),
      ),
    );
  }
}
