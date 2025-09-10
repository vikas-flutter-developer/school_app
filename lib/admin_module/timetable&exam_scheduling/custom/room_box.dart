// Your updated room_selection_box.dart file

import 'package:flutter/material.dart';

// ✅ STEP 1: Import the necessary helpers
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/screen_util_helper.dart';

class RoomSelectionBox extends StatelessWidget {
  final String room;
  final void Function(String?)? onChanged;

  const RoomSelectionBox({
    super.key,
    required this.room,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    // ✅ Initialize the helper
    //ScreenUtilHelper.init(context);

    return Container(
      // ✅ Use helper for padding and radius
      padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.width(12)),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.blackHint),
        borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(4)),
        color: AppColors.white,
      ),
      child: DropdownButton<String>(
        value: room,
        isExpanded: true,
        underline: const SizedBox(),
        // ✅ Use helper for icon size
        icon: Icon(Icons.keyboard_arrow_down, size: ScreenUtilHelper.scaleAll(24)),
        // ✅ Define style for dropdown items
        style: TextStyle(
          color: AppColors.black, // Set your desired text color
          fontSize: ScreenUtilHelper.fontSize(14),
        ),
        items: [
          DropdownMenuItem(
            value: room,
            child: Text(room),
          ),
        ],
        onChanged: onChanged,
      ),
    );
  }
}