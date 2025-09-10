import 'package:flutter/material.dart';
import 'package:edudibon_flutter_bloc/core/utils/app_colors.dart';
import '../../../core/utils/app_styles.dart';
import '../../../core/utils/screen_util_helper.dart';

class CalendarGrid extends StatelessWidget {
  final Function(DateTime?)? onDateTap;
  final DateTime focusedDay;
  final DateTime? selectedDay;

  const CalendarGrid({
    super.key,
    this.onDateTap,
    required this.focusedDay,
    this.selectedDay,
  });

  List<Map<String, dynamic>> _generateCalendarDataForMonth(DateTime month) {
    final List<List<Map<String, dynamic>>> staticData = [
      [
        {'text': 'M', 'color': AppColors.transparent, 'isHeader': true},
        {'text': 'T', 'color': AppColors.transparent, 'isHeader': true},
        {'text': 'W', 'color': AppColors.transparent, 'isHeader': true},
        {'text': 'T', 'color': AppColors.transparent, 'isHeader': true},
        {'text': 'F', 'color': AppColors.transparent, 'isHeader': true},
        {'text': 'S', 'color': AppColors.transparent, 'isHeader': true},
        {'text': 'S', 'color': AppColors.transparent, 'isHeader': true},
      ],
      [
        {'text': '', 'color': AppColors.transparent},
        {'text': '1', 'color': AppColors.mintGreen},
        {'text': '2', 'color': AppColors.mintGreen},
        {'text': '3', 'color': AppColors.mintGreen},
        {'text': '4', 'color': AppColors.mintGreen},
        {'text': '5', 'color': AppColors.mintGreen},
        {'text': '6', 'color': AppColors.white},
      ],
      [
        {'text': '7', 'color': AppColors.mintGreen},
        {'text': '8', 'color': AppColors.mintGreen},
        {'text': '9', 'color': Colors.grey.shade400},
        {'text': '10', 'color': AppColors.mintGreen},
        {'text': '11', 'color': AppColors.paymentLeadingBg},
        {'text': '12', 'color': AppColors.mintGreen},
        {'text': '13', 'color': AppColors.white},
      ],
      [
        {'text': '14', 'color': AppColors.mintGreen},
        {'text': '15', 'color': AppColors.pendingLight},
        {'text': '16', 'color': AppColors.mintGreen},
        {'text': '17', 'color': AppColors.mintGreen},
        {'text': '18', 'color': AppColors.paymentLeadingBg},
        {'text': '19', 'color': AppColors.mintGreen},
        {'text': '20', 'color': AppColors.white},
      ],
      [
        {'text': '21', 'color': AppColors.mintGreen},
        {'text': '22', 'color': AppColors.ash},
        {'text': '23', 'color': AppColors.mintGreen},
        {'text': '24', 'color': AppColors.mintGreen},
        {'text': '25', 'color': AppColors.paymentLeadingBg},
        {'text': '26', 'color': AppColors.mintGreen},
        {'text': '27', 'color': AppColors.white},
      ],
      [
        {'text': '28', 'color': AppColors.mintGreen},
        {'text': '29', 'color': AppColors.mintGreen},
        {'text': '30', 'color': AppColors.mintGreen},
        {'text': '31', 'color': AppColors.mintGreen},
        {'text': '', 'color': AppColors.transparent},
        {'text': '', 'color': AppColors.transparent},
        {'text': '', 'color': AppColors.transparent},
      ],
    ];
    return staticData.expand((row) => row).toList();
  }

  @override
  Widget build(BuildContext context) {

    final flatList = _generateCalendarDataForMonth(focusedDay);

    return Container(
      padding: EdgeInsets.all(ScreenUtilHelper.scaleWidth(8)),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleRadius(10)),
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
          childAspectRatio: 1.0,
        ),
        itemCount: flatList.length,
        itemBuilder: (context, index) {
          final cellData = flatList[index];
          final text = cellData['text'] as String;
          final color = cellData['color'] as Color;
          final bool isHeader = cellData['isHeader'] ?? false;
          final bool isEmpty = text.isEmpty;

          DateTime? cellDate;
          try {
            if (!isHeader && !isEmpty) {
              int dayNum = int.parse(text);
              cellDate = DateTime(focusedDay.year, focusedDay.month, dayNum);
            }
          } catch (_) {}

          bool isSelected = selectedDay != null &&
              cellDate != null &&
              DateUtils.isSameDay(selectedDay, cellDate);

          bool isToday =
              cellDate != null && DateUtils.isSameDay(DateTime.now(), cellDate);

          Widget cellContent = Container(
            decoration: BoxDecoration(
              color: isSelected
                  ? Theme.of(context).primaryColor.withOpacity(0.3)
                  : color,
              shape: BoxShape.circle,
              border: isToday
                  ? Border.all(
                color: Theme.of(context).primaryColor,
                width: ScreenUtilHelper.scaleWidth(1.5),
              )
                  : null,
            ),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  color: isHeader || color == AppColors.transparent
                      ? AppColors.stone
                      : isSelected
                      ? Theme.of(context).primaryColorDark
                      : AppColors.blackHighEmphasis,
                  fontSize: isHeader
                      ? ScreenUtilHelper.scaleText(11)
                      : ScreenUtilHelper.scaleText(13),
                  fontWeight: isHeader
                      ? AppStyles.weight.heading
                      : (isSelected || isToday
                      ? AppStyles.weight.emphasis
                      : AppStyles.weight.regular),
                ),
              ),
            ),
          );

          if (onDateTap != null &&
              !isHeader &&
              !isEmpty &&
              cellDate != null) {
            return GestureDetector(
              onTap: () => onDateTap!(cellDate),
              child: cellContent,
            );
          } else {
            return cellContent;
          }
        },
      ),
    );
  }
}
