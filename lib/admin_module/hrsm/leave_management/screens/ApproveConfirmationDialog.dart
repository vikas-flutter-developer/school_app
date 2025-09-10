import 'package:edudibon_flutter_bloc/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/screen_util_helper.dart';
import '../../staff_management/screens/approved_page.dart';
import 'leave_screen.dart';

class ApproveConfirmationDialog extends StatelessWidget {
  const ApproveConfirmationDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8)),
        color: Colors.white,
        child: Container(
          width: ScreenUtilHelper.width(430), // Fixed width
          height: ScreenUtilHelper.height(153), // Fixed height
          padding: EdgeInsets.all(ScreenUtilHelper.width(16)),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                child: Text(
                  'Are  you sure ?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: ScreenUtilHelper.fontSize(23),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: ScreenUtilHelper.height(8)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: ScreenUtilHelper.width(100),
                    height: ScreenUtilHelper.height(40),
                    child: OutlinedButton(
                      onPressed: () {
                        GoRouter.of(context).pop();
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppColors.cloud),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            ScreenUtilHelper.radius(4),
                          ),
                        ),
                      ),
                      child: Text(
                        'No',
                        style: TextStyle(
                          fontSize: ScreenUtilHelper.fontSize(14),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: ScreenUtilHelper.width(10)),
                  SizedBox(
                    width: ScreenUtilHelper.width(100),
                    height: ScreenUtilHelper.height(40),
                    child: ElevatedButton(
                      onPressed: () {
                        context.pop();
                        context.push(AppRoutes.leaveApproved);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryMedium,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            ScreenUtilHelper.radius(4),
                          ),
                        ),
                      ),
                      child: Text(
                        'Yes',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: ScreenUtilHelper.fontSize(14),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
