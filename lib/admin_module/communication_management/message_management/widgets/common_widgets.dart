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
    // Initialize ScreenUtilHelper
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
      width: ScreenUtilHelper.width(336), // Adjust width for responsiveness
      height: ScreenUtilHelper.height(337), // Adjust height for responsiveness
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(10)), // Scaled border radius
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.1),
            blurRadius: ScreenUtilHelper.width(10), // Adjusted blur radius
            spreadRadius: ScreenUtilHelper.width(1), // Adjusted spread radius
          ),
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtilHelper.width(24), // Adjusted padding
              vertical: ScreenUtilHelper.height(20), // Adjusted vertical padding
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Spacer(flex: 2),

                // --- IMAGE ADDED HERE ---
                Image.asset(
                  'assets/images/dialogbox.png',
                  width: ScreenUtilHelper.width(85),
                  height: ScreenUtilHelper.height(85),

                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.image_not_supported,
                      size: ScreenUtilHelper.width(85),
                      color: AppColors.error,
                    );
                  },
                ),
                // --- END OF IMAGE ---

                SizedBox(height: ScreenUtilHelper.height(20)), // Adjusted spacing after image
                Text(
                  title,
                  style: TextStyle(
                    fontSize: ScreenUtilHelper.fontSize(16), // Adjusted font size
                    fontWeight: AppStyles.weight.emphasis,
                    color: AppColors.graphite,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: ScreenUtilHelper.height(12)), // Adjusted spacing
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: ScreenUtilHelper.fontSize(15), // Adjusted font size
                    color: AppColors.graphite,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Spacer(flex: 1),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.tertiaryAccent,
                    foregroundColor: AppColors.white,
                    minimumSize: Size(
                      ScreenUtilHelper.width(180), // Adjusted width
                      ScreenUtilHelper.height(48), // Adjusted height
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(6)), // Adjusted radius
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtilHelper.width(25), // Adjusted horizontal padding
                      vertical: ScreenUtilHelper.height(12), // Adjusted vertical padding
                    ),
                    elevation: ScreenUtilHelper.width(2), // Adjusted elevation
                  ),
                  onPressed: () {
                    print('$buttonText button pressed');
                    GoRouter.of(context).pop();
                  },
                  child: Text(
                    buttonText,
                    style: TextStyle(
                      fontSize: ScreenUtilHelper.fontSize(16), // Adjusted font size
                      fontWeight: AppStyles.weight.medium,
                    ),
                  ),
                ),
                const Spacer(flex: 2),
              ],
            ),
          ),
          Positioned(
            top: ScreenUtilHelper.height(8), // Adjusted positioning
            right: ScreenUtilHelper.width(8), // Adjusted positioning
            child: IconButton(
              icon: Icon(Icons.close, color: AppColors.ash, size: ScreenUtilHelper.width(24)), // Adjusted icon size
              onPressed: () {
                GoRouter.of(context).pop();
              },
              tooltip: 'Close',
              splashRadius: ScreenUtilHelper.width(20), // Adjusted splash radius
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
          borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(10)), // Adjusted radius
        ),
        insetPadding: EdgeInsets.all(ScreenUtilHelper.width(10)), // Adjusted padding
        child: SuccessDialogContent(actionType: actionType, sendVia: sendVia),
      );
    },
  );
}

Widget buildSectionTitle(String title) {
  return Padding(
    padding: EdgeInsets.only(bottom: ScreenUtilHelper.height(8)), // Adjusted padding
    child: Text(
      title,
      style: TextStyle(
        fontSize: ScreenUtilHelper.fontSize(16), // Adjusted font size
        fontWeight: FontWeight.w600,
        color: AppColors.graphite,
      ),
    ),
  );
}

Widget buildToolbarIcon(IconData icon, VoidCallback onPressed) {
  return IconButton(
    icon: Icon(icon, size: ScreenUtilHelper.width(20)), // Adjusted icon size
    onPressed: onPressed,
    padding: EdgeInsets.all(ScreenUtilHelper.width(4)), // Adjusted padding
    constraints: const BoxConstraints(),
    visualDensity: VisualDensity.compact,
    splashRadius: ScreenUtilHelper.width(18), // Adjusted splash radius
    color: AppColors.slate,
  );
}