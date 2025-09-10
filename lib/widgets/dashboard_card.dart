// lib/widgets/dashboard_card.dart // Ensure this imports correctly
// import 'package:flutter/material.dart';
//
// import '../admin_module/tab_bars/data/dashboard_data.dart';
//
// class DashboardCard extends StatelessWidget {
//   final DashboardItem item;
//   final VoidCallback onTap;
//
//   // Define the primary icon color (Matches the UI screenshot's purple-ish blue)
//   // TODO: Consider moving this color to your app's theme or a constants file
//   static const Color primaryIconColor = Color(0xFF6A5ACD); // Example: SlateBlue like color
//
//   const DashboardCard({
//     required this.item,
//     required this.onTap,
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       // Use Card directly for background, shadow, and shape
//       margin: EdgeInsets.zero, // GridView provides spacing, so no margin needed here
//       elevation: 1.5, // Subtle shadow, adjust as needed (1.0 to 2.0)
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12.0), // Slightly more rounded corners like UI
//         // Optional: Add a very light border if needed
//         // side: BorderSide(color: Colors.grey.shade300, width: 0.5),
//       ),
//       clipBehavior: Clip.antiAlias, // Ensures InkWell ripple stays within bounds
//       child: InkWell(
//         onTap: onTap,
//         // No need for borderRadius here as Card clips it
//         child: Stack( // Use Stack to layer the arrow icon
//           children: [
//             // --- Main Content ---
//             Padding(
//               // Add padding for the internal content (icon and text)
//               // Leave space at the bottom/right for the arrow
//               padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0, bottom: 30.0), // Increased bottom padding
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start, // Align content to the top
//                 crossAxisAlignment: CrossAxisAlignment.start, // Align icon/text left
//                 children: [
//                   Icon(
//                     item.icon, // Make sure item.icon is of type IconData
//                     size: 30.0, // Adjusted size
//                     color: primaryIconColor, // Use consistent color
//                   ),
//                   const SizedBox(height: 10.0), // Space between icon and text
//                   // Text does not need Expanded here
//                   Text(
//                     item.title,
//                     style: const TextStyle(
//                       fontSize: 13.0, // Adjusted font size
//                       fontWeight: FontWeight.w500, // Medium weight
//                       color: Colors.black87,
//                     ),
//                     textAlign: TextAlign.left,
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ],
//               ),
//             ),
//
//             // --- Arrow Icon ---
//             Positioned(
//               bottom: 10.0, // Distance from bottom edge
//               right: 10.0,  // Distance from right edge
//               child: Icon(
//                 Icons.north_east_rounded, // Icon that points up-right (closer match)
//                 size: 18.0, // Adjusted size for the arrow
//                 color: primaryIconColor, // Use consistent color
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

/* */
import 'package:edudibon_flutter_bloc/core/utils/app_colors.dart';
import 'package:edudibon_flutter_bloc/core/utils/screen_util_helper.dart';
import 'package:flutter/material.dart';

class DashboardCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final BoxFit fitImage;

  const DashboardCard({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.fitImage = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: ScreenUtilHelper.width(50), // smaller width
        height: ScreenUtilHelper.width(50), // smaller height
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black.withOpacity(0.3), width: 1.0),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Stack(
          children: [
            // Main content column (icon + title)
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icon, // Make sure item.icon is of type IconData
                    size: 30.0, // Adjusted size
                    color: AppColors.primaryDark, // Use consistent color
                  ),
                  const SizedBox(height: 6), // smaller gap
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: ScreenUtilHelper.fontSize(12),
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            // Bottom right arrow
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(
                'assets/images/arrow.png',
                width: ScreenUtilHelper.width(32), // big arrow
                height: ScreenUtilHelper.width(32),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
