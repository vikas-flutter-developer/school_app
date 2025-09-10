import 'package:edudibon_flutter_bloc/core/utils/app_colors.dart';
import 'package:edudibon_flutter_bloc/teacher_module/teacher_assessment/models/assignment_model.dart'
    show Assignment;
import 'package:flutter/material.dart';
import '../../../core/utils/screen_util_helper.dart';

class AssignmentItem extends StatelessWidget {
  final Assignment assignment;

  const AssignmentItem({Key? key, required this.assignment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: ScreenUtilHelper.scaleWidth(58),
          height: ScreenUtilHelper.scaleHeight(50),
          decoration: BoxDecoration(
            color: AppColors.ivory,
            borderRadius: BorderRadius.circular(
              ScreenUtilHelper.scaleRadius(6),
            ),
          ),
          child: Center(
            child: Image.asset(
              'assets/images/assignment_submitted.png',
              width: ScreenUtilHelper.scaleWidth(46),
              height: ScreenUtilHelper.scaleHeight(40),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: ScreenUtilHelper.scaleHeight(5)),
        Text(
          assignment.subject,
          style: TextStyle(
            fontSize: ScreenUtilHelper.scaleText(12), // optional scaling
          ),
        ),
      ],
    );
  }
}
