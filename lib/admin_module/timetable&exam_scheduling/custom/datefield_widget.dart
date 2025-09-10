// Your updated date_field_widget.dart file

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ✅ STEP 1: Import the necessary helpers
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/screen_util_helper.dart';

class DateFieldWidget extends StatefulWidget {
  const DateFieldWidget({super.key});

  @override
  State<DateFieldWidget> createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DateFieldWidget> {
  DateTime? _selectedDate;
  final TextEditingController _dateController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('dd-MM-yyyy').format(_selectedDate!);
      });
    }
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ✅ Initialize the helper if not done in a parent widget
    //ScreenUtilHelper.init(context);

    return Container(
      // ✅ Use helper for all dimensions
      height: ScreenUtilHelper.height(40),
      width: ScreenUtilHelper.width(130),
      padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.width(8)),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.blackHint),
        borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(4)),
        color: AppColors.white,
      ),
      child: InkWell(
        onTap: () => _selectDate(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextField(
                controller: _dateController,
                enabled: false,
                decoration: InputDecoration(
                  hintText: 'Select Date',
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    color: AppColors.blackMediumEmphasis,
                    fontSize: ScreenUtilHelper.fontSize(14),
                  ),
                ),
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: ScreenUtilHelper.fontSize(14),
                ),
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