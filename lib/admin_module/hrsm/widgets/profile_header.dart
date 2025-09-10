import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/screen_util_helper.dart';
import '../staff_management/model/employee_entity.dart';

class ProfileHeader extends StatelessWidget {
  final EmployeeEntity employee;

  const ProfileHeader({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        ScreenUtilHelper.width(12),
        ScreenUtilHelper.height(16),
        ScreenUtilHelper.width(12),
        ScreenUtilHelper.height(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: Back button, logo, notification
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.black,
                  size: ScreenUtilHelper.fontSize(22), // ScreenUtilHelper
                ),
              ),
              SizedBox(width: ScreenUtilHelper.width(6)),
              Image.asset(
                'assets/images/edudibon_logo.png',
                height: ScreenUtilHelper.height(39),
                width: ScreenUtilHelper.width(159),
                fit: BoxFit.fill,
              ),
              const Spacer(),
              Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.notifications_none),
                    iconSize: ScreenUtilHelper.fontSize(24),
                    onPressed: () {
                      // Handle notification button press
                    },
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: ScreenUtilHelper.width(14),
                      height: ScreenUtilHelper.height(14),
                      decoration: const BoxDecoration(
                        color: AppColors.notVerified,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '1',
                          style: AppStyles.notificationText.copyWith(
                            fontSize: ScreenUtilHelper.fontSize(9),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: ScreenUtilHelper.height(24)),

          // Name
          Text(employee.name, style: AppStyles.headingLarge),
          SizedBox(height: ScreenUtilHelper.height(16)),

          // Profile Row matching screenshot
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Image
              ClipRRect(
                borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8)), // ScreenUtilHelper
                child: Image.asset(
                  'assets/images/teacher_profile.png',
                  height: ScreenUtilHelper.height(120), // ScreenUtilHelper
                  width: ScreenUtilHelper.width(100), // ScreenUtilHelper
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: ScreenUtilHelper.width(16)), // ScreenUtilHelper

              // Staff Info
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Staff Id',
                    style: AppStyles.labelGrey,
                  ),
                  SizedBox(height: ScreenUtilHelper.height(4)), // ScreenUtilHelper
                  Text(
                    employee.staffId,
                    style: AppStyles.subsectionTitle,
                  ),
                  SizedBox(height: ScreenUtilHelper.height(8)), // ScreenUtilHelper
                  Text(
                    'Verified',
                    style: AppStyles.verified.copyWith(color: AppColors.verified),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
