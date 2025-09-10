import 'package:edudibon_flutter_bloc/routes/app_routes.dart';
import 'package:edudibon_flutter_bloc/teacher_module/teacher_assessment/screens/teacher_syllable_unit.dart'
    show TeacherSyllableUnit;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_styles.dart';
import '../../../core/utils/screen_util_helper.dart';
import '../models/syllabus_model.dart';
import '../screens/assignment_submission_screen.dart';

class SyllabusCard extends StatelessWidget {
  final SyllabusItems item;

  const SyllabusCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>context.push(AppRoutes.assignmentSubmission,extra: item),
      borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleRadius(7.4)),
      child: Container(
        width: ScreenUtilHelper.scaleWidth(398),
        height: ScreenUtilHelper.scaleHeight(161.05),
        decoration: BoxDecoration(
          color: item.color,
          borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleRadius(7.4)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: ScreenUtilHelper.scaleWidth(16),
                top: ScreenUtilHelper.scaleHeight(16),
              ),
              child: Text(
                item.title,
                style: AppStyles.heading18SemiBoldPrimary2,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: ScreenUtilHelper.scaleWidth(16),
              ),
              child: Text(
                item.description,
                style: AppStyles.body12TextPrimary2,
              ),
            ),
            SizedBox(height: ScreenUtilHelper.scaleHeight(20)),
            Padding(
              padding: EdgeInsets.only(left: ScreenUtilHelper.scaleWidth(16)),
              child: Row(
                children: [
                  Container(
                    width: ScreenUtilHelper.scaleWidth(250.34),
                    height: ScreenUtilHelper.scaleHeight(9.26),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        ScreenUtilHelper.scaleRadius(12.03),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        ScreenUtilHelper.scaleRadius(12.03),
                      ),
                      child: LinearProgressIndicator(
                        value: item.progress,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          AppColors.primaryMedium,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: ScreenUtilHelper.scaleWidth(25)),
                  Container(
                    width: ScreenUtilHelper.scaleWidth(60.87),
                    height: ScreenUtilHelper.scaleHeight(22.13),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        ScreenUtilHelper.scaleRadius(11.27),
                      ),
                      border: Border.all(
                        color: AppColors.black,
                        width: ScreenUtilHelper.scaleWidth(1.02),
                      ),
                    ),
                    child: TextButton(
                      onPressed: ()=>context.push(AppRoutes.syllabusUnit,extra: item),
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      child: Text(
                        "View More",
                        style: AppStyles.body10ActionText,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: ScreenUtilHelper.scaleWidth(16)),
              child: Text(
                "1 Chapter completed",
                style: AppStyles.body10ActionTextBold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
