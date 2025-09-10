// lib/widgets/custom_dropdown.dart
import 'package:flutter/material.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/screen_util_helper.dart'; // ✅ Make sure this is imported

class CustomDropdown extends StatefulWidget {
  final String label;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const CustomDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.value;
  }

  @override
  void didUpdateWidget(covariant CustomDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _selectedValue = widget.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtilHelper.width(6),
        vertical: ScreenUtilHelper.height(6),
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.silver),
          borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8.0)),
        ),
        child: DropdownButtonFormField<String>(
          decoration: InputDecoration(
            hintText: widget.label,
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(
              horizontal: ScreenUtilHelper.width(12),
              vertical: ScreenUtilHelper.height(14),
            ),
          ),
          value: _selectedValue,
          isExpanded: true,
          menuMaxHeight: ScreenUtilHelper.height(300),
          items: widget.items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: TextStyle(fontSize: ScreenUtilHelper.fontSize(14)),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _selectedValue = newValue;
            });
            widget.onChanged(newValue);
          },
          dropdownColor: AppColors.white,
          style: TextStyle(
            color: AppColors.black,
            fontSize: ScreenUtilHelper.fontSize(14),
          ),
        ),
      ),
    );
  }
}
