import 'package:flutter/material.dart';
import '../../core/utils/app_colors.dart';

import '../../core/utils/screen_util_helper.dart';
import 'custom/homework_container.dart';

class HomeworkScreen extends StatelessWidget {
  const HomeworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensure ScreenUtilHelper is initialized
    ScreenUtilHelper.init(context);

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtilHelper.scaleWidth(8),
            vertical: ScreenUtilHelper.scaleHeight(8),
          ),
          child: Row(
            children: [
              _buildFilterContainer(
                Icon(Icons.filter_alt_rounded,
                    color: AppColors.slate, size: ScreenUtilHelper.scaleWidth(20)),
              ),
              SizedBox(width: ScreenUtilHelper.scaleWidth(8)),
              _buildFilterContainer(Row(
                children: [
                  Text(
                    'Subject',
                    style: TextStyle(
                      color: AppColors.slate,
                      fontSize: ScreenUtilHelper.scaleText(14),
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_down,
                      color: AppColors.slate, size: ScreenUtilHelper.scaleWidth(18)),
                ],
              )),
              SizedBox(width: ScreenUtilHelper.scaleWidth(8)),
              _buildFilterContainer(Row(
                children: [
                  Text(
                    'Class',
                    style: TextStyle(
                      color: AppColors.slate,
                      fontSize: ScreenUtilHelper.scaleText(14),
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_down,
                      color: AppColors.slate, size: ScreenUtilHelper.scaleWidth(18)),
                ],
              )),
              SizedBox(width: ScreenUtilHelper.scaleWidth(8)),
              _buildFilterContainer(Row(
                children: [
                  Text(
                    'Date',
                    style: TextStyle(
                      color: AppColors.slate,
                      fontSize: ScreenUtilHelper.scaleText(14),
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_down,
                      color: AppColors.slate, size: ScreenUtilHelper.scaleWidth(18)),
                ],
              )),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtilHelper.scaleWidth(8),
              vertical: ScreenUtilHelper.scaleHeight(8),
            ),
            children: [
              HomeworkContainer(
                title: 'Subject title',
                description: 'Description of the homework',
              ),
              HomeworkContainer(
                title: 'Subject title',
                description: 'Description of the homework.',
              ),
              HomeworkContainer(
                title: 'Subject title',
                description: 'Description of the homework',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilterContainer(Widget child) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtilHelper.scaleWidth(12),
        vertical: ScreenUtilHelper.scaleHeight(8),
      ),
      decoration: BoxDecoration(
        color: AppColors.parchment,
        borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleRadius(8)),
      ),
      child: child,
    );
  }
}
