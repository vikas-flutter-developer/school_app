import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/screen_util_helper.dart';
import '../staff_management/bloc/staff_form_bloc.dart';
import '../staff_management/bloc/staff_form_state.dart';

class StaffProfileHeader extends StatelessWidget {
  const StaffProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StaffFormBloc, StaffFormState>(
      builder: (context, state) {
        if (state is StaffFormLoaded || state is StaffFormInitial) {
          final form = state is StaffFormLoaded
              ? state.form
              : (state as StaffFormInitial).form;

          if (form == null) return const SizedBox.shrink();

          return Container(
            height: ScreenUtilHelper.scaleHeight(202),
            width: ScreenUtilHelper.scaleWidth(390),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(
                ScreenUtilHelper.radius(15),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: ScreenUtilHelper.height(15),
                      left: ScreenUtilHelper.width(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Staff Id", style: AppStyles.label1),
                        SizedBox(height: ScreenUtilHelper.height(6)),
                        Text(form.staffId, style: AppStyles.staffId),
                        SizedBox(height: ScreenUtilHelper.height(100)),
                        Text(
                          form.isVerified ? "Verified" : "Not Verified",
                          style: TextStyle(
                            fontSize: ScreenUtilHelper.fontSize(16),
                            color: form.isVerified
                                ? AppColors.verified
                                : AppColors.notVerified,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: ScreenUtilHelper.width(20)),
                Padding(
                  padding: EdgeInsets.only(
                    top: ScreenUtilHelper.height(15),
                    right: ScreenUtilHelper.width(15),
                  ),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                          ScreenUtilHelper.radius(12),
                        ),
                        child: SizedBox(
                          width: ScreenUtilHelper.width(123),
                          height: ScreenUtilHelper.height(151),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.asset(
                                (form.photoUrl?.isNotEmpty ?? false)
                                    ? 'assets/images/profile_img.png'
                                    : 'assets/images/profile_img.png',
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    'assets/images/profile_img.png',
                                    fit: BoxFit.cover,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: ScreenUtilHelper.height(8)),
                      SizedBox(
                        width: ScreenUtilHelper.width(96),
                        height: ScreenUtilHelper.height(19),
                        child: const Text(
                          "Upload Photo",
                          style: AppStyles.uploadLabel1,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
