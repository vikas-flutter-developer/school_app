import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/screen_util_helper.dart'; // ScreenUtilHelper

Future<bool?> showConfirmationDialog(
    BuildContext context, {
      String title = 'Are you sure?',
      String content = 'Do you want to proceed?',
      String confirmText = 'Yes',
      String cancelText = 'No',
    }) async {
  ScreenUtilHelper.init(context); // ScreenUtilHelper

  return showDialog<bool>(
    context: context,
    barrierDismissible: false, // User must tap button
    builder: (BuildContext context) {
      return AlertDialog(
        alignment: Alignment.center,
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(15.0)), // ScreenUtilHelper
        ), // Rounded corners
        title: Text(title),
        content: Text(content),
        actionsAlignment: MainAxisAlignment.center,
        actions: <Widget>[
          TextButton(
            child: Text(cancelText),
            onPressed: () {
              GoRouter.of(context).pop(false); // Return false on cancel
            },
          ),
          ElevatedButton(
            // Match mockup style
            style: ElevatedButton.styleFrom(
              backgroundColor:AppColors.primaryMedium, // Or your specific blue
              foregroundColor: AppColors.white,
            ),
            onPressed: () {
              GoRouter.of(context).pop(true); // Return true on confirm
            },
            // Match mockup style
            child: Text(confirmText),
          ),
        ],
        actionsPadding: EdgeInsets.symmetric(
          horizontal: ScreenUtilHelper.width(16.0), // ScreenUtilHelper
          vertical: ScreenUtilHelper.height(8.0), // ScreenUtilHelper
        ), // Adjust padding
      );
    },
  );
}


// --- Usage Example ---
// onPressed: () async {
//   final confirmed = await showConfirmationDialog(
//      context,
//      content: 'Are you sure you want to cancel this request?'
//   );
//   if (confirmed == true) {
//      // Proceed with cancellation logic
//   }
// }
