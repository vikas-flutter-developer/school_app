// Your updated password_success_screen.dart file

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

// ✅ STEP 1: Import the necessary helpers
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/screen_util_helper.dart';
import '../../../../routes/app_routes.dart'; // Adjust path if needed
import 'bloc/change_password_bloc.dart';


class PasswordSuccessScreen extends StatelessWidget {
  const PasswordSuccessScreen({super.key});


  @override
  Widget build(BuildContext context) {
    // ✅ Initialize the helper
    //ScreenUtilHelper.init(context);

    // ❌ STEP 2: Remove old MediaQuery logic.

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        // ✅ Use helper for padding
        padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.width(30)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(flex: 2),

            // Success Icon
            Container(
              // ✅ Use helper for padding and border
              padding: EdgeInsets.all(ScreenUtilHelper.scaleAll(15)),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primaryMedium.withOpacity(0.8), width: ScreenUtilHelper.scaleAll(3)),
              ),
              child: Icon(
                Icons.check_rounded,
                // ✅ Use helper for icon size
                size: ScreenUtilHelper.scaleAll(94),
                color: AppColors.primaryMedium,
              ),
            ),

            SizedBox(height: ScreenUtilHelper.height(30)),

            Text(
              'Congratulations',
              textAlign: TextAlign.center,
              style: GoogleFonts.openSans(
                // ✅ Use helper for font size
                fontSize: ScreenUtilHelper.fontSize(24),
                fontWeight: FontWeight.bold,
                color: AppColors.blackHighEmphasis,
              ),
            ),
            SizedBox(height: ScreenUtilHelper.height(10)),
            Text(
              'Your password is updated',
              textAlign: TextAlign.center,
              style: GoogleFonts.openSans(
                fontSize: ScreenUtilHelper.fontSize(14),
                color: AppColors.ash,
              ),
            ),

            const Spacer(flex: 3),

            ElevatedButton(
              onPressed: () {
                context.read<ChangePasswordBloc>().add(ChangePasswordReset());
                context.go(AppRoutes.login);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryMedium,
                // ✅ Use helper for padding and radius
                padding: EdgeInsets.symmetric(vertical: ScreenUtilHelper.height(16)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(10)),
                ),
                elevation: 2,
              ),
              child: Text(
                'Done',
                style: GoogleFonts.openSans(
                  fontSize: ScreenUtilHelper.fontSize(16),
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                ),
              ),
            ),
            const Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}