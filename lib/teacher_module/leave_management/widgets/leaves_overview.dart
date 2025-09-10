import 'package:edudibon_flutter_bloc/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:edudibon_flutter_bloc/core/utils/app_colors.dart';
import 'package:edudibon_flutter_bloc/core/utils/screen_util_helper.dart';

class LeavesOverview extends StatelessWidget {
  const LeavesOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.scaleWidth(16)),
      child: Container(
        width: ScreenUtilHelper.scaleWidth(398),
        height: ScreenUtilHelper.scaleHeight(602),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleRadius(10)),
          border: Border.all(
            color: AppColors.cloud,
            width: 1.0,
          ),
        ),
        child: Column(
          children: [
            _buildMyLeavesHeader(),
            SizedBox(height: ScreenUtilHelper.scaleHeight(15)),
            _buildMainCircularIndicator(),
            SizedBox(height: ScreenUtilHelper.scaleHeight(10)),
            _buildLeavesCountSection(),
            SizedBox(height: ScreenUtilHelper.scaleHeight(20)),
            _buildLeaveTypeIndicators(),
            SizedBox(height: ScreenUtilHelper.scaleHeight(20)),
            _buildAdditionalLeaveIndicators(),
            SizedBox(height: ScreenUtilHelper.scaleHeight(20)),
          ],
        ),
      ),
    );
  }

  Widget _buildMyLeavesHeader() {
    return Container(
      width: ScreenUtilHelper.scaleWidth(399),
      height: ScreenUtilHelper.scaleHeight(65),
      decoration: BoxDecoration(
        color: AppColors.cloud,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12)),
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: ScreenUtilHelper.scaleWidth(16)),
            child: Text(
              "My Leaves",
              style: TextStyle(
                fontSize: ScreenUtilHelper.scaleText(AppStyles.size.heading),
                fontWeight: AppStyles.weight.emphasis,
                color: AppColors.blackHighEmphasis,
              ),
            ),
          ),
          const Spacer(),
          Text(
            "1st Mar- 1st Apr",
            style: TextStyle(
              fontSize: ScreenUtilHelper.scaleText(AppStyles.size.body),
              fontWeight: AppStyles.weight.emphasis,
              color: AppColors.primaryMedium,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.calendar_month,
              color: AppColors.primaryMedium,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainCircularIndicator() {
    return SizedBox(
      width: ScreenUtilHelper.scaleWidth(183),
      height: ScreenUtilHelper.scaleHeight(181),
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            CircularPercentIndicator(
              radius: ScreenUtilHelper.scaleRadius(90),
              lineWidth: ScreenUtilHelper.scaleWidth(10),
              percent: 0.30,
              circularStrokeCap: CircularStrokeCap.round,
              backgroundColor: AppColors.cloud,
              progressColor: AppColors.tertiaryAccent,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "08",
                  style: TextStyle(
                    fontSize: ScreenUtilHelper.scaleText(42),
                    color: AppColors.blackHighEmphasis,
                    fontWeight: AppStyles.weight.emphasis,
                  ),
                ),
                Text(
                  "Completed",
                  style: TextStyle(
                    fontSize: ScreenUtilHelper.scaleText(AppStyles.size.medium),
                    fontWeight: AppStyles.weight.emphasis,
                    color: AppColors.ash,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeavesCountSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.scaleWidth(16)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: ScreenUtilHelper.scaleWidth(8)),
                child: Text(
                  "16",
                  style: TextStyle(
                    fontSize: ScreenUtilHelper.scaleText(AppStyles.size.display),
                    fontWeight: AppStyles.weight.emphasis,
                    color: AppColors.blackHighEmphasis,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: ScreenUtilHelper.scaleWidth(8)),
                child: Text(
                  '18',
                  style: TextStyle(
                    fontSize: ScreenUtilHelper.scaleText(AppStyles.size.display),
                    fontWeight: AppStyles.weight.emphasis,
                    color: AppColors.blackHighEmphasis,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Leaves",
                style: TextStyle(
                  fontSize: ScreenUtilHelper.scaleText(AppStyles.size.medium),
                  fontWeight: AppStyles.weight.emphasis,
                  color: AppColors.ash,
                ),
              ),
              Text(
                'Used Leaves',
                style: TextStyle(
                  fontSize: ScreenUtilHelper.scaleText(AppStyles.size.medium),
                  fontWeight: AppStyles.weight.emphasis,
                  color: AppColors.ash,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLeaveTypeIndicators() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.scaleWidth(8)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSmallCircularIndicator("08", AppColors.pendingLight),
              _buildSmallCircularIndicator("10", AppColors.barChartFailColor2),
              _buildSmallCircularIndicator("0", AppColors.cloud),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text("Sick Leave"),
              Text("Casual Leave"),
              Text("Paid Leave"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAdditionalLeaveIndicators() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.scaleWidth(8)),
      child: Column(
        children: [
          Row(
            children: [
              _buildSmallCircularIndicator("10", AppColors.successDark),
              SizedBox(width: ScreenUtilHelper.scaleWidth(65)),
              _buildSmallCircularIndicator("19", AppColors.warningAccent),
            ],
          ),
          Row(
            children: [
              const Text("Loss of Pay"),
              SizedBox(width: ScreenUtilHelper.scaleWidth(75)),
              const Text("Others"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSmallCircularIndicator(String value, Color color) {
    return SizedBox(
      width: ScreenUtilHelper.scaleWidth(71),
      height: ScreenUtilHelper.scaleHeight(69),
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            CircularPercentIndicator(
              radius: ScreenUtilHelper.scaleRadius(30),
              lineWidth: ScreenUtilHelper.scaleWidth(3),
              percent: 0.30,
              circularStrokeCap: CircularStrokeCap.round,
              backgroundColor: AppColors.cloud,
              progressColor: color,
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: ScreenUtilHelper.scaleText(AppStyles.size.heading),
                color: AppColors.blackHighEmphasis,
                fontWeight: AppStyles.weight.emphasis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
