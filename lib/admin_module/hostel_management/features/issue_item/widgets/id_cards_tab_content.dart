import 'package:flutter/material.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/screen_util_helper.dart';

class IDCardsTabContent extends StatelessWidget {
  const IDCardsTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);

    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: ScreenUtilHelper.height(20)),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtilHelper.width(16.0)),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: ScreenUtilHelper.height(40),
                      color: AppColors.secondaryLightest,
                      child: Padding(
                        padding:
                        EdgeInsets.symmetric(horizontal: ScreenUtilHelper.width(8.0)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Name",
                              style: AppStyles.bodySmall.copyWith(color: AppColors.black),
                            ),
                            Text(
                              "Date",
                              style: AppStyles.bodySmall.copyWith(color: AppColors.black),
                            ),
                            Text(
                              "Status",
                              style: AppStyles.bodySmall.copyWith(color: AppColors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: ScreenUtilHelper.height(10)),
                    Padding(
                      padding:
                      EdgeInsets.symmetric(vertical: ScreenUtilHelper.height(8.0)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Mayuri Shah",
                            style: AppStyles.bodySmall,
                          ),
                          Text(
                            "12/02/25",
                            style: AppStyles.bodySmall,
                          ),
                          Text(
                            "Issued",
                            style: AppStyles.bodySmall.copyWith(color: AppColors.success),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: ScreenUtilHelper.height(10)),
                    Padding(
                      padding:
                      EdgeInsets.symmetric(vertical: ScreenUtilHelper.height(8.0)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Mayuri Shah",
                            style: AppStyles.bodySmall,
                          ),
                          Text(
                            "12/02/25",
                            style: AppStyles.bodySmall,
                          ),
                          Text(
                            "Pending",
                            style: AppStyles.bodySmall.copyWith(color: AppColors.error),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: ScreenUtilHelper.height(10)),
                    Padding(
                      padding:
                      EdgeInsets.symmetric(vertical: ScreenUtilHelper.height(8.0)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Mayuri Shah",
                            style: AppStyles.bodySmall,
                          ),
                          Text(
                            "12/02/25",
                            style: AppStyles.bodySmall,
                          ),
                          Text(
                            "Issued",
                            style: AppStyles.bodySmall.copyWith(color:AppColors.success),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: ScreenUtilHelper.height(10)),
                    Padding(
                      padding:
                      EdgeInsets.symmetric(vertical: ScreenUtilHelper.height(8.0)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Mayuri Shah",
                            style: AppStyles.bodySmall,
                          ),
                          Text(
                            "12/02/25",
                            style: AppStyles.bodySmall,
                          ),
                          Text(
                            "Issued",
                            style: AppStyles.bodySmall.copyWith(color:AppColors.success),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: ScreenUtilHelper.width(16.0),
          bottom: ScreenUtilHelper.height(70.0),
          child: SizedBox(
            width: ScreenUtilHelper.width(109),
            height: ScreenUtilHelper.height(30),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondaryContrast,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(ScreenUtilHelper.radius(6)),
                ),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [Text("Create"), Icon(Icons.add)],
              ),
            ),
          ),
        ),
      ],
    );
  }
}