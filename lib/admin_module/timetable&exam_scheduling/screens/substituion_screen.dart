// Your updated substitution_screen.dart file

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ✅ STEP 1: Import the necessary helpers
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/screen_util_helper.dart';

class SubstitutionScreen extends StatefulWidget {
  const SubstitutionScreen({super.key});

  @override
  State<SubstitutionScreen> createState() => _SubstitutionScreenState();
}

class _SubstitutionScreenState extends State<SubstitutionScreen> {
  DateTime? _selectedDate;
  String? _staffOnLeave;
  String? _substituteStaff;

  final List<String> staffList = ['R Divya', 'S Kumar', 'P Verma', 'A Sharma', 'M Patel'];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2025),
      lastDate: DateTime(2026),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Widget _buildRow(String label, Widget content) {
    return Padding(
      // ✅ Use helper for padding
      padding: EdgeInsets.only(bottom: ScreenUtilHelper.height(24)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              // ✅ Use helper for font size
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: ScreenUtilHelper.fontSize(14)),
            ),
          ),
          SizedBox(width: ScreenUtilHelper.width(16)),
          Expanded(
            flex: 3,
            child: content,
          ),
        ],
      ),
    );
  }

  Widget _buildDateSelector() {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: Container(
        // ✅ Use helper for padding and radius
        padding: EdgeInsets.symmetric(
            horizontal: ScreenUtilHelper.width(12),
            vertical: ScreenUtilHelper.height(10)),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.silver),
          borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _selectedDate != null
                  ? DateFormat('dd MMM, yyyy').format(_selectedDate!)
                  : 'Select Date',
              style: TextStyle(
                color: _selectedDate != null ? AppColors.black : AppColors.ash,
                fontSize: ScreenUtilHelper.fontSize(14),
              ),
            ),
            Icon(Icons.calendar_today_outlined,
                size: ScreenUtilHelper.scaleAll(20)),
          ],
        ),
      ),
    );
  }

  Widget _buildStaffDropdown(
      String? value, String hint, ValueChanged<String?> onChanged) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8)),
        ),
        contentPadding: EdgeInsets.symmetric(
            horizontal: ScreenUtilHelper.width(12),
            vertical: ScreenUtilHelper.height(10)),
      ),
      value: value,
      hint: Text(hint, style: TextStyle(fontSize: ScreenUtilHelper.fontSize(14))),
      items: staffList.map((staff) {
        return DropdownMenuItem<String>(
          value: staff,
          child: Text(staff, style: TextStyle(fontSize: ScreenUtilHelper.fontSize(14))),
        );
      }).toList(),
      onChanged: onChanged,
      isExpanded: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    // ✅ Initialize the helper (ideally in a parent widget)
    ScreenUtilHelper.init(context);

    return Padding(
      padding: EdgeInsets.all(ScreenUtilHelper.scaleAll(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRow('Select Schedule Date', _buildDateSelector()),
          _buildRow(
            'Staff on leave',
            _buildStaffDropdown(
              _staffOnLeave,
              'Select Staff',
                  (newValue) => setState(() => _staffOnLeave = newValue),
            ),
          ),
          _buildRow(
            'Substitute Staff',
            _buildStaffDropdown(
              _substituteStaff,
              'Select Substitute Staff',
                  (newValue) => setState(() => _substituteStaff = newValue),
            ),
          ),
          const Spacer(),
          Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
              onPressed: () {
                if (_selectedDate != null &&
                    _staffOnLeave != null &&
                    _substituteStaff != null) {
                  // Save logic
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please select date and staff.')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryDark,
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtilHelper.width(32),
                    vertical: ScreenUtilHelper.height(12)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8)),
                ),
              ),
              child: Text(
                'Save',
                style: TextStyle(
                    color: AppColors.white,
                    fontSize: ScreenUtilHelper.fontSize(14)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}