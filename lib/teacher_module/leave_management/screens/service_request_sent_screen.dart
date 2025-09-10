import 'package:edudibon_flutter_bloc/core/utils/app_colors.dart';
import 'package:edudibon_flutter_bloc/core/utils/app_styles.dart';
import 'package:edudibon_flutter_bloc/core/utils/screen_util_helper.dart';
import 'package:edudibon_flutter_bloc/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/notification_badge.dart';

class ServiceRequestSentScreen extends StatelessWidget {
  const ServiceRequestSentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Padding(
          padding: EdgeInsets.only(left: ScreenUtilHelper.scaleWidth(16)),
          child: Row(
            children: [
              SizedBox(
                width: ScreenUtilHelper.scaleWidth(32),
                height: ScreenUtilHelper.scaleHeight(32),
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios, size: ScreenUtilHelper.scaleText(20)),
                  onPressed: ()=>context.go(AppRoutes.leaveOverview),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ),
              Container(
                width: ScreenUtilHelper.scaleWidth(153.07),
                height: ScreenUtilHelper.scaleHeight(39),
                margin: EdgeInsets.only(left: ScreenUtilHelper.scaleWidth(4)),
                child: Image.asset(
                  'assets/images/edudibon.png',
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
        actions: const [NotificationBadge(count: 3)],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: ScreenUtilHelper.scaleWidth(100),
              height: ScreenUtilHelper.scaleHeight(100),
              child: Image.asset(
                'assets/images/approved.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(height: ScreenUtilHelper.scaleHeight(16)),
          Text(
            "Request Sent",
            style: TextStyle(
              fontSize: ScreenUtilHelper.scaleText(AppStyles.size.display),
              fontWeight: AppStyles.weight.regular,
              color: AppColors.blackHighEmphasis,
            ),
          ),
        ],
      ),
    );
  }
}
