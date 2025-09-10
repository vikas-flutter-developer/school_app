
import 'package:flutter/material.dart';

// ✅ STEP 1: Import the necessary helpers
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/screen_util_helper.dart';

class DateSelectionBox extends StatefulWidget {
  final String label;
  final ValueChanged<DateTime> onDateSelected;

  const DateSelectionBox({
    super.key,
    required this.label,
    required this.onDateSelected,
  });

  @override
  State<DateSelectionBox> createState() => _DateSelectionBoxState();
}

class _DateSelectionBoxState extends State<DateSelectionBox> {
  DateTime? selectedDate;

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
      widget.onDateSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    // ✅ Initialize the helper if not done in a parent widget
    ScreenUtilHelper.init(context);

    return GestureDetector(
      onTap: () => _pickDate(context),
      child: Container(
        // ✅ Use helper for all dimensions
        height: ScreenUtilHelper.height(40),
        padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.width(8)),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.blackHint),
          borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(4)),
          color: AppColors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedDate != null
                  ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                  : widget.label,
              style: TextStyle(
                color: AppColors.blackMediumEmphasis,
                fontSize: ScreenUtilHelper.fontSize(14),
              ),
            ),
            Icon(
              Icons.calendar_today,
              size: ScreenUtilHelper.scaleAll(18),
            ),
          ],
        ),
      ),
    );
  }
}