import 'package:flutter/material.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_styles.dart';
import '../../../core/utils/screen_util_helper.dart';
import '../widgets/assignment_submission.dart';
import 'package:go_router/go_router.dart';

class AssignmentSubmissionScreen extends StatelessWidget implements PreferredSizeWidget {
  const AssignmentSubmissionScreen({Key? key, required String syllabusTitle})
      : super(key: key);

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
                width: ScreenUtilHelper.scaleWidth(153),
                height: ScreenUtilHelper.scaleHeight(39),
                margin: EdgeInsets.symmetric(
                  horizontal: ScreenUtilHelper.scaleWidth(8),
                ),
                child: Image.asset(
                  'assets/images/edudibon.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
        actions: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_none),
                onPressed: () {
                  // Handle notification icon tap
                },
              ),
              Positioned(
                right: ScreenUtilHelper.scaleWidth(15),
                top: 0,
                child: Container(
                  padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(4)),
                  decoration: const BoxDecoration(
                    color: AppColors.error,
                    shape: BoxShape.circle,
                  ),
                  constraints: BoxConstraints(
                    minWidth: ScreenUtilHelper.scaleWidth(16),
                    minHeight: ScreenUtilHelper.scaleHeight(16),
                  ),
                  child: Center(
                    child: Text(
                      '3',
                      style: AppStyles.whiteFont10,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  GoRouter.of(context).pop();
                },
              ),
              Text(
                "Science 1",
                style: AppStyles.headingLPlain,
              ),
            ],
          ),
          SizedBox(height: ScreenUtilHelper.scaleHeight(10)),
          Padding(
            padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(16)),
            child: Container(
              width: ScreenUtilHelper.scaleWidth(392),
              height: ScreenUtilHelper.scaleHeight(40),
              decoration: BoxDecoration(
                color: AppColors.ivory,
                borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleRadius(10)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Name", style: AppStyles.headingText),
                  Text("Status", style: AppStyles.headingText),
                  Text("Submission", style: AppStyles.headingText),
                  Text("Grade", style: AppStyles.headingText),
                ],
              ),
            ),
          ),
          SizedBox(height: ScreenUtilHelper.scaleHeight(30)),
          const AssignmentSubmission(
            name: "Mayuri shah",
            progress: 0.6,
            status: "On time",
            grade: "35/50",
            feedback: "Teacher feedback",
            imagePath: 'assets/images/profileimage.png',
          ),
          const AssignmentSubmission(
            name: "Mayuri shah",
            progress: 0.6,
            status: "Late",
            grade: "35/50",
            feedback: "Teacher feedback",
            imagePath: 'assets/images/profileimage.png',
          ),
          const AssignmentSubmission(
            name: "Mayuri shah",
            progress: 0.6,
            status: "in complete",
            grade: "35/50",
            feedback: "Teacher feedback",
            imagePath: 'assets/images/profileimage.png',
          ),
          const AssignmentSubmission(
            name: "Mayuri shah",
            progress: 0.6,
            status: "On time",
            grade: "35/50",
            feedback: "Teacher feedback",
            imagePath: 'assets/images/profileimage.png',
          ),
          const AssignmentSubmission(
            name: "Mayuri shah",
            progress: 0.6,
            status: "On time",
            grade: "35/50",
            feedback: "Teacher feedback",
            imagePath: 'assets/images/profileimage.png',
          ),
          const AssignmentSubmission(
            name: "Mayuri shah",
            progress: 0.6,
            status: "Late",
            grade: "35/50",
            feedback: "Teacher feedback",
            imagePath: 'assets/images/profileimage.png',
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
