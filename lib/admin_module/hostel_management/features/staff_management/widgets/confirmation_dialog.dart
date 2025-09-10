import 'package:edudibon_flutter_bloc/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/screen_util_helper.dart';
import '../bloc/staff_form_bloc/staff_form_bloc.dart';

void showAppConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,

    builder: (BuildContext dialogContext) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(16)),
        ),
        contentPadding: EdgeInsets.all(ScreenUtilHelper.width(24)),
        content: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: ScreenUtilHelper.width(350),
            maxHeight: ScreenUtilHelper.height(200),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: ScreenUtilHelper.height(10)),
              Text(
                'Are you sure?',
                style: AppStyles.headingLargeEmphasis,
              ),
              SizedBox(height: ScreenUtilHelper.height(20)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: ScreenUtilHelper.width(100),
                    height: ScreenUtilHelper.height(40),
                    child: OutlinedButton(
                      onPressed: () {
                        // SAHI TARIKA: Dialog ko band karne ke liye Navigator.pop ka istemal karein
                        Navigator.of(dialogContext).pop();
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.ash),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(ScreenUtilHelper.radius(10)),
                        ),
                      ),
                      child: Text(
                        'No',
                        style: AppStyles.bodySmallEmphasis.copyWith(color: AppColors.black),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: ScreenUtilHelper.width(100),
                    height: ScreenUtilHelper.height(40),
                    child: ElevatedButton(
                      onPressed: () {
                        // 1. Pehle BLoC ko event bhejein
                        // `context` (original screen ka) ka istemal BLoC ko access karne ke liye karein
                        context.read<StaffFormBloc>().add(SubmitStaffForm());

                        // 2. Fir dialog ko band karein
                        // `dialogContext` ka istemal dialog ko band karne ke liye karein
                        Navigator.of(dialogContext).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(ScreenUtilHelper.radius(10)),
                        ),
                      ),
                      child: Text(
                        'Yes',
                        style: AppStyles.bodySmallEmphasis,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: ScreenUtilHelper.height(10)),
            ],
          ),
        ),
      );
    },
  );
}