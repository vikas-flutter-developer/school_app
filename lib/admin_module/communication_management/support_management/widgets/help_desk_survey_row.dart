import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/screen_util_helper.dart';
import '../models/help_desk_models.dart';

class SurveyRow extends StatelessWidget {
  final Survey survey;
  final VoidCallback onCancel;

  const SurveyRow({super.key, required this.survey, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtilHelper.width(16.0),
        vertical: ScreenUtilHelper.height(12.0),
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.ash,
            width: ScreenUtilHelper.width(1),
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              survey.name,
              style: TextStyle(
                fontSize: ScreenUtilHelper.fontSize(11),
                color: AppColors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              survey.startDate,
              style: TextStyle(
                fontSize: ScreenUtilHelper.fontSize(11),
                color: AppColors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              survey.endDate,
              style: TextStyle(
                fontSize: ScreenUtilHelper.fontSize(11),
                color: AppColors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(
            width: ScreenUtilHelper.width(79),
            height: ScreenUtilHelper.height(26),
            child: ElevatedButton(
              onPressed: onCancel,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.info,
                padding: EdgeInsets.zero,
                alignment: Alignment.center,
              ),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: ScreenUtilHelper.fontSize(12),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}