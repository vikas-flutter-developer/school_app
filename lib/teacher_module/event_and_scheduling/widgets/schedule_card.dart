import 'package:flutter/material.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_styles.dart';
import '../../../core/utils/screen_util_helper.dart';
import '../models/schedule_model.dart';

class ScheduleCard extends StatelessWidget {
  final ScheduleModel schedule;

  const ScheduleCard({super.key, required this.schedule});

  @override
  Widget build(BuildContext context) {
    final double leftSectionWidth = ScreenUtilHelper.scaleWidth(90);
    final double cardHeight = ScreenUtilHelper.scaleHeight(93);

    return Container(
      height: cardHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleWidth(12)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleWidth(12)),
        child: Row(
          children: [
            // Left Section (Time)
            Container(
              width: leftSectionWidth,
              height: cardHeight,
              color: AppColors.secondaryLighter,
              padding: EdgeInsets.symmetric(
                vertical: ScreenUtilHelper.scaleHeight(10),
                horizontal: ScreenUtilHelper.scaleWidth(5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    schedule.time.split(' ')[0],
                    style: TextStyle(
                      color: AppColors.white,
                      fontWeight: AppStyles.weight.emphasis,
                      fontSize: ScreenUtilHelper.scaleText(17),
                    ),
                    maxLines: 1,
                  ),
                  SizedBox(height: ScreenUtilHelper.scaleHeight(2)),
                  Text(
                    schedule.day,
                    style: TextStyle(
                      color: AppColors.ash,
                      fontSize:
                      ScreenUtilHelper.scaleText(AppStyles.size.small),
                    ),
                  ),
                ],
              ),
            ),

            // Right Section (Details)
            Expanded(
              child: Container(
                height: cardHeight,
                color: const Color.fromRGBO(237, 236, 248, 1),
                padding: EdgeInsets.only(
                  left: ScreenUtilHelper.scaleWidth(15),
                  right: ScreenUtilHelper.scaleWidth(10),
                  top: ScreenUtilHelper.scaleHeight(8),
                  bottom: ScreenUtilHelper.scaleHeight(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        schedule.date,
                        style: TextStyle(
                          fontSize: ScreenUtilHelper.scaleText(9),
                          fontWeight: AppStyles.weight.emphasis,
                          color: AppColors.blackMediumEmphasis,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          schedule.title,
                          style: TextStyle(
                            fontSize: ScreenUtilHelper
                                .scaleText(AppStyles.size.body),
                            fontWeight: AppStyles.weight.emphasis,
                            color: AppColors.blackHighEmphasis,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: ScreenUtilHelper.scaleHeight(4)),
                        Text(
                          schedule.venue,
                          style: TextStyle(
                            fontSize: ScreenUtilHelper
                                .scaleText(AppStyles.size.small),
                            fontWeight: AppStyles.weight.regular,
                            color: AppColors.blackMediumEmphasis,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                        onTap: () {
                          print('More details tapped for ${schedule.title}');
                        },
                        child: Text(
                          "more",
                          style: TextStyle(
                            fontSize: ScreenUtilHelper
                                .scaleText(AppStyles.size.tiny),
                            fontWeight: AppStyles.weight.emphasis,
                            color: AppColors.blackMediumEmphasis,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
