import 'package:edudibon_flutter_bloc/teacher_module/teacher_assessment/screens/preview_assignment.dart'
    show AssignmentPreviewScreen;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_styles.dart';
import '../../../core/utils/screen_util_helper.dart';
import '../../../routes/app_routes.dart';

class AssignmentQuestion extends StatelessWidget implements PreferredSizeWidget {
  const AssignmentQuestion({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Row(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: ScreenUtilHelper.scaleWidth(153.07),
                height: ScreenUtilHelper.scaleHeight(39),
                margin: EdgeInsets.symmetric(
                  horizontal: ScreenUtilHelper.scaleWidth(8.0),
                ),
                child: Image.asset(
                  'assets/images/edudibon.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
        actions: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_none),
                onPressed: () {},
              ),
              Positioned(
                right: ScreenUtilHelper.scaleWidth(15),
                top: 0,
                child: Container(
                  padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(4.0)),
                  decoration: const BoxDecoration(
                    color: AppColors.error,
                    shape: BoxShape.circle,
                  ),
                  constraints: BoxConstraints(
                    minWidth: ScreenUtilHelper.scaleWidth(16),
                    minHeight: ScreenUtilHelper.scaleWidth(16),
                  ),
                  child: Center(
                    child: Text(
                      '3',
                      style: AppStyles.badge1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: ScreenUtilHelper.scaleWidth(8.0),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () => GoRouter.of(context).pop(),
                ),
                Text("Assignment Title", style: AppStyles.headingL),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtilHelper.scaleWidth(45),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total 50 marks", style: AppStyles.bodyMedium),
                    Text("00:30", style: AppStyles.timerText),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtilHelper.scaleWidth(45),
                ),
                child: Text(
                  "All questions are compulsory",
                  style: AppStyles.body10Primary,
                ),
              ),
              SizedBox(height: ScreenUtilHelper.scaleHeight(50)),
              Padding(
                padding: EdgeInsets.only(
                  left: ScreenUtilHelper.scaleWidth(45),
                ),
                child: Text("How is the weather*", style: AppStyles.body20Primary),
              ),
              SizedBox(height: ScreenUtilHelper.scaleHeight(5)),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtilHelper.scaleWidth(45),
                ),
                child: Column(
                  children: [
                    ...["Good", "Bad", "Worst", "None of this above"].map(
                          (label) => Container(
                        width: ScreenUtilHelper.scaleWidth(343),
                        height: ScreenUtilHelper.scaleHeight(34),
                        margin: EdgeInsets.only(
                          bottom: ScreenUtilHelper.scaleHeight(8),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              ScreenUtilHelper.scaleRadius(1)),
                          border: Border.all(color: AppColors.cloud),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(
                            ScreenUtilHelper.scaleWidth(5.0),
                          ),
                          child: Text(
                            label,
                            style: AppStyles.body16OptionText,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: ScreenUtilHelper.scaleHeight(5)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [Icon(Icons.add)],
                    ),
                    SizedBox(height: ScreenUtilHelper.scaleHeight(100)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: ScreenUtilHelper.scaleWidth(100),
                          height: ScreenUtilHelper.scaleHeight(30),
                          child: OutlinedButton(
                            onPressed: ()=>context.push(AppRoutes.previewAssignment),
                            style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    ScreenUtilHelper.scaleRadius(6.0)),
                              ),
                              side: const BorderSide(
                                width: 1.0,
                                color: AppColors.primaryMedium,
                              ),
                            ),
                            child: Text(
                              "Preview",
                              style: AppStyles.bodyMedium,
                            ),
                          ),
                        ),
                        SizedBox(width: ScreenUtilHelper.scaleWidth(5)),
                        ElevatedButton(
                          onPressed: () {
                            // TODO: Implement publish
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: AppColors.primaryDarkest,
                            minimumSize: Size(
                              ScreenUtilHelper.scaleWidth(100),
                              ScreenUtilHelper.scaleHeight(30),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  ScreenUtilHelper.scaleRadius(6)),
                            ),
                          ),
                          child: const Text("Publish"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
