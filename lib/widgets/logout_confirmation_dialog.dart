// lib/widgets/logout_confirmation_dialog.dart
import 'package:edudibon_flutter_bloc/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

const Color dialogButtonColor = Color(0xFF007AFF); // iOS blue for dialog buttons
const Color dividerColor = Color(0xFFDCDCDC); // Light grey for dividers


class LogoutConfirmationDialog extends StatelessWidget {
  const LogoutConfirmationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent, // Make background transparent
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white, // White background for the inner content
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Shrink to fit content
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Optional: Add an icon at the top if desired
            // Icon(Icons.logout, size: 40, color: Colors.redAccent),
            // const SizedBox(height: 16),

            const Text(
              'Are you sure you want to logout?',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24.0), // Space between text and buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Space out buttons
              children: <Widget>[
                Expanded( // Use Expanded to make buttons fill available width
                  child: TextButton(
                    onPressed: () {
                      GoRouter.of(context).pop(false); // Pop dialog, return false (Cancel)
                    },
                    style: TextButton.styleFrom(
                        foregroundColor: Colors.blueGrey[600], // Greyish text color
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          side: BorderSide(color: Colors.blueGrey[300]!), // Lighter grey border
                        )
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                const SizedBox(width: 16), // Space between buttons
                Expanded( // Use Expanded
                  child: TextButton(
                    onPressed: () {
                      context.go(AppRoutes.otpConfirmation); // Pop dialog, return true (Logout)
                    },
                    style: TextButton.styleFrom(
                        foregroundColor: Colors.redAccent, // Reddish text color
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          side: const BorderSide(color: Colors.redAccent), // Red border
                        )
                    ),
                    child: const Text(
                      'Logout',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Helper function to show the dialog and await result
showLogoutConfirmationDialog(BuildContext context) async {
  return showDialog<bool>( // Return type is bool? (true for confirm, false/null for cancel)
    context: context,
    barrierDismissible: true, // Allow closing by tapping outside
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.0), // Match iOS dialog radius
        ),
        titlePadding: EdgeInsets.zero,
        contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 15),
        actionsPadding: EdgeInsets.zero,
        actionsAlignment: MainAxisAlignment.center,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Log out',
              textAlign: TextAlign.center,
              style: GoogleFonts.openSans( // Apply Google Font
                fontWeight: FontWeight.bold,
                fontSize: 17.0,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Are you sure you want to logout?',
              textAlign: TextAlign.center,
              style: GoogleFonts.openSans( // Apply Google Font
                fontSize: 13.0,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        actions: <Widget>[
          const Divider(height: 1, thickness: 1, color: dividerColor),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                    ),
                    // Return false or null when cancelled
                    onPressed: () => GoRouter.of(dialogContext).pop(false),
                    child: Text(
                      'Cancel',
                      style: GoogleFonts.openSans( // Apply Google Font
                        color: dialogButtonColor,
                        fontSize: 17.0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                const VerticalDivider(width: 1, thickness: 1, color: dividerColor),
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                    ),
                    // Return true when confirmed
                    // onPressed: () => GoRouter.of(dialogContext).pop(true),
                    onPressed: ()=>context.go(AppRoutes.otpConfirmation),
                    child: Text(
                      'Log out',
                      style: GoogleFonts.openSans( // Apply Google Font
                        color: dialogButtonColor,
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}