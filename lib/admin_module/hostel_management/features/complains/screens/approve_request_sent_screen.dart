import 'package:edudibon_flutter_bloc/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/screen_util_helper.dart';

class ApproveRequestSentScreen extends StatelessWidget {
  const ApproveRequestSentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        titleSpacing: 0,
        title: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: ScreenUtilHelper.width(16.0)),
          child: Row(
            children: [
              SizedBox(
                width: ScreenUtilHelper.width(32),
                height: ScreenUtilHelper.height(32),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: ScreenUtilHelper.scaleAll(20),
                    color: AppColors.blackMediumEmphasis,
                  ),
                  onPressed: () {
                    GoRouter.of(context).pop();
                  },
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ),
              SizedBox(width: ScreenUtilHelper.width(4)),
              SizedBox(
                width: ScreenUtilHelper.width(153.07),
                height: ScreenUtilHelper.height(39),
                child: Image.asset(
                  'assets/images/edudibon.png',
                  fit: BoxFit.contain,
                ),
              ),
              const Spacer(),
              Stack(
                alignment: Alignment.topRight,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.notifications_none_outlined,
                      color: AppColors.blackMediumEmphasis,
                      size: ScreenUtilHelper.scaleAll(28),
                    ),
                    onPressed: () {},
                  ),
                  Positioned(
                    right: ScreenUtilHelper.width(8),
                    top: ScreenUtilHelper.height(8),
                    child: Container(
                      padding: EdgeInsets.all(ScreenUtilHelper.width(2)),
                      decoration: BoxDecoration(
                        color: AppColors.error,
                        borderRadius:
                        BorderRadius.circular(ScreenUtilHelper.radius(8)),
                      ),
                      constraints: BoxConstraints(
                        minWidth: ScreenUtilHelper.width(16),
                        minHeight: ScreenUtilHelper.height(16),
                      ),
                      child: Text(
                        '3',
                        style: AppStyles.badgeLarge.copyWith(color: AppColors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: ScreenUtilHelper.width(100),
              height: ScreenUtilHelper.height(100),
              child: Image.asset(
                'assets/images/approved.png',
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: ScreenUtilHelper.height(20)),
            Text(
              "Action Taken",
              style: TextStyle(
                fontSize: ScreenUtilHelper.fontSize(24),
                fontWeight: FontWeight.w400,
                color: AppColors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}