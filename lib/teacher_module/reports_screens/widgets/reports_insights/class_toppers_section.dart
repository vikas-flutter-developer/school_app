import 'package:edudibon_flutter_bloc/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/screen_util_helper.dart'; // Import screen util
import '../../data/models/student.dart';
import '../../presentation/blocs/student_report/student_report_bloc.dart';
import '../../presentation/screens/student_report/student_report_screen.dart';

class ClassToppersSection extends StatelessWidget {
  final List<Student> toppers;
  final List<String> availableTerms;
  final String selectedTerm;
  final ValueChanged<String?> onTermChanged;

  const ClassToppersSection({
    super.key,
    required this.toppers,
    required this.availableTerms,
    required this.selectedTerm,
    required this.onTermChanged,
  });

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context); // Initialize ScreenUtil

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Class toppers',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColors.blackHighEmphasis,
                fontSize: ScreenUtilHelper.scaleText(20),
              ),
            ),
            SizedBox(
              width: ScreenUtilHelper.scaleWidth(120),
              child: DropdownButtonFormField<String>(
                value: availableTerms.contains(selectedTerm) ? selectedTerm : null,
                items: availableTerms.map((String term) {
                  return DropdownMenuItem<String>(
                    value: term,
                    child: Text(
                      term,
                      style: AppStyles.term.copyWith(
                        fontSize: ScreenUtilHelper.scaleText(14),
                      ),
                    ),
                  );
                }).toList(),
                onChanged: onTermChanged,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: ScreenUtilHelper.scaleWidth(10),
                    vertical: ScreenUtilHelper.scaleHeight(5),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleRadius(8)),
                    borderSide: BorderSide(color: AppColors.cloud),
                  ),
                  filled: true,
                  fillColor: AppColors.white,
                  isDense: true,
                ),
                icon: Icon(Icons.arrow_drop_down, color: AppColors.blackMediumEmphasis),
              ),
            ),
          ],
        ),
        SizedBox(height: ScreenUtilHelper.scaleHeight(16)),
        if (toppers.isEmpty)
          Text(
            "No toppers found for this term.",
            style: AppStyles.selectClass.copyWith(
              fontSize: ScreenUtilHelper.scaleText(14),
            ),
          )
        else
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: toppers
                .map((topper) => Expanded(child: _buildTopperCard(context, topper)))
                .toList(),
          ),
      ],
    );
  }

  Widget _buildTopperCard(BuildContext context, Student topper) {
    Color medalColor;
    double elevation = 0;

    switch (topper.rank) {
      case 1:
        medalColor = AppColors.goldMedal;
        elevation = 100;
        break;
      case 2:
        medalColor = AppColors.silverMedal;
        elevation = 60;
        break;
      case 3:
        medalColor = AppColors.bronzeMedal;
        elevation = 20;
        break;
      default:
        medalColor = AppColors.tertiaryPale;
    }

    return GestureDetector(
      onTap: () {
        final studentReportBloc = context.read<StudentReportBloc>();
        studentReportBloc.add(LoadStudentReport(
          studentId: topper.id,
          initialTermId: selectedTerm,
        ));

        context.push(AppRoutes.studentReport);
      },
      child: Card(
        color: AppColors.white,
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleRadius(12)),
        ),
        margin: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.scaleWidth(4)),
        child: Padding(
          padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(8)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: elevation / 6),
                    child: CircleAvatar(
                      radius: ScreenUtilHelper.scaleWidth(35),
                      backgroundColor: AppColors.white,
                      backgroundImage: AssetImage(topper.photoUrl!),
                      child: topper.photoUrl == null
                          ? Icon(
                        Icons.person,
                        size: ScreenUtilHelper.scaleWidth(35),
                        color: AppColors.ash,
                      )
                          : null,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: CircleAvatar(
                      radius: ScreenUtilHelper.scaleWidth(
                        topper.rank != null && topper.rank! <= 3 ? 15 : 12,
                      ),
                      backgroundColor: medalColor,
                      child: Text(
                        topper.rank.toString(),
                        style: AppStyles.badgeLarge.copyWith(
                          fontSize: ScreenUtilHelper.scaleText(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: ScreenUtilHelper.scaleHeight(8)),
              Text(
                topper.name,
                style: AppStyles.body14Bold.copyWith(
                  fontSize: ScreenUtilHelper.scaleText(14),
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
