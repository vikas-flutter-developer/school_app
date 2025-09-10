import '../../../core/utils/app_decorations.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_styles.dart';
import '../../../core/utils/screen_util_helper.dart'; // Make sure this is imported
import 'package:flutter/material.dart';

class ChapterDropdown extends StatefulWidget {
  final List<String> chapters;
  final String chapterTitle;

  const ChapterDropdown({
    super.key,
    required this.chapters,
    required this.chapterTitle,
  });

  @override
  _ChapterDropdownState createState() => _ChapterDropdownState();
}

class _ChapterDropdownState extends State<ChapterDropdown> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: ScreenUtilHelper.scaleHeight(8.0),
        horizontal: ScreenUtilHelper.scaleWidth(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtilHelper.scaleWidth(12),
                vertical: ScreenUtilHelper.scaleHeight(8),
              ),
              decoration: BoxDecoration(
                color: AppColors.primaryLightest,
                borderRadius: AppDecorations.smallRadius,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.chapterTitle),
                  Icon(_isExpanded
                      ? Icons.arrow_drop_up
                      : Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0.0, end: _isExpanded ? 1.0 : 0.0),
            duration: Duration(milliseconds: 300),
            builder: (context, value, child) {
              return ClipRect(
                child: Align(
                  heightFactor: value,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtilHelper.scaleWidth(8.0),
                    ),
                    child: child,
                  ),
                ),
              );
            },
            child: Column(
              children: widget.chapters.map((String chapter) {
                String chapterName = 'Lorem ipsum';
                String status =
                chapter == '1.6' ? 'Pending' : 'Completed';

                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtilHelper.scaleWidth(12),
                    vertical: ScreenUtilHelper.scaleHeight(8),
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: AppColors.silver,
                        width: ScreenUtilHelper.scaleWidth(1.0),
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(chapter),
                          SizedBox(width: ScreenUtilHelper.scaleWidth(8)),
                          Text(chapterName),
                        ],
                      ),
                      Text(
                        status,
                        style: AppStyles.small.copyWith(
                          color: chapter == '1.6'
                              ? AppColors.error
                              : AppColors.success,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
