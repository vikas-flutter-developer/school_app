import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/app_colors.dart'; // Update to correct path
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/screen_util_helper.dart'; //
import '../../data/models/student.dart';

class StudentHeader extends StatelessWidget {
  final Student student;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const StudentHeader({
    super.key,
    required this.student,
    required this.onPrevious,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);
    final DateFormat admissionFormat = DateFormat('d MMMM, yyyy');

    return Container(
      padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(16.0)),
      decoration: BoxDecoration(
        color: AppColors.secondaryExtreme,
        borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleRadius(12.0)),
        border: Border.all(color: AppColors.accentDark),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildNavButton(context, Icons.arrow_back_ios, onPrevious),
              const Spacer(),
              CircleAvatar(
                radius: ScreenUtilHelper.scaleRadius(50),
                backgroundColor: AppColors.parchment,
                backgroundImage: student.photoUrl != null
                    ? NetworkImage(student.photoUrl!)
                    : null,
                child: student.photoUrl == null
                    ? Icon(Icons.person,
                    size: ScreenUtilHelper.scaleWidth(50),
                    color: AppColors.ash)
                    : null,
              ),
              const Spacer(),
              _buildNavButton(context, Icons.arrow_forward_ios, onNext),
            ],
          ),
          SizedBox(height: ScreenUtilHelper.scaleHeight(12)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                student.name,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.blackHighEmphasis,
                  fontSize: ScreenUtilHelper.scaleText(
                      Theme.of(context).textTheme.headlineSmall?.fontSize ??
                          24),
                ),
                textAlign: TextAlign.center,
              ),
              if (student.rank != null) ...[
                SizedBox(width: ScreenUtilHelper.scaleWidth(10)),
                Chip(
                  label: Text('Rank ${student.rank}',
                      style: AppStyles.rankLabel.copyWith(
                        fontSize: ScreenUtilHelper.scaleText(12),
                      )),
                  backgroundColor: AppColors.primaryDarkest,
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtilHelper.scaleWidth(8),
                    vertical: ScreenUtilHelper.scaleHeight(2),
                  ),
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ],
          ),
          SizedBox(height: ScreenUtilHelper.scaleHeight(4)),
          Text(
            "Class: ${student.className} | Roll no: ${student.rollNo}",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.slate,
              fontSize: ScreenUtilHelper.scaleText(
                  Theme.of(context).textTheme.titleMedium?.fontSize ?? 16),
            ),
          ),
          SizedBox(height: ScreenUtilHelper.scaleHeight(16)),
          const Divider(),
          SizedBox(height: ScreenUtilHelper.scaleHeight(10)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildInfoColumn("Academic Year", student.academicYear),
              _buildInfoColumn("Admission Number", student.admissionNumber),
              _buildInfoColumn("Date of admission",
                  admissionFormat.format(student.dateOfAdmission)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavButton(
      BuildContext context, IconData icon, VoidCallback onPressed) {
    ScreenUtilHelper.init(context);
    return IconButton(
      icon: Icon(icon,
          color: AppColors.secondaryLighter,
          size: ScreenUtilHelper.scaleWidth(28)),
      onPressed: onPressed,
      splashRadius: ScreenUtilHelper.scaleRadius(25),
      highlightColor: AppColors.accentDark,
    );
  }

  Widget _buildInfoColumn(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: AppStyles.bodySmallDark.copyWith(
                fontSize: ScreenUtilHelper.scaleText(12))),
        SizedBox(height: ScreenUtilHelper.scaleHeight(2)),
        Text(value,
            style:
            AppStyles.body13Medium.copyWith(fontSize: ScreenUtilHelper.scaleText(13))),
      ],
    );
  }
}
