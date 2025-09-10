// Your updated time_selection_box.dart file

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ✅ STEP 1: Import the necessary helpers
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/screen_util_helper.dart';

class TimeSelectionBox extends StatefulWidget {
  final String label;
  final void Function(String)? onTimeChanged;
  final String? initialTime;

  const TimeSelectionBox({
    super.key,
    required this.label,
    this.onTimeChanged,
    this.initialTime,
  });

  @override
  _TimeSelectionBoxState createState() => _TimeSelectionBoxState();
}

class _TimeSelectionBoxState extends State<TimeSelectionBox> {
  late final TextEditingController _textEditingController;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(text: widget.initialTime);
    _focusNode.addListener(_onFocusChanged);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.removeListener(_onFocusChanged);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChanged() {
    if (!_focusNode.hasFocus) {
      _formatTime();
    }
  }

  void _formatTime() {
    String cleanedTime =
    _textEditingController.text.replaceAll(RegExp(r'[^0-9:]'), '');
    if (cleanedTime.length > 5) {
      cleanedTime = cleanedTime.substring(0, 5);
    }
    _textEditingController.text = cleanedTime;
    if (widget.onTimeChanged != null) {
      widget.onTimeChanged!(cleanedTime);
    }
  }

  Future<void> _showTimePicker() async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (selectedTime != null) {
      String formattedTime =
          "${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}";
      _textEditingController.text = formattedTime;
      if (widget.onTimeChanged != null) {
        widget.onTimeChanged!(formattedTime);
      }
    }
    _focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    // ✅ Initialize the helper
    //ScreenUtilHelper.init(context);

    return Container(
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
            widget.label,
            style: TextStyle(
              color: AppColors.blackMediumEmphasis,
              fontSize: ScreenUtilHelper.fontSize(14),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: ScreenUtilHelper.width(8)),
              child: TextField(
                controller: _textEditingController,
                focusNode: _focusNode,
                keyboardType: TextInputType.text,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9:]')),
                  LengthLimitingTextInputFormatter(5),
                ],
                style: TextStyle(fontSize: ScreenUtilHelper.fontSize(14)),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'HH:MM',
                  hintStyle: TextStyle(
                      color: AppColors.ash,
                      fontSize: ScreenUtilHelper.fontSize(14)
                  ),
                ),
                onTap: _showTimePicker,
              ),
            ),
          ),
        ],
      ),
    );
  }
}