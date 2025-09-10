import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/screen_util_helper.dart';

class TripDetailsScreen extends StatelessWidget {
  const TripDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtilHelper
    ScreenUtilHelper.init(context);

    return Padding(
      padding: EdgeInsets.only(top: ScreenUtilHelper.height(30)), // <-- Scaled
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColors.black,
              size: ScreenUtilHelper.scaleAll(20), // <-- Scaled
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            "Trip Details",
            style: AppStyles.heading.copyWith(
              color: AppColors.black,
              fontWeight: AppStyles.weight.emphasis,
              fontSize: ScreenUtilHelper.fontSize(18), // <-- Scaled
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.width(16.0)), // <-- Scaled
          child: ListView(
            children: [
              SizedBox(height: ScreenUtilHelper.height(10)), // <-- Scaled
              const _DateHeader(date: "March 16th, 2025"),
              SizedBox(height: ScreenUtilHelper.height(12)), // <-- Scaled
              const TripDetailsCard(),
              SizedBox(height: ScreenUtilHelper.height(24)), // <-- Scaled
              const _DateHeader(date: "March 15th, 2025"),
              SizedBox(height: ScreenUtilHelper.height(12)), // <-- Scaled
              const TripDetailsCard(),
            ],
          ),
        ),
      ),
    );
  }
}

// Helper widget for the Date and the long line
class _DateHeader extends StatelessWidget {
  final String date;
  const _DateHeader({required this.date});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          date,
          style: AppStyles.body14Bold.copyWith(
            color: AppColors.blackHighEmphasis,
            fontSize: ScreenUtilHelper.fontSize(14), // <-- Scaled
          ),
        ),
        SizedBox(width: ScreenUtilHelper.width(8)), // <-- Scaled
        Expanded(
          child: Container(
            height: ScreenUtilHelper.height(1), // <-- Scaled
            color: AppColors.silver,
          ),
        ),
      ],
    );
  }
}

// This card now ONLY contains the trip details, not the date.
class TripDetailsCard extends StatelessWidget {
  const TripDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final TextStyle tripTextStyle = AppStyles.timeRange.copyWith(
      fontSize: ScreenUtilHelper.fontSize(13.5), // <-- Scaled
    );

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: ScreenUtilHelper.height(12.0), // <-- Scaled
        horizontal: ScreenUtilHelper.width(16.0), // <-- Scaled
      ),
      decoration: BoxDecoration(
        color: AppColors.primaryLightest,
        borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(12)), // <-- Scaled
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(right: ScreenUtilHelper.width(30.0)), // <-- Scaled
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Started from bus stop at 8:39am", style: tripTextStyle),
                SizedBox(height: ScreenUtilHelper.height(6)), // <-- Scaled
                Text("Completed at school at 9:00am", style: tripTextStyle),
                SizedBox(height: ScreenUtilHelper.height(6)), // <-- Scaled
                Text("Started from school at 4:40pm", style: tripTextStyle),
                SizedBox(height: ScreenUtilHelper.height(6)), // <-- Scaled
                Text("Completed at bus stop at 5:00pm", style: tripTextStyle),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Icon(
              Icons.warning_amber_outlined,
              color: AppColors.secondaryLighter,
              size: ScreenUtilHelper.scaleAll(24), // <-- Scaled
            ),
          ),
        ],
      ),
    );
  }
}