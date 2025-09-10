// submission_success_screen.dart
import 'package:edudibon_flutter_bloc/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/screen_util_helper.dart';
import '../../../../../routes/app_routes.dart';
import '../../../widgets/app_logo.dart';
import '../../../widgets/notification_button.dart';
import '../bloc/confirmation/confirmation_bloc.dart';

class SubmissionSuccessScreen extends StatelessWidget {
  const SubmissionSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ConfirmationBloc()..add(ShowConfirmation()),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: ()=>context.go(AppRoutes.teacherDashboard)
          ),
          title: const AppLogo(),
          actions: const [NotificationButton()],
          backgroundColor: AppColors.white,
          foregroundColor: AppColors.black,
          elevation: 0,
        ),
        body: BlocBuilder<ConfirmationBloc, ConfirmationState>(
          builder: (context, state) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle,
                    size: ScreenUtilHelper.scaleWidth(100), // Responsive icon
                    color: AppColors.primaryDarker,
                  ),
                  SizedBox(height: ScreenUtilHelper.scaleHeight(24)),
                  Text(
                    'Submitted',
                    style: TextStyle(
                      fontSize: ScreenUtilHelper.scaleText(24),
                      fontWeight: AppStyles.weight.medium,
                      color: AppColors.black,
                    ),
                  ),
                  SizedBox(height: ScreenUtilHelper.scaleHeight(80)),
                ],
              ),
            );
          },
        ),
        backgroundColor: AppColors.white,
      ),
    );
  }
}
