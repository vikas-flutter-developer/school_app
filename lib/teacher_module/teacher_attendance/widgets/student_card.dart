import 'package:edudibon_flutter_bloc/core/utils/app_colors.dart';
import 'package:edudibon_flutter_bloc/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import '../models/student_model.dart';
import 'package:edudibon_flutter_bloc/core/utils/screen_util_helper.dart'; // Import your helper

class StudentCard extends StatelessWidget {
  final Students student;
  final Function(String)? onStatusChanged;

  const StudentCard({Key? key, required this.student, this.onStatusChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleWidth(8)), // ScreenUtilHelper
          side: BorderSide(
            color: AppColors.cloud,
            width: ScreenUtilHelper.scaleWidth(0.5), // ScreenUtilHelper
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            print('Tapped on ${student.name}');
          },
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(8)), // ScreenUtilHelper
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: ScreenUtilHelper.scaleWidth(35), // ScreenUtilHelper
                            height: ScreenUtilHelper.scaleHeight(35), // ScreenUtilHelper
                            child: CircleAvatar(
                              radius: ScreenUtilHelper.scaleWidth(15), // ScreenUtilHelper
                              backgroundColor: AppColors.parchment,
                              backgroundImage: AssetImage(student.profileImagePath),
                              onBackgroundImageError: (exception, stackTrace) {
                                print('Error loading image: $exception');
                              },
                            ),
                          ),
                          SizedBox(width: ScreenUtilHelper.scaleWidth(8)), // ScreenUtilHelper
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  student.id,
                                  style: TextStyle(
                                    fontSize: ScreenUtilHelper.scaleText(AppStyles.size.tiny), // ScreenUtilHelper
                                    color: AppColors.black,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  student.name,
                                  style: TextStyle(
                                    fontSize: ScreenUtilHelper.scaleText(AppStyles.size.small), // ScreenUtilHelper
                                    fontWeight: AppStyles.weight.medium,
                                    color: AppColors.obsidian,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: ScreenUtilHelper.scaleHeight(10), // ScreenUtilHelper
                color: _getStatusColor(student.status),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Present':
        return AppColors.successAccent;
      case 'Absent':
        return AppColors.errorAccent;
      case 'Late':
        return AppColors.pending;
      default:
        return AppColors.ash;
    }
  }
}
