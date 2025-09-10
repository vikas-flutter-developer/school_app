import 'package:edudibon_flutter_bloc/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/screen_util_helper.dart'; // Import ScreenUtilHelper

class SuccessDialogContent extends StatelessWidget {
  final String actionType;
  final String sendVia;

  const SuccessDialogContent({
    super.key,
    required this.actionType,
    required this.sendVia,
  });

  @override
  Widget build(BuildContext context) {
    // Initialize the ScreenUtilHelper
    ScreenUtilHelper.init(context);

    String title;
    String subtitle;
    String buttonText = actionType == "Sent" ? "Create New" : "Schedule New";

    if (sendVia == 'Email') {
      title = 'Email $actionType Successfully!';
      subtitle =
      'Your Email has been ${actionType.toLowerCase()} successfully to the recipient';
    } else {
      title = 'SMS $actionType Successfully!';
      subtitle =
      'Your message has been ${actionType.toLowerCase()} successfully to the recipient';
    }

    return Container(
      width: ScreenUtilHelper.width(336), // Scaled width
      height: ScreenUtilHelper.height(337), // Scaled height
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(10)), // Scaled border radius
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.1),
            blurRadius: 10.0,
            spreadRadius: 1.0,
          ),
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtilHelper.width(24), // Scaled horizontal padding
              vertical: ScreenUtilHelper.height(20), // Scaled vertical padding
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Spacer(flex: 2),

                // --- IMAGE ADDED HERE ---
                // Pichle check icon ko is image se replace kiya gaya hai.
                Image.asset(
                  'assets/images/dialogbox.png', // Aapka image path
                  width: ScreenUtilHelper.width(85),
                  height: ScreenUtilHelper.height(85),
                  // Agar image load na ho to error dikhane ke liye
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.check_circle, // Fallback icon
                      size: ScreenUtilHelper.width(85),
                      color: AppColors.success,
                    );
                  },
                ),
                // --- END OF IMAGE ---

                SizedBox(height: ScreenUtilHelper.height(28)), // Scaled spacing
                Text(
                  title,
                  style: TextStyle(
                    fontSize: ScreenUtilHelper.fontSize(16), // Scaled font size
                    fontWeight: AppStyles.weight.emphasis,
                    color: AppColors.charcoal,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: ScreenUtilHelper.height(12)), // Scaled spacing
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: ScreenUtilHelper.fontSize(15), // Scaled font size
                    color: AppColors.charcoal,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Spacer(flex: 1),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.tertiaryAccent,
                    foregroundColor: AppColors.white,
                    minimumSize: Size(ScreenUtilHelper.width(180), ScreenUtilHelper.height(48)), // Scaled button size
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(6)), // Scaled button radius
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtilHelper.width(25), // Scaled horizontal padding
                      vertical: ScreenUtilHelper.height(12), // Scaled vertical padding
                    ),
                    elevation: 2,
                  ),
                  onPressed: () {
                    print('$buttonText button pressed');
                    GoRouter.of(context).pop();
                  },
                  child: Text(
                    buttonText,
                    style: TextStyle(
                      fontSize: ScreenUtilHelper.fontSize(16), // Scaled font size
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Spacer(flex: 2),
              ],
            ),
          ),
          Positioned(
            top: ScreenUtilHelper.height(8), // Scaled positioning
            right: ScreenUtilHelper.width(8), // Scaled positioning
            child: IconButton(
              icon: Icon(Icons.close, color: AppColors.ash, size: ScreenUtilHelper.height(24)), // Scaled icon size
              onPressed: () {
                GoRouter.of(context).pop();
              },
              tooltip: 'Close',
              splashRadius: ScreenUtilHelper.height(20), // Scaled splash radius
            ),
          ),
        ],
      ),
    );
  }
}

void showSuccessDialog(
    BuildContext context,
    String actionType,
    String sendVia,
    ) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(10)), // Scaled border radius
        ),
        insetPadding: EdgeInsets.all(ScreenUtilHelper.width(10)), // Scaled inset padding
        child: SuccessDialogContent(actionType: actionType, sendVia: sendVia),
      );
    },
  );
}

Widget buildSectionTitle(String title) {
  return Padding(
    padding: EdgeInsets.only(bottom: ScreenUtilHelper.height(8)), // Scaled bottom padding
    child: Text(
      title,
      style: TextStyle(
        fontSize: ScreenUtilHelper.fontSize(16), // Scaled font size
        fontWeight: FontWeight.w600,
        color: AppColors.charcoal,
      ),
    ),
  );
}

Widget buildToolbarIcon(IconData icon, VoidCallback onPressed) {
  return IconButton(
    icon: Icon(icon, size: ScreenUtilHelper.height(20)), // Scaled icon size
    onPressed: onPressed,
    padding: EdgeInsets.all(ScreenUtilHelper.width(4)), // Scaled padding
    constraints: const BoxConstraints(),
    visualDensity: VisualDensity.compact,
    splashRadius: ScreenUtilHelper.height(18), // Scaled splash radius
    color: AppColors.slate,
  );
}